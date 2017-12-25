%define FUNCTION_MARKER  "mov r0, r0\nmov r1, r1\nmov r2, r2

global nseel_asm_1pdd
nseel_asm_1pdd:
    FUNCTION_MARKER
    movw r3, 0xdead
    movt r3, 0xbeef  
    str lr, [sp, #-8]!
    blx r3
    ldr lr, [sp], #8
    FUNCTION_MARKER

global nseel_asm_1pdd_end
nseel_asm_1pdd_end:


global nseel_asm_2pdd
nseel_asm_2pdd:
    FUNCTION_MARKER
    movw r3, 0xdead
    movt r3, 0xbeef
    fcpyd d1, d0 
    fldd d0, [r1] 
    str lr, [sp, #-8]!
    blx r3 
    ldr lr, [sp], #8
    FUNCTION_MARKER

global nseel_asm_2pdd_end
nseel_asm_2pdd_end:


global nseel_asm_2pdds
nseel_asm_2pdds:
     
    FUNCTION_MARKER
    movw r3, 0xdead 
    movt r3, 0xbeef  
    push r1, lr
    fcpyd d1, d0 
    fldd d0, [r1] 
    blx r3 
    pop r0, lr
    fstd d0, [r0]
    FUNCTION_MARKER

global nseel_asm_2pdds_end
nseel_asm_2pdds_end:


//---------------------------------------------------------------------------------------------------------------


// do nothing, eh
global nseel_asm_exec2
nseel_asm_exec2:
    FUNCTION_MARKER
    FUNCTION_MARKER

global nseel_asm_exec2_end
nseel_asm_exec2_end:


global nseel_asm_invsqrt
nseel_asm_invsqrt:
    FUNCTION_MARKER
    movw r0, 0x59df
    movt r0, 0x5f37
    fcvtsd s2, d0
    fldd d3, [r6, #32]
    fmrs r1, s2
    fmuld d0, d0, d3
    mov r1, r1, asr #1 

    sub r0, r0, r1

    fmsr s4, r0
    fcvtds d1, s4

    fldd d2, [r6, #40]
    fmuld d0, d0, d1
    fmuld d0, d0, d1
    faddd d0, d0, d2
    fmuld d0, d0, d1
    FUNCTION_MARKER

global nseel_asm_invsqrt_end
nseel_asm_invsqrt_end:


global nseel_asm_dbg_getstackptr
nseel_asm_dbg_getstackptr:
    FUNCTION_MARKER
    fmsr  s0, sp
    fsitod  d0, s0
    FUNCTION_MARKER

global nseel_asm_dbg_getstackptr_end
nseel_asm_dbg_getstackptr_end:


//---------------------------------------------------------------------------------------------------------------
global nseel_asm_sqr
nseel_asm_sqr:
    FUNCTION_MARKER
    fmuld d0, d0, d0
    FUNCTION_MARKER

global nseel_asm_sqr_end
nseel_asm_sqr_end:


//---------------------------------------------------------------------------------------------------------------
global nseel_asm_abs
nseel_asm_abs:
    FUNCTION_MARKER
    fabsd d0, d0
    FUNCTION_MARKER

global nseel_asm_abs_end
nseel_asm_abs_end:


//---------------------------------------------------------------------------------------------------------------
global nseel_asm_assign
   FUNCTION_MARKER
   fldd d0, [r0]
   mov r0, r1
   fstd d0, [r1]
   FUNCTION_MARKER

global nseel_asm_assign_end
nseel_asm_assign_end:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_assign_fromfp
nseel_asm_assign_fromfp:
   FUNCTION_MARKER
   mov r0, r1
   fstd d0, [r1]
   FUNCTION_MARKER

global nseel_asm_assign_fromfp_end
nseel_asm_assign_fromfp_end:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_assign_fast
nseel_asm_assign_fast:
    
    FUNCTION_MARKER
    fldd d0, [r0]
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER

global nseel_asm_assign_fast_endglobal 
nseel_asm_assign_fast_endglobal:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_assign_fast_fromfp
nseel_asm_assign_fast_fromfp:
    
    FUNCTION_MARKER
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER


global nseel_asm_assign_fast_fromfp_endglobal 
nseel_asm_assign_fast_fromfp_endglobal:


//---------------------------------------------------------------------------------------------------------------
global nseel_asm_add
nseel_asm_add:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    faddd d0, d1, d0
    FUNCTION_MARKER


global nseel_asm_add_endglobal 
nseel_asm_add_endglobal:

global nseel_asm_add_op
nseel_asm_add_op:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    faddd d0, d1, d0
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER


global nseel_asm_add_op_endglobal 
nseel_asm_add_op_endglobal:

global nseel_asm_add_op_fast
nseel_asm_add_op_fast:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    faddd d0, d1, d0
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER


global nseel_asm_add_op_fast_endglobal 
nseel_asm_add_op_fast_endglobal:


//---------------------------------------------------------------------------------------------------------------
global nseel_asm_sub
nseel_asm_sub:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    fsubd d0, d1, d0
    FUNCTION_MARKER


global nseel_asm_sub_endglobal 
nseel_asm_sub_endglobal:

global nseel_asm_sub_op
nseel_asm_sub_op:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    fsubd d0, d1, d0
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER


global nseel_asm_sub_op_endglobal 
nseel_asm_sub_op_endglobal:

global nseel_asm_sub_op_fast
nseel_asm_sub_op_fast:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    fsubd d0, d1, d0
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER


global nseel_asm_sub_op_fast_endglobal 
nseel_asm_sub_op_fast_endglobal:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_mul
nseel_asm_mul:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    fmuld d0, d0, d1
    FUNCTION_MARKER


global nseel_asm_mul_endglobal 
nseel_asm_mul_endglobal:

global nseel_asm_mul_op
nseel_asm_mul_op:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    fmuld d0, d0, d1
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER


global nseel_asm_mul_op_endglobal 
nseel_asm_mul_op_endglobal:

global nseel_asm_mul_op_fast
nseel_asm_mul_op_fast:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    fmuld d0, d0, d1
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER


global nseel_asm_mul_op_fast_endglobal 
nseel_asm_mul_op_fast_endglobal:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_div
nseel_asm_div:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    fdivd d0, d1, d0
    FUNCTION_MARKER


global nseel_asm_div_endglobal 
nseel_asm_div_endglobal:

global nseel_asm_div_op
nseel_asm_div_op:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    fdivd d0, d1, d0
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER

global nseel_asm_div_op_endglobal 
nseel_asm_div_op_endglobal:

global nseel_asm_div_op_fast
nseel_asm_div_op_fast:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    fdivd d0, d1, d0
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER


global nseel_asm_div_op_fast_endglobal 
nseel_asm_div_op_fast_endglobal:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_mod
nseel_asm_mod:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    ftouizd s0, d0 // round to unsigned integers
    fmrs r3, s0
    fuitod  d0, s0 // divisor
    ftouizd s2, d1

    cmp r3, #0
    beq 0f

    fuitod  d1, s2 // value
    fdivd d2, d1, d0
    ftouizd s4, d2
    fuitod  d2, s4
    fmuld d2, d2, d0
    fsubd d0, d1, d2
    0:
    FUNCTION_MARKER


global nseel_asm_mod_endglobal 
nseel_asm_mod_endglobal:

global nseel_asm_shl
nseel_asm_shl:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    ftosizd s0, d0
    ftosizd s1, d1
    fmrs r3, s0
    fmrs r2, s1
    mov r3, r2, asl r3
    fmsr  s0, r3
    fsitod  d0, s0
    FUNCTION_MARKER


global nseel_asm_shl_endglobal 
nseel_asm_shl_endglobal:

global nseel_asm_shr
nseel_asm_shr:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    ftosizd s0, d0
    ftosizd s1, d1
    fmrs r3, s0
    fmrs r2, s1
    mov r3, r2, asr r3
    fmsr  s0, r3
    fsitod  d0, s0
    FUNCTION_MARKER


global nseel_asm_shr_endglobal 
nseel_asm_shr_endglobal:

global nseel_asm_mod_op
nseel_asm_mod_op:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    ftouizd s0, d0 // round to unsigned integers
    fmrs r3, s0
    fuitod  d0, s0 // divisor
    ftouizd s2, d1

    cmp r3, #0
    beq 0f

    fuitod  d1, s2 // value
    fdivd d2, d1, d0
    ftouizd s4, d2
    fuitod  d2, s4
    fmuld d2, d2, d0
    fsubd d0, d1, d2
    0:
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER


global nseel_asm_mod_op_endglobal 
nseel_asm_mod_op_endglobal:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_or
nseel_asm_or:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    ftosizd s0, d0
    ftosizd s1, d1
    fmrs r3, s0
    fmrs r2, s1
    orr r3, r3, r2
    fmsr  s0, r3
    fsitod  d0, s0
    FUNCTION_MARKER


global nseel_asm_or_endglobal 
nseel_asm_or_endglobal:

global nseel_asm_or0
nseel_asm_or0:
    
    FUNCTION_MARKER
    ftosizd s0, d0
    fsitod  d0, s0
    FUNCTION_MARKER


global nseel_asm_or0_endglobal 
nseel_asm_or0_endglobal:

global nseel_asm_or_op
nseel_asm_or_op:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    ftosizd s0, d0
    ftosizd s1, d1
    fmrs r3, s0
    fmrs r2, s1
    orr r3, r3, r2
    fmsr  s0, r3
    fsitod  d0, s0
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER


global nseel_asm_or_op_endglobal 
nseel_asm_or_op_endglobal:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_xor
nseel_asm_xor:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    ftosizd s0, d0
    ftosizd s1, d1
    fmrs r3, s0
    fmrs r2, s1
    eor r3, r3, r2
    fmsr  s0, r3
    fsitod  d0, s0
    FUNCTION_MARKER


global nseel_asm_xor_endglobal 
nseel_asm_xor_endglobal:

global nseel_asm_xor_op
nseel_asm_xor_op:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    ftosizd s0, d0
    ftosizd s1, d1
    fmrs r3, s0
    fmrs r2, s1
    eor r3, r3, r2
    fmsr  s0, r3
    fsitod  d0, s0
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER


global nseel_asm_xor_op_endglobal 
nseel_asm_xor_op_endglobal:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_and
nseel_asm_and:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    ftosizd s0, d0
    ftosizd s1, d1
    fmrs r3, s0
    fmrs r2, s1
    and r3, r3, r2
    fmsr  s0, r3
    fsitod  d0, s0
    FUNCTION_MARKER

global nseel_asm_and_endglobal 
nseel_asm_and_endglobal:

global nseel_asm_and_op
nseel_asm_and_op:
    
    FUNCTION_MARKER
    fldd d1, [r1]
    ftosizd s0, d0
    ftosizd s1, d1
    fmrs r3, s0
    fmrs r2, s1
    and r3, r3, r2
    fmsr  s0, r3
    fsitod  d0, s0
    mov r0, r1
    fstd d0, [r1]
    FUNCTION_MARKER


global nseel_asm_and_op_endglobal 
nseel_asm_and_op_endglobal:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_uplus // this is the same as doing nothing, it seems
nseel_asm_uplus:
    
    FUNCTION_MARKER
    FUNCTION_MARKER


global nseel_asm_uplus_endglobal 
nseel_asm_uplus_endglobal:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_uminus
nseel_asm_uminus:
    
    FUNCTION_MARKER
    fnegd d0, d0
    FUNCTION_MARKER


global nseel_asm_uminus_endglobal 
nseel_asm_uminus_endglobal:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_sign
nseel_asm_sign:
    
    FUNCTION_MARKER
    fcmpzd d0
    fmstat
    flddgt d0, [r6, #16]
    flddlt d0, [r6, #24]
    FUNCTION_MARKER


global nseel_asm_sign_endglobal 
nseel_asm_sign_endglobal:


//---------------------------------------------------------------------------------------------------------------
global nseel_asm_bnot
nseel_asm_bnot:
    
    FUNCTION_MARKER
    cmp r0, #0
    movne r0, #0
    moveq r0, #1
    FUNCTION_MARKER

global nseel_asm_bnot_endglobal 
nseel_asm_bnot_endglobal:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_if
nseel_asm_if:
    
    FUNCTION_MARKER
    str lr, [sp, #-8]!
    movw r1, 0xdead 
    movt r1, 0xbeef  
    movw r2, 0xdead 
    movt r2, 0xbeef  
    cmp r0, #0
    moveq r1, r2
    blx r1 
    ldr lr, [sp], #8
    FUNCTION_MARKER

global nseel_asm_if_endglobal 
nseel_asm_if_endglobal:

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_repeat
nseel_asm_repeat:
%if NSEEL_LOOPFUNC_SUPPORT_MAXLEN > 0
    
    FUNCTION_MARKER
    ftosizd s0, d0
    fmrs r3, s0
    cmp r3, #0
    ble 0f
    movw r2, %0
    movt r2, %1
    cmp r3, r2
    movgt r3, r2
    push r10,lr

    movw r10, 0xdead
    movt r10, 0xbeef  
  1:
    push r3,r5 // save counter + worktable
    blx r10
    pop r3,r5
    sub r3, r3, #1
    cmp r3, #0
    bgt 1b
    pop r10,lr

    0:
    FUNCTION_MARKER
"g" (NSEEL_LOOPFUNC_SUPPORT_MAXLEN&65535),
      g" (NSEEL_LOOPFUNC_SUPPORT_MAXLEN>>16)

%else
    
    FUNCTION_MARKER
    ftosizd s0, d0
    fmrs r3, s0
    cmp r3, #0
    ble 0f
    push r10,lr

    movw r10, 0xdead
    movt r10, 0xbeef  
  1:
    push r3,r5 // save counter + worktable
    blx r10
    pop r3,r5
    sub r3, r3, #1
    cmp r3, #0
    bgt 1b
    pop r10,lr

    0:
    FUNCTION_MARKER

%endif

global nseel_asm_repeat_endglobal 

global nseel_asm_repeatwhile

%if NSEEL_LOOPFUNC_SUPPORT_MAXLEN > 0
    
    FUNCTION_MARKER
    movw r3, %0
    movt r3, %1
    push r10,lr

    movw r10, 0xdead
    movt r10, 0xbeef  
  0:
    push r3,r5 // save counter + worktable
    blx r10
    pop r3,r5
    sub r3, r3, #1
    cmp r0, #0
    cmpne r3, #0
    bne 0b
    pop r10,lr

    FUNCTION_MARKER
"g" (NSEEL_LOOPFUNC_SUPPORT_MAXLEN&65535),
      g" (NSEEL_LOOPFUNC_SUPPORT_MAXLEN>>16)

%else
    
    FUNCTION_MARKER
    push r10,lr

    movw r10, 0xdead
    movt r10, 0xbeef  
  0:
    push r3,r5 // save worktable (r3 just for alignment)
    blx r10
    pop r3,r5
    cmp r0, #0
    bne 0b
    pop r10,lr

    0:
    FUNCTION_MARKER

%endif

global nseel_asm_repeatwhile_endglobal 


global nseel_asm_band

    
    FUNCTION_MARKER
    cmp r0, #0
    beq 0f
    movw r3, 0xdead
    movt r3, 0xbeef  
    push r3, lr
    blx r3
    pop r3, lr
    0:
    FUNCTION_MARKER


global nseel_asm_band_endglobal 

global nseel_asm_bor

    
    FUNCTION_MARKER
    cmp r0, #0
    bne 0f
    movw r3, 0xdead
    movt r3, 0xbeef  
    push r3, lr
    blx r3
    pop r3, lr
    0:
    FUNCTION_MARKER


global nseel_asm_bor_endglobal 

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_equal

    
    FUNCTION_MARKER
    fldd d1, [r1]
    fldd d2, [r6]
    fsubd d0, d0, d1
    fabsd d0, d0
    fcmpd d2, d0
    fmstat
    movlt r0, #0
    movge r0, #1
    FUNCTION_MARKER



global nseel_asm_equal_endglobal 
//---------------------------------------------------------------------------------------------------------------
global nseel_asm_equal_exact

    
    FUNCTION_MARKER
    fldd d1, [r1]
    fcmpd d0, d1
    fmstat
    movne r0, #0
    moveq r0, #1
    FUNCTION_MARKER



global nseel_asm_equal_exact_endglobal 
//
//---------------------------------------------------------------------------------------------------------------
global nseel_asm_notequal_exact

    
    FUNCTION_MARKER
    fldd d1, [r1]
    fcmpd d0, d1
    fmstat
    moveq r0, #0
    movne r0, #1
    FUNCTION_MARKER



global nseel_asm_notequal_exact_endglobal 
//
//
//
//---------------------------------------------------------------------------------------------------------------
global nseel_asm_notequal

    
    FUNCTION_MARKER
    fldd d1, [r1]
    fldd d2, [r6]
    fsubd d0, d0, d1
    fabsd d0, d0
    fcmpd d2, d0
    fmstat
    movlt r0, #1
    movge r0, #0
    FUNCTION_MARKER



global nseel_asm_notequal_endglobal 


//---------------------------------------------------------------------------------------------------------------
global nseel_asm_below

    
    FUNCTION_MARKER
    fldd d1, [r1]
    fcmpd d1, d0
    fmstat
    movlt r0, #1
    movge r0, #0
    FUNCTION_MARKER



global nseel_asm_below_endglobal 

//---------------------------------------------------------------------------------------------------------------
global nseel_asm_beloweq

    
    FUNCTION_MARKER
    fldd d1, [r1]
    fcmpd d1, d0
    fmstat
    movle r0, #1
    movgt r0, #0
    FUNCTION_MARKER



global nseel_asm_beloweq_endglobal 


//---------------------------------------------------------------------------------------------------------------
global nseel_asm_above

    
    FUNCTION_MARKER
    fldd d1, [r1]
    fcmpd d1, d0
    fmstat
    movgt r0, #1
    movle r0, #0
    FUNCTION_MARKER



global nseel_asm_above_endglobal 

global nseel_asm_aboveeq

    
    FUNCTION_MARKER
    fldd d1, [r1]
    fcmpd d1, d0
    fmstat
    movge r0, #1
    movlt r0, #0
    FUNCTION_MARKER



global nseel_asm_aboveeq_endglobal 



global nseel_asm_min

    
    FUNCTION_MARKER
    fldd d0, [r0]
    fldd d1, [r1]
    fcmpd d1, d0
    fmstat
    movlt r0, r1
    FUNCTION_MARKER


global nseel_asm_min_endglobal 

global nseel_asm_max

    
    FUNCTION_MARKER
    fldd d0, [r0]
    fldd d1, [r1]
    fcmpd d1, d0
    fmstat
    movge r0, r1
    FUNCTION_MARKER



global nseel_asm_max_endglobal 


global nseel_asm_min_fp

    
    FUNCTION_MARKER
    fldd d1, [r1]
    fcmpd d1, d0
    fmstat
    fcpydlt d0, d1
    FUNCTION_MARKER


global nseel_asm_min_fp_endglobal 

global nseel_asm_max_fp

    
    FUNCTION_MARKER
    fldd d1, [r1]
    fcmpd d1, d0
    fmstat
    fcpydge d0, d1
    FUNCTION_MARKER



global nseel_asm_max_fp_endglobal 






global _asm_generic3parm

    
    FUNCTION_MARKER
    push r4, lr // input: r0 last, r1=second to last, r2=third to last
                      // output: r0=context, r1=r2, r2=r1, r3=r0
    mov r3, r0 // r0 (last parameter) -> r3
    mov r4, r1 // r1 (second to last parameter) r1->r4->r2

    movw r0, 0xdead  // r0 is first parm (context)
    movt r0, 0xbeef  

    mov r1, r2 // r2->r1
    mov r2, r4 // r1->r2

    movw r4, 0xdead 
    movt r4, 0xbeef  

    blx r4 
    pop r4, lr
    FUNCTION_MARKER
  ::
 ); 

global _asm_generic3parm_endglobal 

global _asm_generic3parm_retd

    
    FUNCTION_MARKER
    push r4, lr // input: r0 last, r1=second to last, r2=third to last
                      // output: r0=context, r1=r2, r2=r1, r3=r0
    mov r3, r0 // r0 (last parameter) -> r3
    mov r4, r1 // r1 (second to last parameter) r1->r4->r2

    movw r0, 0xdead  // r0 is first parm (context)
    movt r0, 0xbeef  

    mov r1, r2 // r2->r1
    mov r2, r4 // r1->r2

    movw r4, 0xdead 
    movt r4, 0xbeef  

    blx r4 
    pop r4, lr
    FUNCTION_MARKER
  ::
 ); 

global _asm_generic3parm_retd_endglobal 


global _asm_generic2parm

    
    FUNCTION_MARKER
    str lr, [sp, #-8]!
    mov r2, r0 // r0 -> r2, r1-r1, 
    movw r0, 0xdead  // r0 is first parm
    movt r0, 0xbeef  
    movw r3, 0xdead 
    movt r3, 0xbeef  
    blx r3 
    ldr lr, [sp], #8
    FUNCTION_MARKER
  ::
 ); 

global _asm_generic2parm_endglobal 


global _asm_generic2parm_retd

    
    FUNCTION_MARKER
    str lr, [sp, #-8]!
    mov r2, r0 // r0 -> r2, r1-r1, 
    movw r0, 0xdead  // r0 is first parm
    movt r0, 0xbeef  
    movw r3, 0xdead 
    movt r3, 0xbeef  
    blx r3 
    ldr lr, [sp], #8
    FUNCTION_MARKER
  ::
 ); 

global _asm_generic2parm_retd_endglobal 

global _asm_generic1parm

    
    FUNCTION_MARKER
    str lr, [sp, #-8]!
    mov r1, r0 // r0 -> r1
    movw r0, 0xdead  // r0 is first parm
    movt r0, 0xbeef  
    movw r3, 0xdead 
    movt r3, 0xbeef  
    blx r3 
    ldr lr, [sp], #8
    FUNCTION_MARKER
  ::
 ); 

global _asm_generic1parm_endglobal 



global _asm_generic1parm_retd

    
    FUNCTION_MARKER
    str lr, [sp, #-8]!
    mov r1, r0 // r0 -> r1
    movw r0, 0xdead  // r0 is first parm
    movt r0, 0xbeef  
    movw r3, 0xdead 
    movt r3, 0xbeef  
    blx r3 
    ldr lr, [sp], #8
    FUNCTION_MARKER
  ::
 ); 

global _asm_generic1parm_retd_endglobal 




global _asm_megabuf

    
    FUNCTION_MARKER
    fldd d1, [r7, #-8]
    faddd d0, d0, d1
    ftouizd s0, d0
    fmrs r3, s0 //  r3 is slot index
    mov r2, r3, asr %0 
    bic r2, r2, #7  // r2 is page index*8
    cmp r2, %1
    bge 0f

    add r2, r2, r7
    ldr r2, [r2]
    cmp r2, #0
    beq 0f

    movw r0, %2
    and r3, r3, r0 // r3 mask item in slot
    add r0, r2, r3, asl #3  // set result
    b 1f
    0:

    // failed, call stub function
    movw r2, 0xdead
    movt r2, 0xbeef  
    str lr, [sp, #-8]!
    mov r0, r7 // first parameter: blocks
    mov r1, r3 // second parameter: slot index
    blx r2 
    ldr lr, [sp], #8

    1:

    FUNCTION_MARKER
  :: 
    i" (NSEEL_RAM_ITEMSPERBLOCK_LOG2 - 3/*log2(sizeof(EEL_F))*/),
    i" (NSEEL_RAM_BLOCKS*8),
    i" (NSEEL_RAM_ITEMSPERBLOCK-1)
 ); 


global _asm_megabuf_endglobal 

global _asm_gmegabuf

    
    FUNCTION_MARKER
    movw r0, 0xdead
    movt r0, 0xbeef  

    movw r2, 0xdead
    movt r2, 0xbeef  

    fldd d1, [r7, #-8]
    faddd d0, d0, d1
    ftouizd s0, d0
    fmrs r1, s0 //  r1 is slot index

    push r4, lr

    blx r2

    pop r4, lr

    FUNCTION_MARKER
  ::
 ); 


global _asm_gmegabuf_endglobal 

global nseel_asm_fcall

    
    FUNCTION_MARKER
    movw r0, 0xdead
    movt r0, 0xbeef  
    push r4, lr
    blx r0
    pop r4, lr
    FUNCTION_MARKER


global nseel_asm_fcall_endglobal 



global nseel_asm_stack_push

    
    FUNCTION_MARKER
    fldd d0, [r0]

    movw r3, 0xdead // r3 is stack
    movt r3, 0xbeef  
    ldr r0, [r3]

    add r0, r0, #8

    movw r2, 0xdead
    movt r2, 0xbeef  
    and r0, r0, r2
    movw r2, 0xdead
    movt r2, 0xbeef  
    orr r0, r0, r2

    str r0, [r3]
    fstd d0, [r0]

    FUNCTION_MARKER


global nseel_asm_stack_push_endglobal 

global nseel_asm_stack_pop

    
    FUNCTION_MARKER
    movw r3, 0xdead // r3 is stack
    movt r3, 0xbeef  
    ldr r1, [r3]
    fldd d0, [r1]
    sub r1, r1, #8
    movw r2, 0xdead
    movt r2, 0xbeef  
    fstd d0, [r0]
    and r1, r1, r2
    movw r2, 0xdead
    movt r2, 0xbeef  
    orr r1, r1, r2

    str r1, [r3]
    FUNCTION_MARKER


global nseel_asm_stack_pop_endglobal 



global nseel_asm_stack_pop_fast

    
    FUNCTION_MARKER
    movw r3, 0xdead // r3 is stack
    movt r3, 0xbeef  
    ldr r1, [r3]
    mov r0, r1
    sub r1, r1, #8
    movw r2, 0xdead
    movt r2, 0xbeef  
    and r1, r1, r2
    movw r2, 0xdead
    movt r2, 0xbeef  
    orr r1, r1, r2
    str r1, [r3]
    FUNCTION_MARKER


global nseel_asm_stack_pop_fast_endglobal 

global nseel_asm_stack_peek

    
    FUNCTION_MARKER
    movw r3, 0xdead // r3 is stack
    movt r3, 0xbeef  

    ftosizd s0, d0
    fmrs r2, s0 // r2 is index in stack

    ldr r1, [r3]
    sub r1, r1, r2, asl #3
    movw r2, 0xdead
    movt r2, 0xbeef  
    and r1, r1, r2
    movw r2, 0xdead
    movt r2, 0xbeef  
    orr r0, r1, r2
    FUNCTION_MARKER


global nseel_asm_stack_peek_endglobal 


global nseel_asm_stack_peek_top

    
    FUNCTION_MARKER
    movw r3, 0xdead // r3 is stack
    movt r3, 0xbeef  
    ldr r0, [r3]
    FUNCTION_MARKER


global nseel_asm_stack_peek_top_endglobal 


global nseel_asm_stack_peek_int

    
    FUNCTION_MARKER
    movw r3, 0xdead // r3 is stack
    movt r3, 0xbeef  

    movw r2, 0xdead // r3 is stack
    movt r2, 0xbeef  

    ldr r1, [r3]
    sub r1, r1, r2
    movw r2, 0xdead
    movt r2, 0xbeef  
    and r1, r1, r2
    movw r2, 0xdead
    movt r2, 0xbeef  
    orr r0, r1, r2
    FUNCTION_MARKER


global nseel_asm_stack_peek_int_endglobal 

global nseel_asm_stack_exch

    
    FUNCTION_MARKER
    movw r3, 0xdead // r3 is stack
    movt r3, 0xbeef  
    ldr r1, [r3]
    fldd d0, [r0]
    fldd d1, [r1]
    fstd d0, [r1]
    fstd d1, [r0]
    FUNCTION_MARKER


global nseel_asm_stack_exch_endglobal 


global nseel_asm_booltofp

    
    FUNCTION_MARKER
    cmp r0, #0
    flddne d0, [r6, #16]
    flddeq d0, [r6, #8]
    FUNCTION_MARKER


global nseel_asm_booltofp_end 

global nseel_asm_fptobool

    
    FUNCTION_MARKER
    fldd d1, [r6]
    fabsd d0, d0
    fcmpd d0, d1
    fmstat
    movgt r0, #1
    movlt r0, #0
    FUNCTION_MARKER



global nseel_asm_fptobool_end 

global nseel_asm_fptobool_rev

    
    FUNCTION_MARKER
    fldd d1, [r6]
    fabsd d0, d0
    fcmpd d0, d1
    fmstat
    movgt r0, #0
    movlt r0, #1
    FUNCTION_MARKER



global nseel_asm_fptobool_rev_end 

