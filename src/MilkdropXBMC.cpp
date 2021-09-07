/*
 *  Copyright (C) 2004-2021 Team Kodi (https://kodi.tv)
 *
 *  SPDX-License-Identifier: GPL-2.0-or-later
 *  See LICENSE.md for more information.
 */

#include "vis_milkdrop/plugin.h"
#include <kodi/addon-instance/Visualization.h>
#include <string>
#include <direct.h>
#include <d3d11.h>

CPlugin* g_plugin = nullptr;

void replaceAll(std::string& str, const std::string& from, const std::string& to)
{
  if (from.empty())
    return;
  size_t start_pos = 0;
  while ((start_pos = str.find(from, start_pos)) != std::string::npos) {
    str.replace(start_pos, from.length(), to);
    start_pos += to.length();
  }
}

void urlEscape(std::string& str)
{
  if (str.empty())
    return;

  // 'url encode';
  replaceAll(str, "%",  "%25");
  replaceAll(str, "\\", "%2F");
  replaceAll(str, "\"", "%22");
  replaceAll(str, ":",  "%3A");
  replaceAll(str, "`",  "%60");
  replaceAll(str, "&",  "%26");
  replaceAll(str, "{",  "%7B");
  replaceAll(str, "}",  "%7D");
  replaceAll(str, "]",  "%5D");
  replaceAll(str, "[",  "%5B");
  replaceAll(str, "<",  "%3C");
  replaceAll(str, ">",  "%3E");
  replaceAll(str, "#",  "%23");
}

class ATTRIBUTE_HIDDEN CVisualizationMilkdrop
  : public kodi::addon::CAddonBase
  , public kodi::addon::CInstanceVisualization
{
public:
  ~CVisualizationMilkdrop() override;

  ADDON_STATUS Create() override;
  void Stop() override;
  void Render() override;
  bool GetPresets(std::vector<std::string>& presets) override;
  int GetActivePreset() override;
  bool IsLocked() override;
  bool PrevPreset() override;
  bool NextPreset() override;
  bool LoadPreset(int select) override;
  bool RandomPreset() override;
  bool LockPreset(bool lockUnlock) override;
  void AudioData(const float* audioData, int audioDataLength, float *freqData, int freqDataLength) override;
  ADDON_STATUS SetSetting(const std::string& settingName, const kodi::CSettingValue& settingValue) override;

private:
  void SetPresetDir(const char *pack);

  bool m_UserPackFolder;
  std::string m_presetsDir;
  std::string m_lastPresetDir;
  int m_lastPresetIndx = 0;
  bool m_lastLockedStatus = false;
};

// Sets a new preset file or directory and make it active. Also recovers last state of the preset if it is the same as last time
void CVisualizationMilkdrop::SetPresetDir(const char *pack)
{
  int len = strlen(pack);
  if (len >= 4 && strcmp(pack + len - 4, ".zip") == 0)
  {
    // Zip file
    strcpy(g_plugin->m_szPresetDir, m_presetsDir.c_str());
    strcat(g_plugin->m_szPresetDir, pack);
    strcat(g_plugin->m_szPresetDir, "/");
  }
  else if (len >= 4 && strcmp(pack + len - 4, ".rar") == 0)
  {
    // Rar file
    strcpy(g_plugin->m_szPresetDir, m_presetsDir.c_str());
    strcat(g_plugin->m_szPresetDir, pack);
    strcat(g_plugin->m_szPresetDir, "/");
  }
  else
  {
    // Normal folder
    strcpy(g_plugin->m_szPresetDir,  pack);
  }
  if (strcmp (g_plugin->m_szPresetDir, m_lastPresetDir.c_str()) == 0)
  {
    // If we have a valid last preset state AND the preset file(dir) is the same as last time
    g_plugin->UpdatePresetList();
    if (g_plugin->m_pPresetAddr)
    {
      g_plugin->m_bHoldPreset = m_lastLockedStatus;
      if (m_lastPresetIndx < 0 || m_lastPresetIndx >(g_plugin->m_nPresets - g_plugin->m_nDirs))
        m_lastPresetIndx = 0;
      g_plugin->m_nCurrentPreset = m_lastPresetIndx;
      strcpy(g_plugin->m_szCurrentPresetFile, g_plugin->m_szPresetDir);
      strcat(g_plugin->m_szCurrentPresetFile, g_plugin->m_pPresetAddr[g_plugin->m_nCurrentPreset]);
      g_plugin->LoadPreset(g_plugin->m_szCurrentPresetFile, g_plugin->m_fBlendTimeUser);
    }
  }
  else
    // If it is the first run or a newly chosen preset pack we choose a random preset as first
    g_plugin->LoadRandomPreset(g_plugin->m_fBlendTimeUser);
}

//-- Create -------------------------------------------------------------------
// Called on load. Addon should fully initalize or return error status
// !!! Add-on master function !!!
//-----------------------------------------------------------------------------
ADDON_STATUS CVisualizationMilkdrop::Create()
{
  _mkdir(Profile().c_str());

  std::string presets = Presets().append("\\presets\\");
  urlEscape(presets);
  m_presetsDir = "zip://" + presets;

  if (!g_plugin)
  {
    g_plugin = new CPlugin;
    g_plugin->PluginPreInitialize(0, 0);
  }

  g_plugin->m_fBlendTimeAuto = kodi::GetSettingFloat("Automatic Blend Time");
  g_plugin->m_fTimeBetweenPresets = kodi::GetSettingFloat("Time Between Presets");
  g_plugin->m_fTimeBetweenPresetsRand = kodi::GetSettingFloat("Additional Random Time");
  g_plugin->m_bHardCutsDisabled = !kodi::GetSettingBoolean("Enable Hard Cuts");
  g_plugin->m_fHardCutLoudnessThresh = kodi::GetSettingFloat("Loudness Threshold For Hard Cuts");
  g_plugin->m_fHardCutHalflife = kodi::GetSettingFloat("Average Time Between Hard Cuts");
  g_plugin->m_max_fps_fs = kodi::GetSettingFloat("Maximum Refresh Rate");
  g_plugin->m_bAlways3D = kodi::GetSettingBoolean("Enable Stereo 3d");
  m_lastLockedStatus = kodi::GetSettingBoolean("lastlockedstatus");
  m_lastPresetIndx = kodi::GetSettingInt("lastpresetidx");
  m_lastPresetDir = kodi::GetSettingString("lastpresetfolder");
  g_plugin->m_bSequentialPresetOrder = !kodi::GetSettingBoolean("Preset Shuffle Mode");
  switch (kodi::GetSettingInt("Preset Pack"))
  {
    case 0:
      m_UserPackFolder = false;
      SetPresetDir("WA51-presets(265).zip");
      break;

    case 1:
      m_UserPackFolder = false;
      SetPresetDir("Winamp-presets(436).zip");
      break;

    case 2:
      m_UserPackFolder = true;
      SetPresetDir(kodi::GetSettingString("User Preset Folder").c_str());
      break;
  }

  if (!g_plugin || !g_plugin->PluginInitialize(static_cast<ID3D11DeviceContext*>(Device()), X(), Y(), Width(), Height(), PixelRatio()))
    return ADDON_STATUS_UNKNOWN;

  return ADDON_STATUS_OK;
}

void CVisualizationMilkdrop::Stop()
{
  if(g_plugin)
  {
    kodi::SetSettingString("lastpresetfolder", g_plugin->m_szPresetDir);
    kodi::SetSettingBoolean("lastlockedstatus", g_plugin->m_bHoldPreset);
    kodi::SetSettingInt("lastpresetidx", g_plugin->m_nCurrentPreset);

    g_plugin->PluginQuit();
    delete g_plugin;
    g_plugin = nullptr;
  }
}

unsigned char waves[2][512];

//-- Audiodata ----------------------------------------------------------------
// Called by XBMC to pass new audio data to the vis
//-----------------------------------------------------------------------------
void CVisualizationMilkdrop::AudioData(const float* pAudioData, int iAudioDataLength, float *pFreqData, int iFreqDataLength)
{
  int ipos=0;
  while (ipos < 512)
  {
    for (int i=0; i < iAudioDataLength; i+=2)
    {
      waves[0][ipos] = char (pAudioData[i] * 255.0f);
      waves[1][ipos] = char (pAudioData[i+1]  * 255.0f);
      ipos++;
      if (ipos >= 512) break;
    }
  }
}

void CVisualizationMilkdrop::Render()
{
  g_plugin->PluginRender(waves[0], waves[1]);

}

bool CVisualizationMilkdrop::NextPreset()
{
  g_plugin->LoadNextPreset(g_plugin->m_fBlendTimeUser);
  return true;
}

bool CVisualizationMilkdrop::PrevPreset()
{
  g_plugin->LoadPreviousPreset(g_plugin->m_fBlendTimeUser);
  return true;
}

bool CVisualizationMilkdrop::LoadPreset(int select)
{
  g_plugin->m_nCurrentPreset = select;
  strcpy(g_plugin->m_szCurrentPresetFile, g_plugin->m_szPresetDir);  // note: m_szPresetDir always ends with '\'
  strcat(g_plugin->m_szCurrentPresetFile, g_plugin->m_pPresetAddr[g_plugin->m_nCurrentPreset]);
  g_plugin->LoadPreset(g_plugin->m_szCurrentPresetFile, g_plugin->m_fBlendTimeUser);
  return true;
}

bool CVisualizationMilkdrop::LockPreset(bool lockUnlock)
{
  g_plugin->m_bHoldPreset = !g_plugin->m_bHoldPreset;
  return true;
}

bool CVisualizationMilkdrop::RandomPreset()
{
  g_plugin->LoadRandomPreset(g_plugin->m_fBlendTimeUser);
  return true;
}

//-- GetPresets ---------------------------------------------------------------
// Return a list of presets to XBMC for display
//-----------------------------------------------------------------------------
bool CVisualizationMilkdrop::GetPresets(std::vector<std::string>& presets)
{
  if (!g_plugin)
    return false;
  for (int i = 0; i < g_plugin->m_nPresets; ++i)
    presets.push_back(g_plugin->m_pPresetAddr[i]);
  return true;
}

//-- GetActivePreset ----------------------------------------------------------
// Return the index of the current playing preset
//-----------------------------------------------------------------------------
int CVisualizationMilkdrop::GetActivePreset()
{
  if (g_plugin)
    return g_plugin->m_nCurrentPreset;
  return -1;
}

//-- IsLocked -----------------------------------------------------------------
// Returns true if this add-on use settings
//-----------------------------------------------------------------------------
bool CVisualizationMilkdrop::IsLocked()
{
  if(g_plugin)
    return g_plugin->m_bHoldPreset;
  else
    return false;
}

//-- Destroy-------------------------------------------------------------------
// Do everything before unload of this add-on
// !!! Add-on master function !!!
//-----------------------------------------------------------------------------
CVisualizationMilkdrop::~CVisualizationMilkdrop()
{
  Stop();
}

//-- UpdateSetting ------------------------------------------------------------
// Handle setting change request from XBMC
//-----------------------------------------------------------------------------
ADDON_STATUS CVisualizationMilkdrop::SetSetting(const std::string& settingName, const kodi::CSettingValue& settingValue)
{
  if (settingName.empty() || settingValue.empty() || !g_plugin)
    return ADDON_STATUS_UNKNOWN;

  if (settingName == "Automatic Blend Time")
    g_plugin->m_fBlendTimeAuto = settingValue.GetFloat();
  else if (settingName == "Time Between Presets")
    g_plugin->m_fTimeBetweenPresets = settingValue.GetFloat();
  else if (settingName == "Additional Random Time")
    g_plugin->m_fTimeBetweenPresetsRand = settingValue.GetFloat();
  else if (settingName == "Enable Hard Cuts")
    g_plugin->m_bHardCutsDisabled = !settingValue.GetBoolean();
  else if (settingName == "Loudness Threshold For Hard Cuts")
    g_plugin->m_fHardCutLoudnessThresh = settingValue.GetFloat();
  else if (settingName == "Average Time Between Hard Cuts")
    g_plugin->m_fHardCutHalflife = settingValue.GetFloat();
  else if (settingName == "Maximum Refresh Rate")
    g_plugin->m_max_fps_fs = settingValue.GetInt();
  else if (settingName == "Enable Stereo 3d")
    g_plugin->m_bAlways3D = settingValue.GetBoolean();
  else if (settingName == "lastlockedstatus")
    m_lastLockedStatus = settingValue.GetBoolean();
  else if (settingName == "lastpresetidx")
    m_lastPresetIndx = settingValue.GetInt();
  else if (settingName == "lastpresetfolder")
    m_lastPresetDir = settingValue.GetString();
  else if (settingName == "Preset Shuffle Mode")
    g_plugin->m_bSequentialPresetOrder = !settingValue.GetBoolean();
  else if (settingName == "Preset Pack")
  {
    if (settingValue.GetInt() == 0)
      {
      m_UserPackFolder = false;;
      SetPresetDir ("WA51-presets(265).zip");
      }
    else if (settingValue.GetInt() == 1)
    {
      m_UserPackFolder = false;
      SetPresetDir ("Winamp-presets(436).zip");
    }
    else if (settingValue.GetInt() == 2)
      m_UserPackFolder = true;
  }
  else if (settingName == "User Preset Folder")
  {
    if (m_UserPackFolder)
      SetPresetDir(settingValue.GetString().c_str());
  }
  else
    return ADDON_STATUS_UNKNOWN;

  return ADDON_STATUS_OK;
}

ADDONCREATOR(CVisualizationMilkdrop) // Don't touch this!
