;#
;# $Id$
;#
;# Gromacs 4.0                         Copyright (c) 1991-2003 
;# David van der Spoel, Erik Lindahl
;#
;# This program is free software; you can redistribute it and/or
;# modify it under the terms of the GNU General Public License
;# as published by the Free Software Foundation; either version 2
;# of the License, or (at your option) any later version.
;#
;# To help us fund GROMACS development, we humbly ask that you cite
;# the research papers on the package. Check out http://www.gromacs.org
;# 
;# And Hey:
;# Gnomes, ROck Monsters And Chili Sauce
;#

;# These files require GNU binutils 2.10 or later, since we
;# use intel syntax for portability, or a recent version 
;# of NASM that understands Extended 3DNow and SSE2 instructions.
;# (NASM is normally only used with MS Visual C++).
;# Since NASM and gnu as disagree on some definitions and use 
;# completely different preprocessing options I have to introduce a
;# trick: NASM uses ';' for comments, while gnu as uses '#' on x86.
;# Gnu as treats ';' as a line break, i.e. ignores it. This is the
;# reason why all comments need both symbols...
;# The source is written for GNU as, with intel syntax. When you use
;# NASM we redefine a couple of things. The false if-statement around 
;# the following code is seen by GNU as, but NASM doesn't see it, so 
;# the code inside is read by NASM but not gcc.

; .if 0    # block below only read by NASM
%define .section	section
%define .long		dd
%define .align		align
%define .globl		global
;# NASM only wants 'dword', not 'dword ptr'.
%define ptr
.equiv          .equiv                  2
   %1 equ %2
%endmacro
; .endif                   # End of NASM-specific block
; .intel_syntax noprefix   # Line only read by gnu as



	
.globl nb_kernel304_x86_64_sse2
.globl _nb_kernel304_x86_64_sse2
nb_kernel304_x86_64_sse2:	
_nb_kernel304_x86_64_sse2:	
;#	Room for return address and rbp (16 bytes)
.equiv          nb304_fshift,           16
.equiv          nb304_gid,              24
.equiv          nb304_pos,              32
.equiv          nb304_faction,          40
.equiv          nb304_charge,           48
.equiv          nb304_p_facel,          56
.equiv          nb304_argkrf,           64
.equiv          nb304_argcrf,           72
.equiv          nb304_Vc,               80
.equiv          nb304_type,             88
.equiv          nb304_p_ntype,          96
.equiv          nb304_vdwparam,         104
.equiv          nb304_Vvdw,             112
.equiv          nb304_p_tabscale,       120
.equiv          nb304_VFtab,            128
.equiv          nb304_invsqrta,         136
.equiv          nb304_dvda,             144
.equiv          nb304_p_gbtabscale,     152
.equiv          nb304_GBtab,            160
.equiv          nb304_p_nthreads,       168
.equiv          nb304_count,            176
.equiv          nb304_mtx,              184
.equiv          nb304_outeriter,        192
.equiv          nb304_inneriter,        200
.equiv          nb304_work,             208
	;# stack offsets for local variables  
	;# bottom of stack is cache-aligned for sse2 use 
.equiv          nb304_ixM,              0
.equiv          nb304_iyM,              16
.equiv          nb304_izM,              32
.equiv          nb304_ixH1,             48
.equiv          nb304_iyH1,             64
.equiv          nb304_izH1,             80
.equiv          nb304_ixH2,             96
.equiv          nb304_iyH2,             112
.equiv          nb304_izH2,             128
.equiv          nb304_jxM,              144
.equiv          nb304_jyM,              160
.equiv          nb304_jzM,              176
.equiv          nb304_jxH1,             192
.equiv          nb304_jyH1,             208
.equiv          nb304_jzH1,             224
.equiv          nb304_jxH2,             240
.equiv          nb304_jyH2,             256
.equiv          nb304_jzH2,             272
.equiv          nb304_dxMM,             288
.equiv          nb304_dyMM,             304
.equiv          nb304_dzMM,             320
.equiv          nb304_dxMH1,            336
.equiv          nb304_dyMH1,            352
.equiv          nb304_dzMH1,            368
.equiv          nb304_dxMH2,            384
.equiv          nb304_dyMH2,            400
.equiv          nb304_dzMH2,            416
.equiv          nb304_dxH1M,            432
.equiv          nb304_dyH1M,            448
.equiv          nb304_dzH1M,            464
.equiv          nb304_dxH1H1,           480
.equiv          nb304_dyH1H1,           496
.equiv          nb304_dzH1H1,           512
.equiv          nb304_dxH1H2,           528
.equiv          nb304_dyH1H2,           544
.equiv          nb304_dzH1H2,           560
.equiv          nb304_dxH2M,            576
.equiv          nb304_dyH2M,            592
.equiv          nb304_dzH2M,            608
.equiv          nb304_dxH2H1,           624
.equiv          nb304_dyH2H1,           640
.equiv          nb304_dzH2H1,           656
.equiv          nb304_dxH2H2,           672
.equiv          nb304_dyH2H2,           688
.equiv          nb304_dzH2H2,           704
.equiv          nb304_qqMM,             720
.equiv          nb304_qqMH,             736
.equiv          nb304_qqHH,             752
.equiv          nb304_two,              768
.equiv          nb304_tsc,              784
.equiv          nb304_vctot,            800
.equiv          nb304_fixM,             816
.equiv          nb304_fiyM,             832
.equiv          nb304_fizM,             848
.equiv          nb304_fixH1,            864
.equiv          nb304_fiyH1,            880
.equiv          nb304_fizH1,            896
.equiv          nb304_fixH2,            912
.equiv          nb304_fiyH2,            928
.equiv          nb304_fizH2,            944
.equiv          nb304_epsH1,            960
.equiv          nb304_epsH2,            976
.equiv          nb304_epsM,             992
.equiv          nb304_fjxH1,            1008
.equiv          nb304_fjyH1,            1024
.equiv          nb304_fjzH1,            1040
.equiv          nb304_fjxH2,            1056
.equiv          nb304_fjyH2,            1072
.equiv          nb304_fjzH2,            1088
.equiv          nb304_half,             1104
.equiv          nb304_three,            1120
.equiv          nb304_rsqMM,            1136
.equiv          nb304_rsqMH1,           1152
.equiv          nb304_rsqMH2,           1168
.equiv          nb304_rsqH1M,           1184
.equiv          nb304_rsqH1H1,          1200
.equiv          nb304_rsqH1H2,          1216
.equiv          nb304_rsqH2M,           1232
.equiv          nb304_rsqH2H1,          1248
.equiv          nb304_rsqH2H2,          1264
.equiv          nb304_rinvMM,           1280
.equiv          nb304_rinvMH1,          1296
.equiv          nb304_rinvMH2,          1312
.equiv          nb304_rinvH1M,          1328
.equiv          nb304_rinvH1H1,         1344
.equiv          nb304_rinvH1H2,         1360
.equiv          nb304_rinvH2M,          1376
.equiv          nb304_rinvH2H1,         1392
.equiv          nb304_rinvH2H2,         1408
.equiv          nb304_is3,              1424
.equiv          nb304_ii3,              1428
.equiv          nb304_nri,              1432
.equiv          nb304_iinr,             1440
.equiv          nb304_jindex,           1448
.equiv          nb304_jjnr,             1456
.equiv          nb304_shift,            1464
.equiv          nb304_shiftvec,         1472
.equiv          nb304_facel,            1480
.equiv          nb304_innerjjnr,        1488
.equiv          nb304_innerk,           1496
.equiv          nb304_n,                1500
.equiv          nb304_nn1,              1504
.equiv          nb304_nouter,           1508
.equiv          nb304_ninner,           1512
	push rbp
	mov  rbp, rsp
	push rbx
	emms

        push r12
        push r13
        push r14
        push r15

	sub rsp, 1528		;# local variable stack space (n*16+8)

	;# zero 32-bit iteration counters
	mov eax, 0
	mov [rsp + nb304_nouter], eax
	mov [rsp + nb304_ninner], eax

	mov edi, [rdi]
	mov [rsp + nb304_nri], edi
	mov [rsp + nb304_iinr], rsi
	mov [rsp + nb304_jindex], rdx
	mov [rsp + nb304_jjnr], rcx
	mov [rsp + nb304_shift], r8
	mov [rsp + nb304_shiftvec], r9
	mov rsi, [rbp + nb304_p_facel]
	movsd xmm0, [rsi]
	movsd [rsp + nb304_facel], xmm0

	mov rax, [rbp + nb304_p_tabscale]
	movsd xmm3, [rax]
	shufpd xmm3, xmm3, 0
	movapd [rsp + nb304_tsc], xmm3

	;# create constant floating-point factors on stack
	mov eax, 0x00000000     ;# lower half of double half IEEE (hex)
	mov ebx, 0x3fe00000
	mov [rsp + nb304_half], eax
	mov [rsp + nb304_half+4], ebx
	movsd xmm1, [rsp + nb304_half]
	shufpd xmm1, xmm1, 0    ;# splat to all elements
	movapd xmm3, xmm1
	addpd  xmm3, xmm3       ;# one
	movapd xmm2, xmm3
	addpd  xmm2, xmm2       ;# two
	addpd  xmm3, xmm2	;# three
	movapd [rsp + nb304_half], xmm1
	movapd [rsp + nb304_two], xmm2
	movapd [rsp + nb304_three], xmm3

	;# assume we have at least one i particle - start directly 
	mov   rcx, [rsp + nb304_iinr]       ;# rcx = pointer into iinr[] 	
	mov   ebx, [rcx]	    ;# ebx =ii 

	mov   rdx, [rbp + nb304_charge]
	movsd xmm3, [rdx + rbx*8 + 24]	
	movsd xmm4, xmm3
	movsd xmm5, [rdx + rbx*8 + 8]	
	mov rsi, [rbp + nb304_p_facel]
	movsd xmm0, [rsi]
	movsd xmm6, [rsp + nb304_facel]
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm5
	mulsd  xmm5, xmm5
	mulsd  xmm3, xmm6
	mulsd  xmm4, xmm6
	mulsd  xmm5, xmm6
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	movapd [rsp + nb304_qqMM], xmm3
	movapd [rsp + nb304_qqMH], xmm4
	movapd [rsp + nb304_qqHH], xmm5		

.nb304_threadloop:
        mov   rsi, [rbp + nb304_count]          ;# pointer to sync counter
        mov   eax, [rsi]
.nb304_spinlock:
        mov   ebx, eax                          ;# ebx=*count=nn0
        add   ebx, 1                           ;# ebx=nn1=nn0+10
        lock
        cmpxchg [esi], ebx                      ;# write nn1 to *counter,
                                                ;# if it hasnt changed.
                                                ;# or reread *counter to eax.
        pause                                   ;# -> better p4 performance
        jnz .nb304_spinlock

        ;# if(nn1>nri) nn1=nri
        mov ecx, [rsp + nb304_nri]
        mov edx, ecx
        sub ecx, ebx
        cmovle ebx, edx                         ;# if(nn1>nri) nn1=nri
        ;# Cleared the spinlock if we got here.
        ;# eax contains nn0, ebx contains nn1.
        mov [rsp + nb304_n], eax
        mov [rsp + nb304_nn1], ebx
        sub ebx, eax                            ;# calc number of outer lists
	mov esi, eax				;# copy n to esi
        jg  .nb304_outerstart
        jmp .nb304_end

.nb304_outerstart:
	;# ebx contains number of outer iterations
	add ebx, [rsp + nb304_nouter]
	mov [rsp + nb304_nouter], ebx

.nb304_outer:
	mov   rax, [rsp + nb304_shift]      ;# rax = pointer into shift[] 
	mov   ebx, [rax +rsi*4]		;# rbx=shift[n] 
	
	lea   rbx, [rbx + rbx*2]    ;# rbx=3*is 
	mov   [rsp + nb304_is3],ebx    	;# store is3 

	mov   rax, [rsp + nb304_shiftvec]   ;# rax = base of shiftvec[] 

	movsd xmm0, [rax + rbx*8]
	movsd xmm1, [rax + rbx*8 + 8]
	movsd xmm2, [rax + rbx*8 + 16] 

	mov   rcx, [rsp + nb304_iinr]       ;# rcx = pointer into iinr[] 	
	mov   ebx, [rcx + rsi*4]	    ;# ebx =ii 

	lea   rbx, [rbx + rbx*2]	;# rbx = 3*ii=ii3 
	mov   rax, [rbp + nb304_pos]    ;# rax = base of pos[]  
	mov   [rsp + nb304_ii3], ebx	
	
	movapd xmm3, xmm0
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	addsd xmm3, [rax + rbx*8 + 24]
	addsd xmm4, [rax + rbx*8 + 32]
	addsd xmm5, [rax + rbx*8 + 40]		
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	movapd [rsp + nb304_ixH1], xmm3
	movapd [rsp + nb304_iyH1], xmm4
	movapd [rsp + nb304_izH1], xmm5

	movsd xmm3, xmm0
	movsd xmm4, xmm1
	movsd xmm5, xmm2
	addsd xmm0, [rax + rbx*8 + 48]
	addsd xmm1, [rax + rbx*8 + 56]
	addsd xmm2, [rax + rbx*8 + 64]		
	addsd xmm3, [rax + rbx*8 + 72]
	addsd xmm4, [rax + rbx*8 + 80]
	addsd xmm5, [rax + rbx*8 + 88]		

	shufpd xmm0, xmm0, 0
	shufpd xmm1, xmm1, 0
	shufpd xmm2, xmm2, 0
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	movapd [rsp + nb304_ixH2], xmm0
	movapd [rsp + nb304_iyH2], xmm1
	movapd [rsp + nb304_izH2], xmm2
	movapd [rsp + nb304_ixM], xmm3
	movapd [rsp + nb304_iyM], xmm4
	movapd [rsp + nb304_izM], xmm5

	;# clear vctot and i forces 
	xorpd xmm4, xmm4
	movapd [rsp + nb304_vctot], xmm4
	movapd [rsp + nb304_fixM], xmm4
	movapd [rsp + nb304_fiyM], xmm4
	movapd [rsp + nb304_fizM], xmm4
	movapd [rsp + nb304_fixH1], xmm4
	movapd [rsp + nb304_fiyH1], xmm4
	movapd [rsp + nb304_fizH1], xmm4
	movapd [rsp + nb304_fixH2], xmm4
	movapd [rsp + nb304_fiyH2], xmm4
	movapd [rsp + nb304_fizH2], xmm4
	
	mov   rax, [rsp + nb304_jindex]
	mov   ecx, [rax + rsi*4]	     ;# jindex[n] 
	mov   edx, [rax + rsi*4 + 4]	     ;# jindex[n+1] 
	sub   edx, ecx               ;# number of innerloop atoms 

	mov   rsi, [rbp + nb304_pos]
	mov   rdi, [rbp + nb304_faction]	
	mov   rax, [rsp + nb304_jjnr]
	shl   ecx, 2
	add   rax, rcx
	mov   [rsp + nb304_innerjjnr], rax     ;# pointer to jjnr[nj0] 
	mov   ecx, edx
	sub   edx,  2
	add   ecx, [rsp + nb304_ninner]
	mov   [rsp + nb304_ninner], ecx
	add   edx, 0
	mov   [rsp + nb304_innerk], edx    ;# number of innerloop atoms 
	jge   .nb304_unroll_loop
	jmp   .nb304_checksingle
.nb304_unroll_loop:	
	;# twice unrolled innerloop here 
	mov   rdx, [rsp + nb304_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [rdx]	
	mov   ebx, [rdx + 4] 
	
	add qword ptr [rsp + nb304_innerjjnr], 8 ;# advance pointer (unrolled 2) 

	mov rsi, [rbp + nb304_pos]       ;# base of pos[] 

	lea   rax, [rax + rax*2]     ;# replace jnr with j3 
	lea   rbx, [rbx + rbx*2]	
	
	;# move j H1 coordinates to local temp variables 
    movlpd xmm0, [rsi + rax*8 + 24] 
    movlpd xmm1, [rsi + rax*8 + 32] 
    movlpd xmm2, [rsi + rax*8 + 40] 
    movhpd xmm0, [rsi + rbx*8 + 24] 
    movhpd xmm1, [rsi + rbx*8 + 32] 
    movhpd xmm2, [rsi + rbx*8 + 40] 

    ;# xmm0 = H1x
    ;# xmm1 = H1y
    ;# xmm2 = H1z
        
    movapd xmm3, xmm0
    movapd xmm4, xmm1
    movapd xmm5, xmm2
    movapd xmm6, xmm0
    movapd xmm7, xmm1
    movapd xmm8, xmm2
    
    subpd xmm0, [rsp + nb304_ixH1]
    subpd xmm1, [rsp + nb304_iyH1]
    subpd xmm2, [rsp + nb304_izH1]
    subpd xmm3, [rsp + nb304_ixH2]
    subpd xmm4, [rsp + nb304_iyH2]
    subpd xmm5, [rsp + nb304_izH2]
    subpd xmm6, [rsp + nb304_ixM]
    subpd xmm7, [rsp + nb304_iyM]
    subpd xmm8, [rsp + nb304_izM]
    
	movapd [rsp + nb304_dxH1H1], xmm0
	movapd [rsp + nb304_dyH1H1], xmm1
	movapd [rsp + nb304_dzH1H1], xmm2
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	movapd [rsp + nb304_dxH2H1], xmm3
	movapd [rsp + nb304_dyH2H1], xmm4
	movapd [rsp + nb304_dzH2H1], xmm5
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	movapd [rsp + nb304_dxMH1], xmm6
	movapd [rsp + nb304_dyMH1], xmm7
	movapd [rsp + nb304_dzMH1], xmm8
	mulpd  xmm6, xmm6
	mulpd  xmm7, xmm7
	mulpd  xmm8, xmm8
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm3, xmm4
	addpd  xmm3, xmm5
    addpd  xmm6, xmm7
    addpd  xmm6, xmm8

	;# start doing invsqrt for jH1 atoms
    cvtpd2ps xmm1, xmm0
    cvtpd2ps xmm4, xmm3
    cvtpd2ps xmm7, xmm6
	rsqrtps xmm1, xmm1
	rsqrtps xmm4, xmm4
    rsqrtps xmm7, xmm7
    cvtps2pd xmm1, xmm1
    cvtps2pd xmm4, xmm4
    cvtps2pd xmm7, xmm7
	
	movapd  xmm2, xmm1
	movapd  xmm5, xmm4
    movapd  xmm8, xmm7
    
	mulpd   xmm1, xmm1 ;# lu*lu
	mulpd   xmm4, xmm4 ;# lu*lu
    mulpd   xmm7, xmm7 ;# lu*lu
		
	movapd  xmm9, [rsp + nb304_three]
	movapd  xmm10, xmm9
    movapd  xmm11, xmm9

	mulpd   xmm1, xmm0 ;# rsq*lu*lu
	mulpd   xmm4, xmm3 ;# rsq*lu*lu 
    mulpd   xmm7, xmm6 ;# rsq*lu*lu
	
	subpd   xmm9, xmm1
	subpd   xmm10, xmm4
    subpd   xmm11, xmm7 ;# 3-rsq*lu*lu

	mulpd   xmm9, xmm2
	mulpd   xmm10, xmm5
    mulpd   xmm11, xmm8 ;# lu*(3-rsq*lu*lu)

	movapd  xmm15, [rsp + nb304_half]
	mulpd   xmm9, xmm15  ;# first iteration for rinvH1H1 
	mulpd   xmm10, xmm15 ;# first iteration for rinvH2H1
    mulpd   xmm11, xmm15 ;# first iteration for rinvMH1	

    ;# second iteration step    
	movapd  xmm2, xmm9
	movapd  xmm5, xmm10
    movapd  xmm8, xmm11
    
	mulpd   xmm2, xmm2 ;# lu*lu
	mulpd   xmm5, xmm5 ;# lu*lu
    mulpd   xmm8, xmm8 ;# lu*lu
		
	movapd  xmm1, [rsp + nb304_three]
	movapd  xmm4, xmm1
    movapd  xmm7, xmm1

	mulpd   xmm2, xmm0 ;# rsq*lu*lu
	mulpd   xmm5, xmm3 ;# rsq*lu*lu 
    mulpd   xmm8, xmm6 ;# rsq*lu*lu
	
	subpd   xmm1, xmm2
	subpd   xmm4, xmm5
    subpd   xmm7, xmm8 ;# 3-rsq*lu*lu

	mulpd   xmm9, xmm1
	mulpd   xmm10, xmm4
    mulpd   xmm11, xmm7 ;# lu*(3-rsq*lu*lu)

	movapd  xmm15, [rsp + nb304_half]
	mulpd   xmm9, xmm15  ;#  rinvH1H1 
	mulpd   xmm10, xmm15 ;#   rinvH2H1
    mulpd   xmm11, xmm15 ;#   rinvMH1
	
	movapd  [rsp + nb304_rinvH1H1], xmm9
	movapd  [rsp + nb304_rinvH2H1], xmm10
	movapd  [rsp + nb304_rinvMH1], xmm11
	
	;# H1 interactions 
    ;# rsq in xmm0,xmm3,xmm6  
    ;# rinv in xmm9, xmm10, xmm11

    movapd xmm1, [rsp + nb304_tsc]
    mulpd  xmm0, xmm9  ;# r
    mulpd  xmm3, xmm10
    mulpd  xmm6, xmm11
    mulpd  xmm0, xmm1 ;# rtab
    mulpd  xmm3, xmm1
    mulpd  xmm6, xmm1
    
    ;# truncate and convert to integers
    cvttpd2dq xmm1, xmm0
    cvttpd2dq xmm4, xmm3
    cvttpd2dq xmm7, xmm6        

    ;# convert back to float
    cvtdq2pd  xmm2, xmm1
    cvtdq2pd  xmm5, xmm4
    cvtdq2pd  xmm8, xmm7
    
    ;# multiply by 4
    pslld   xmm1, 2
    pslld   xmm4, 2
    pslld   xmm7, 2
    
    ;# move to integer registers
    pshufd xmm13, xmm1, 1
    pshufd xmm14, xmm4, 1
    pshufd xmm15, xmm7, 1
    movd    r8d, xmm1
    movd    r10d, xmm4
    movd    r12d, xmm7
    movd    r9d, xmm13
    movd    r11d, xmm14
    movd    r13d, xmm15
        
    mov  rsi, [rbp + nb304_VFtab]

    ;# calculate eps
    subpd     xmm0, xmm2
    subpd     xmm3, xmm5
    subpd     xmm6, xmm8

    movapd    [rsp + nb304_epsH1], xmm0
    movapd    [rsp + nb304_epsH2], xmm3
    movapd    [rsp + nb304_epsM], xmm6

    ;# Load LOTS of table data
    movlpd xmm0,  [rsi + r8*8]
    movlpd xmm1,  [rsi + r8*8 + 8]
    movlpd xmm2,  [rsi + r8*8 + 16]
    movlpd xmm3,  [rsi + r8*8 + 24]
    movlpd xmm4,  [rsi + r10*8]
    movlpd xmm5,  [rsi + r10*8 + 8]
    movlpd xmm6,  [rsi + r10*8 + 16]
    movlpd xmm7,  [rsi + r10*8 + 24]
    movlpd xmm8,  [rsi + r12*8]
    movlpd xmm9,  [rsi + r12*8 + 8]
    movlpd xmm10, [rsi + r12*8 + 16]
    movlpd xmm11, [rsi + r12*8 + 24]
    movhpd xmm0,  [rsi + r9*8]
    movhpd xmm1,  [rsi + r9*8 + 8]
    movhpd xmm2,  [rsi + r9*8 + 16]
    movhpd xmm3,  [rsi + r9*8 + 24]
    movhpd xmm4,  [rsi + r11*8]
    movhpd xmm5,  [rsi + r11*8 + 8]
    movhpd xmm6,  [rsi + r11*8 + 16]
    movhpd xmm7,  [rsi + r11*8 + 24]
    movhpd xmm8,  [rsi + r13*8]
    movhpd xmm9,  [rsi + r13*8 + 8]
    movhpd xmm10, [rsi + r13*8 + 16]
    movhpd xmm11, [rsi + r13*8 + 24]
    ;# table data ready in xmm0-xmm3 , xmm4-xmm7 , and xmm8-xmm11
    
    movapd xmm12, [rsp + nb304_epsH1]
    movapd xmm13, [rsp + nb304_epsH2]
    movapd xmm14, [rsp + nb304_epsM]
    
    mulpd  xmm3, xmm12   ;# Heps
    mulpd  xmm7, xmm13
    mulpd  xmm11, xmm14 
    mulpd  xmm2, xmm12   ;# Geps
    mulpd  xmm6, xmm13
    mulpd  xmm10, xmm14 
    mulpd  xmm3, xmm12   ;# Heps2
    mulpd  xmm7, xmm13
    mulpd  xmm11, xmm14 

    addpd  xmm1, xmm2   ;# F+Geps
    addpd  xmm5, xmm6
    addpd  xmm9, xmm10 
    addpd  xmm1, xmm3   ;# F+Geps+Heps2 = Fp
    addpd  xmm5, xmm7
    addpd  xmm9, xmm11 
    addpd  xmm3, xmm3    ;# 2*Heps2
    addpd  xmm7, xmm7
    addpd  xmm11, xmm11
    addpd  xmm3, xmm2    ;# 2*Heps2+Geps
    addpd  xmm7, xmm6  
    addpd  xmm11, xmm10
    addpd  xmm3, xmm1   ;# FF = Fp + 2*Heps2 + Geps
    addpd  xmm7, xmm5
    addpd  xmm11, xmm9
    mulpd  xmm1, xmm12   ;# eps*Fp
    mulpd  xmm5, xmm13
    mulpd  xmm9, xmm14
    movapd xmm12, [rsp + nb304_qqHH]
    movapd xmm13, [rsp + nb304_qqMH]
    addpd  xmm1, xmm0     ;# VV
    addpd  xmm5, xmm4
    addpd  xmm9, xmm8
    mulpd  xmm1, xmm12   ;# VV*qq = vcoul
    mulpd  xmm5, xmm12
    mulpd  xmm9, xmm13
    mulpd  xmm3, xmm12    ;# FF*qq = fij
    mulpd  xmm7, xmm12
    mulpd  xmm11, xmm13
    
    ;# accumulate vctot
    addpd  xmm1, [rsp + nb304_vctot]
    addpd  xmm5, xmm9
    addpd  xmm1, xmm5
    movapd [rsp + nb304_vctot], xmm1
    
    movapd xmm10, [rsp + nb304_tsc]
    mulpd  xmm3, xmm10  ;# fscal
    mulpd  xmm7, xmm10
    mulpd  xmm10, xmm11
    
    xorpd xmm4, xmm4
    xorpd xmm8, xmm8
    xorpd xmm11, xmm11
    
    subpd xmm4, xmm3
    subpd xmm8, xmm7
    subpd xmm11, xmm10
 
    mulpd xmm4, [rsp + nb304_rinvH1H1]
    mulpd xmm8, [rsp + nb304_rinvH2H1]
    mulpd xmm11, [rsp + nb304_rinvMH1]
    
    ;# move j H1 forces to xmm0-xmm2
    mov rdi, [rbp + nb304_faction]
	movlpd xmm0, [rdi + rax*8 + 24]
	movlpd xmm1, [rdi + rax*8 + 32]
	movlpd xmm2, [rdi + rax*8 + 40]
	movhpd xmm0, [rdi + rbx*8 + 24]
	movhpd xmm1, [rdi + rbx*8 + 32]
	movhpd xmm2, [rdi + rbx*8 + 40]

    movapd xmm3, xmm4
    movapd xmm5, xmm4
    movapd xmm7, xmm8
    movapd xmm9, xmm8
    movapd xmm10, xmm11
    movapd xmm12, xmm11

	mulpd xmm3, [rsp + nb304_dxH1H1]
	mulpd xmm4, [rsp + nb304_dyH1H1]
	mulpd xmm5, [rsp + nb304_dzH1H1]
	mulpd xmm7, [rsp + nb304_dxH2H1]
	mulpd xmm8, [rsp + nb304_dyH2H1]
	mulpd xmm9, [rsp + nb304_dzH2H1]
	mulpd xmm10, [rsp + nb304_dxMH1]
	mulpd xmm11, [rsp + nb304_dyMH1]
	mulpd xmm12, [rsp + nb304_dzMH1]

    addpd xmm0, xmm3
    addpd xmm1, xmm4
    addpd xmm2, xmm5
    addpd xmm3, [rsp + nb304_fixH1]
    addpd xmm4, [rsp + nb304_fiyH1]
    addpd xmm5, [rsp + nb304_fizH1]

    addpd xmm0, xmm7
    addpd xmm1, xmm8
    addpd xmm2, xmm9
    addpd xmm7, [rsp + nb304_fixH2]
    addpd xmm8, [rsp + nb304_fiyH2]
    addpd xmm9, [rsp + nb304_fizH2]

    addpd xmm0, xmm10
    addpd xmm1, xmm11
    addpd xmm2, xmm12
    addpd xmm10, [rsp + nb304_fixM]
    addpd xmm11, [rsp + nb304_fiyM]
    addpd xmm12, [rsp + nb304_fizM]

    movapd [rsp + nb304_fixH1], xmm3
    movapd [rsp + nb304_fiyH1], xmm4
    movapd [rsp + nb304_fizH1], xmm5
    movapd [rsp + nb304_fixH2], xmm7
    movapd [rsp + nb304_fiyH2], xmm8
    movapd [rsp + nb304_fizH2], xmm9
    movapd [rsp + nb304_fixM], xmm10
    movapd [rsp + nb304_fiyM], xmm11
    movapd [rsp + nb304_fizM], xmm12
   
    ;# store back j H1 forces from xmm0-xmm2
	movlpd [rdi + rax*8 + 24], xmm0
	movlpd [rdi + rax*8 + 32], xmm1
	movlpd [rdi + rax*8 + 40], xmm2
	movhpd [rdi + rbx*8 + 24], xmm0
	movhpd [rdi + rbx*8 + 32], xmm1
	movhpd [rdi + rbx*8 + 40], xmm2

	;# move j H2 coordinates to local temp variables 
    mov rsi, [rbp + nb304_pos]
    movlpd xmm0, [rsi + rax*8 + 48] 
    movlpd xmm1, [rsi + rax*8 + 56] 
    movlpd xmm2, [rsi + rax*8 + 64] 
    movhpd xmm0, [rsi + rbx*8 + 48] 
    movhpd xmm1, [rsi + rbx*8 + 56] 
    movhpd xmm2, [rsi + rbx*8 + 64] 

    ;# xmm0 = H2x
    ;# xmm1 = H2y
    ;# xmm2 = H2z
        
    movapd xmm3, xmm0
    movapd xmm4, xmm1
    movapd xmm5, xmm2
    movapd xmm6, xmm0
    movapd xmm7, xmm1
    movapd xmm8, xmm2
    
    subpd xmm0, [rsp + nb304_ixH1]
    subpd xmm1, [rsp + nb304_iyH1]
    subpd xmm2, [rsp + nb304_izH1]
    subpd xmm3, [rsp + nb304_ixH2]
    subpd xmm4, [rsp + nb304_iyH2]
    subpd xmm5, [rsp + nb304_izH2]
    subpd xmm6, [rsp + nb304_ixM]
    subpd xmm7, [rsp + nb304_iyM]
    subpd xmm8, [rsp + nb304_izM]
    
	movapd [rsp + nb304_dxH1H2], xmm0
	movapd [rsp + nb304_dyH1H2], xmm1
	movapd [rsp + nb304_dzH1H2], xmm2
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	movapd [rsp + nb304_dxH2H2], xmm3
	movapd [rsp + nb304_dyH2H2], xmm4
	movapd [rsp + nb304_dzH2H2], xmm5
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	movapd [rsp + nb304_dxMH2], xmm6
	movapd [rsp + nb304_dyMH2], xmm7
	movapd [rsp + nb304_dzMH2], xmm8
	mulpd  xmm6, xmm6
	mulpd  xmm7, xmm7
	mulpd  xmm8, xmm8
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm3, xmm4
	addpd  xmm3, xmm5
    addpd  xmm6, xmm7
    addpd  xmm6, xmm8

	;# start doing invsqrt for jH2 atoms
    cvtpd2ps xmm1, xmm0
    cvtpd2ps xmm4, xmm3
    cvtpd2ps xmm7, xmm6
	rsqrtps xmm1, xmm1
	rsqrtps xmm4, xmm4
    rsqrtps xmm7, xmm7
    cvtps2pd xmm1, xmm1
    cvtps2pd xmm4, xmm4
    cvtps2pd xmm7, xmm7
	
	movapd  xmm2, xmm1
	movapd  xmm5, xmm4
    movapd  xmm8, xmm7
    
	mulpd   xmm1, xmm1 ;# lu*lu
	mulpd   xmm4, xmm4 ;# lu*lu
    mulpd   xmm7, xmm7 ;# lu*lu
		
	movapd  xmm9, [rsp + nb304_three]
	movapd  xmm10, xmm9
    movapd  xmm11, xmm9

	mulpd   xmm1, xmm0 ;# rsq*lu*lu
	mulpd   xmm4, xmm3 ;# rsq*lu*lu 
    mulpd   xmm7, xmm6 ;# rsq*lu*lu
	
	subpd   xmm9, xmm1
	subpd   xmm10, xmm4
    subpd   xmm11, xmm7 ;# 3-rsq*lu*lu

	mulpd   xmm9, xmm2
	mulpd   xmm10, xmm5
    mulpd   xmm11, xmm8 ;# lu*(3-rsq*lu*lu)

	movapd  xmm15, [rsp + nb304_half]
	mulpd   xmm9, xmm15  ;# first iteration for rinvH1H2 
	mulpd   xmm10, xmm15 ;# first iteration for rinvH2H2
    mulpd   xmm11, xmm15 ;# first iteration for rinvMH2

    ;# second iteration step    
	movapd  xmm2, xmm9
	movapd  xmm5, xmm10
    movapd  xmm8, xmm11
    
	mulpd   xmm2, xmm2 ;# lu*lu
	mulpd   xmm5, xmm5 ;# lu*lu
    mulpd   xmm8, xmm8 ;# lu*lu
		
	movapd  xmm1, [rsp + nb304_three]
	movapd  xmm4, xmm1
    movapd  xmm7, xmm1

	mulpd   xmm2, xmm0 ;# rsq*lu*lu
	mulpd   xmm5, xmm3 ;# rsq*lu*lu 
    mulpd   xmm8, xmm6 ;# rsq*lu*lu
	
	subpd   xmm1, xmm2
	subpd   xmm4, xmm5
    subpd   xmm7, xmm8 ;# 3-rsq*lu*lu

	mulpd   xmm9, xmm1
	mulpd   xmm10, xmm4
    mulpd   xmm11, xmm7 ;# lu*(3-rsq*lu*lu)

	movapd  xmm15, [rsp + nb304_half]
	mulpd   xmm9, xmm15  ;#  rinvH1H2
	mulpd   xmm10, xmm15 ;#   rinvH2H2
    mulpd   xmm11, xmm15 ;#   rinvMH2
	
	movapd  [rsp + nb304_rinvH1H2], xmm9
	movapd  [rsp + nb304_rinvH2H2], xmm10
	movapd  [rsp + nb304_rinvMH2], xmm11
	
	;# H2 interactions 
    ;# rsq in xmm0,xmm3,xmm6  
    ;# rinv in xmm9, xmm10, xmm11

    movapd xmm1, [rsp + nb304_tsc]
    mulpd  xmm0, xmm9  ;# r
    mulpd  xmm3, xmm10
    mulpd  xmm6, xmm11
    mulpd  xmm0, xmm1 ;# rtab
    mulpd  xmm3, xmm1
    mulpd  xmm6, xmm1
    
    ;# truncate and convert to integers
    cvttpd2dq xmm1, xmm0
    cvttpd2dq xmm4, xmm3
    cvttpd2dq xmm7, xmm6        

    ;# convert back to float
    cvtdq2pd  xmm2, xmm1
    cvtdq2pd  xmm5, xmm4
    cvtdq2pd  xmm8, xmm7
    
    ;# multiply by 4
    pslld   xmm1, 2
    pslld   xmm4, 2
    pslld   xmm7, 2
    
    ;# move to integer registers
    pshufd xmm13, xmm1, 1
    pshufd xmm14, xmm4, 1
    pshufd xmm15, xmm7, 1
    movd    r8d, xmm1
    movd    r10d, xmm4
    movd    r12d, xmm7
    movd    r9d, xmm13
    movd    r11d, xmm14
    movd    r13d, xmm15
        
    mov  rsi, [rbp + nb304_VFtab]

    ;# calculate eps
    subpd     xmm0, xmm2
    subpd     xmm3, xmm5
    subpd     xmm6, xmm8

    movapd    [rsp + nb304_epsH1], xmm0
    movapd    [rsp + nb304_epsH2], xmm3
    movapd    [rsp + nb304_epsM], xmm6

    ;# Load LOTS of table data
    movlpd xmm0,  [rsi + r8*8]
    movlpd xmm1,  [rsi + r8*8 + 8]
    movlpd xmm2,  [rsi + r8*8 + 16]
    movlpd xmm3,  [rsi + r8*8 + 24]
    movlpd xmm4,  [rsi + r10*8]
    movlpd xmm5,  [rsi + r10*8 + 8]
    movlpd xmm6,  [rsi + r10*8 + 16]
    movlpd xmm7,  [rsi + r10*8 + 24]
    movlpd xmm8,  [rsi + r12*8]
    movlpd xmm9,  [rsi + r12*8 + 8]
    movlpd xmm10, [rsi + r12*8 + 16]
    movlpd xmm11, [rsi + r12*8 + 24]
    movhpd xmm0,  [rsi + r9*8]
    movhpd xmm1,  [rsi + r9*8 + 8]
    movhpd xmm2,  [rsi + r9*8 + 16]
    movhpd xmm3,  [rsi + r9*8 + 24]
    movhpd xmm4,  [rsi + r11*8]
    movhpd xmm5,  [rsi + r11*8 + 8]
    movhpd xmm6,  [rsi + r11*8 + 16]
    movhpd xmm7,  [rsi + r11*8 + 24]
    movhpd xmm8,  [rsi + r13*8]
    movhpd xmm9,  [rsi + r13*8 + 8]
    movhpd xmm10, [rsi + r13*8 + 16]
    movhpd xmm11, [rsi + r13*8 + 24]
    ;# table data ready in xmm0-xmm3 , xmm4-xmm7 , and xmm8-xmm11
    
    movapd xmm12, [rsp + nb304_epsH1]
    movapd xmm13, [rsp + nb304_epsH2]
    movapd xmm14, [rsp + nb304_epsM]
    
    mulpd  xmm3, xmm12   ;# Heps
    mulpd  xmm7, xmm13
    mulpd  xmm11, xmm14 
    mulpd  xmm2, xmm12   ;# Geps
    mulpd  xmm6, xmm13
    mulpd  xmm10, xmm14 
    mulpd  xmm3, xmm12   ;# Heps2
    mulpd  xmm7, xmm13
    mulpd  xmm11, xmm14 

    addpd  xmm1, xmm2   ;# F+Geps
    addpd  xmm5, xmm6
    addpd  xmm9, xmm10 
    addpd  xmm1, xmm3   ;# F+Geps+Heps2 = Fp
    addpd  xmm5, xmm7
    addpd  xmm9, xmm11 
    addpd  xmm3, xmm3    ;# 2*Heps2
    addpd  xmm7, xmm7
    addpd  xmm11, xmm11
    addpd  xmm3, xmm2    ;# 2*Heps2+Geps
    addpd  xmm7, xmm6  
    addpd  xmm11, xmm10
    addpd  xmm3, xmm1   ;# FF = Fp + 2*Heps2 + Geps
    addpd  xmm7, xmm5
    addpd  xmm11, xmm9
    mulpd  xmm1, xmm12   ;# eps*Fp
    mulpd  xmm5, xmm13
    mulpd  xmm9, xmm14
    movapd xmm12, [rsp + nb304_qqHH]
    movapd xmm13, [rsp + nb304_qqMH]
    addpd  xmm1, xmm0     ;# VV
    addpd  xmm5, xmm4
    addpd  xmm9, xmm8
    mulpd  xmm1, xmm12   ;# VV*qq = vcoul
    mulpd  xmm5, xmm12
    mulpd  xmm9, xmm13
    mulpd  xmm3, xmm12    ;# FF*qq = fij
    mulpd  xmm7, xmm12
    mulpd  xmm11, xmm13
    
    ;# accumulate vctot
    addpd  xmm1, [rsp + nb304_vctot]
    addpd  xmm5, xmm9
    addpd  xmm1, xmm5
    movapd [rsp + nb304_vctot], xmm1
    
    movapd xmm10, [rsp + nb304_tsc]
    mulpd  xmm3, xmm10  ;# fscal
    mulpd  xmm7, xmm10
    mulpd  xmm10, xmm11
    
    xorpd xmm4, xmm4
    xorpd xmm8, xmm8
    xorpd xmm11, xmm11
    
    subpd xmm4, xmm3
    subpd xmm8, xmm7
    subpd xmm11, xmm10
    
    mulpd xmm4, [rsp + nb304_rinvH1H2]
    mulpd xmm8, [rsp + nb304_rinvH2H2]
    mulpd xmm11, [rsp + nb304_rinvMH2]
    
    ;# move j H2 forces to xmm0-xmm2
    mov rdi, [rbp + nb304_faction]
	movlpd xmm0, [rdi + rax*8 + 48]
	movlpd xmm1, [rdi + rax*8 + 56]
	movlpd xmm2, [rdi + rax*8 + 64]
	movhpd xmm0, [rdi + rbx*8 + 48]
	movhpd xmm1, [rdi + rbx*8 + 56]
	movhpd xmm2, [rdi + rbx*8 + 64]

    movapd xmm3, xmm4
    movapd xmm5, xmm4
    movapd xmm7, xmm8
    movapd xmm9, xmm8
    movapd xmm10, xmm11
    movapd xmm12, xmm11

	mulpd xmm3, [rsp + nb304_dxH1H2]
	mulpd xmm4, [rsp + nb304_dyH1H2]
	mulpd xmm5, [rsp + nb304_dzH1H2]
	mulpd xmm7, [rsp + nb304_dxH2H2]
	mulpd xmm8, [rsp + nb304_dyH2H2]
	mulpd xmm9, [rsp + nb304_dzH2H2]
	mulpd xmm10, [rsp + nb304_dxMH2]
	mulpd xmm11, [rsp + nb304_dyMH2]
	mulpd xmm12, [rsp + nb304_dzMH2]

    addpd xmm0, xmm3
    addpd xmm1, xmm4
    addpd xmm2, xmm5
    addpd xmm3, [rsp + nb304_fixH1]
    addpd xmm4, [rsp + nb304_fiyH1]
    addpd xmm5, [rsp + nb304_fizH1]

    addpd xmm0, xmm7
    addpd xmm1, xmm8
    addpd xmm2, xmm9
    addpd xmm7, [rsp + nb304_fixH2]
    addpd xmm8, [rsp + nb304_fiyH2]
    addpd xmm9, [rsp + nb304_fizH2]

    addpd xmm0, xmm10
    addpd xmm1, xmm11
    addpd xmm2, xmm12
    addpd xmm10, [rsp + nb304_fixM]
    addpd xmm11, [rsp + nb304_fiyM]
    addpd xmm12, [rsp + nb304_fizM]

    movapd [rsp + nb304_fixH1], xmm3
    movapd [rsp + nb304_fiyH1], xmm4
    movapd [rsp + nb304_fizH1], xmm5
    movapd [rsp + nb304_fixH2], xmm7
    movapd [rsp + nb304_fiyH2], xmm8
    movapd [rsp + nb304_fizH2], xmm9
    movapd [rsp + nb304_fixM], xmm10
    movapd [rsp + nb304_fiyM], xmm11
    movapd [rsp + nb304_fizM], xmm12
   
    ;# store back j H2 forces from xmm0-xmm2
	movlpd [rdi + rax*8 + 48], xmm0
	movlpd [rdi + rax*8 + 56], xmm1
	movlpd [rdi + rax*8 + 64], xmm2
	movhpd [rdi + rbx*8 + 48], xmm0
	movhpd [rdi + rbx*8 + 56], xmm1
	movhpd [rdi + rbx*8 + 64], xmm2
       
	;# move j M coordinates to local temp variables 
    mov rsi, [rbp + nb304_pos]
    movlpd xmm0, [rsi + rax*8 + 72] 
    movlpd xmm1, [rsi + rax*8 + 80] 
    movlpd xmm2, [rsi + rax*8 + 88] 
    movhpd xmm0, [rsi + rbx*8 + 72] 
    movhpd xmm1, [rsi + rbx*8 + 80] 
    movhpd xmm2, [rsi + rbx*8 + 88] 

    ;# xmm0 = Mx
    ;# xmm1 = My
    ;# xmm2 = Mz
        
    movapd xmm3, xmm0
    movapd xmm4, xmm1
    movapd xmm5, xmm2
    movapd xmm6, xmm0
    movapd xmm7, xmm1
    movapd xmm8, xmm2
    
    subpd xmm0, [rsp + nb304_ixH1]
    subpd xmm1, [rsp + nb304_iyH1]
    subpd xmm2, [rsp + nb304_izH1]
    subpd xmm3, [rsp + nb304_ixH2]
    subpd xmm4, [rsp + nb304_iyH2]
    subpd xmm5, [rsp + nb304_izH2]
    subpd xmm6, [rsp + nb304_ixM]
    subpd xmm7, [rsp + nb304_iyM]
    subpd xmm8, [rsp + nb304_izM]
    
	movapd [rsp + nb304_dxH1M], xmm0
	movapd [rsp + nb304_dyH1M], xmm1
	movapd [rsp + nb304_dzH1M], xmm2
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	movapd [rsp + nb304_dxH2M], xmm3
	movapd [rsp + nb304_dyH2M], xmm4
	movapd [rsp + nb304_dzH2M], xmm5
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	movapd [rsp + nb304_dxMM], xmm6
	movapd [rsp + nb304_dyMM], xmm7
	movapd [rsp + nb304_dzMM], xmm8
	mulpd  xmm6, xmm6
	mulpd  xmm7, xmm7
	mulpd  xmm8, xmm8
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm3, xmm4
	addpd  xmm3, xmm5
    addpd  xmm6, xmm7
    addpd  xmm6, xmm8

	;# start doing invsqrt for jM atoms
    cvtpd2ps xmm1, xmm0
    cvtpd2ps xmm4, xmm3
    cvtpd2ps xmm7, xmm6
	rsqrtps xmm1, xmm1
	rsqrtps xmm4, xmm4
    rsqrtps xmm7, xmm7
    cvtps2pd xmm1, xmm1
    cvtps2pd xmm4, xmm4
    cvtps2pd xmm7, xmm7
	
	movapd  xmm2, xmm1
	movapd  xmm5, xmm4
    movapd  xmm8, xmm7
    
	mulpd   xmm1, xmm1 ;# lu*lu
	mulpd   xmm4, xmm4 ;# lu*lu
    mulpd   xmm7, xmm7 ;# lu*lu
		
	movapd  xmm9, [rsp + nb304_three]
	movapd  xmm10, xmm9
    movapd  xmm11, xmm9

	mulpd   xmm1, xmm0 ;# rsq*lu*lu
	mulpd   xmm4, xmm3 ;# rsq*lu*lu 
    mulpd   xmm7, xmm6 ;# rsq*lu*lu
	
	subpd   xmm9, xmm1
	subpd   xmm10, xmm4
    subpd   xmm11, xmm7 ;# 3-rsq*lu*lu

	mulpd   xmm9, xmm2
	mulpd   xmm10, xmm5
    mulpd   xmm11, xmm8 ;# lu*(3-rsq*lu*lu)

	movapd  xmm15, [rsp + nb304_half]
	mulpd   xmm9, xmm15  ;# first iteration for rinvH1M 
	mulpd   xmm10, xmm15 ;# first iteration for rinvH2M
    mulpd   xmm11, xmm15 ;# first iteration for rinvMM

    ;# second iteration step    
	movapd  xmm2, xmm9
	movapd  xmm5, xmm10
    movapd  xmm8, xmm11
    
	mulpd   xmm2, xmm2 ;# lu*lu
	mulpd   xmm5, xmm5 ;# lu*lu
    mulpd   xmm8, xmm8 ;# lu*lu
		
	movapd  xmm1, [rsp + nb304_three]
	movapd  xmm4, xmm1
    movapd  xmm7, xmm1

	mulpd   xmm2, xmm0 ;# rsq*lu*lu
	mulpd   xmm5, xmm3 ;# rsq*lu*lu 
    mulpd   xmm8, xmm6 ;# rsq*lu*lu
	
	subpd   xmm1, xmm2
	subpd   xmm4, xmm5
    subpd   xmm7, xmm8 ;# 3-rsq*lu*lu

	mulpd   xmm9, xmm1
	mulpd   xmm10, xmm4
    mulpd   xmm11, xmm7 ;# lu*(3-rsq*lu*lu)

	movapd  xmm15, [rsp + nb304_half]
	mulpd   xmm9, xmm15  ;#  rinvH1M
	mulpd   xmm10, xmm15 ;#   rinvH2M
    mulpd   xmm11, xmm15 ;#   rinvMM
    
	
	movapd  [rsp + nb304_rinvH1M], xmm9
	movapd  [rsp + nb304_rinvH2M], xmm10
	movapd  [rsp + nb304_rinvMM], xmm11
	
	;# M interactions 
    ;# rsq in xmm0,xmm3,xmm6  
    ;# rinv in xmm9, xmm10, xmm11

    movapd xmm1, [rsp + nb304_tsc]
    mulpd  xmm0, xmm9  ;# r
    mulpd  xmm3, xmm10
    mulpd  xmm6, xmm11
    mulpd  xmm0, xmm1 ;# rtab
    mulpd  xmm3, xmm1
    mulpd  xmm6, xmm1
    
    ;# truncate and convert to integers
    cvttpd2dq xmm1, xmm0
    cvttpd2dq xmm4, xmm3
    cvttpd2dq xmm7, xmm6        

    ;# convert back to float
    cvtdq2pd  xmm2, xmm1
    cvtdq2pd  xmm5, xmm4
    cvtdq2pd  xmm8, xmm7
    
    ;# multiply by 4
    pslld   xmm1, 2
    pslld   xmm4, 2
    pslld   xmm7, 2
    
    ;# move to integer registers
    pshufd xmm13, xmm1, 1
    pshufd xmm14, xmm4, 1
    pshufd xmm15, xmm7, 1
    movd    r8d, xmm1
    movd    r10d, xmm4
    movd    r12d, xmm7
    movd    r9d, xmm13
    movd    r11d, xmm14
    movd    r13d, xmm15
        
    mov  rsi, [rbp + nb304_VFtab]

    ;# calculate eps
    subpd     xmm0, xmm2
    subpd     xmm3, xmm5
    subpd     xmm6, xmm8

    movapd    [rsp + nb304_epsH1], xmm0
    movapd    [rsp + nb304_epsH2], xmm3
    movapd    [rsp + nb304_epsM], xmm6

    ;# Load LOTS of table data
    movlpd xmm0,  [rsi + r8*8]
    movlpd xmm1,  [rsi + r8*8 + 8]
    movlpd xmm2,  [rsi + r8*8 + 16]
    movlpd xmm3,  [rsi + r8*8 + 24]
    movlpd xmm4,  [rsi + r10*8]
    movlpd xmm5,  [rsi + r10*8 + 8]
    movlpd xmm6,  [rsi + r10*8 + 16]
    movlpd xmm7,  [rsi + r10*8 + 24]
    movlpd xmm8,  [rsi + r12*8]
    movlpd xmm9,  [rsi + r12*8 + 8]
    movlpd xmm10, [rsi + r12*8 + 16]
    movlpd xmm11, [rsi + r12*8 + 24]
    movhpd xmm0,  [rsi + r9*8]
    movhpd xmm1,  [rsi + r9*8 + 8]
    movhpd xmm2,  [rsi + r9*8 + 16]
    movhpd xmm3,  [rsi + r9*8 + 24]
    movhpd xmm4,  [rsi + r11*8]
    movhpd xmm5,  [rsi + r11*8 + 8]
    movhpd xmm6,  [rsi + r11*8 + 16]
    movhpd xmm7,  [rsi + r11*8 + 24]
    movhpd xmm8,  [rsi + r13*8]
    movhpd xmm9,  [rsi + r13*8 + 8]
    movhpd xmm10, [rsi + r13*8 + 16]
    movhpd xmm11, [rsi + r13*8 + 24]
    ;# table data ready in xmm0-xmm3 , xmm4-xmm7 , and xmm8-xmm11
    
    movapd xmm12, [rsp + nb304_epsH1]
    movapd xmm13, [rsp + nb304_epsH2]
    movapd xmm14, [rsp + nb304_epsM]
    
    mulpd  xmm3, xmm12   ;# Heps
    mulpd  xmm7, xmm13
    mulpd  xmm11, xmm14 
    mulpd  xmm2, xmm12   ;# Geps
    mulpd  xmm6, xmm13
    mulpd  xmm10, xmm14 
    mulpd  xmm3, xmm12   ;# Heps2
    mulpd  xmm7, xmm13
    mulpd  xmm11, xmm14 

    addpd  xmm1, xmm2   ;# F+Geps
    addpd  xmm5, xmm6
    addpd  xmm9, xmm10 
    addpd  xmm1, xmm3   ;# F+Geps+Heps2 = Fp
    addpd  xmm5, xmm7
    addpd  xmm9, xmm11 
    addpd  xmm3, xmm3    ;# 2*Heps2
    addpd  xmm7, xmm7
    addpd  xmm11, xmm11
    addpd  xmm3, xmm2    ;# 2*Heps2+Geps
    addpd  xmm7, xmm6  
    addpd  xmm11, xmm10
    addpd  xmm3, xmm1   ;# FF = Fp + 2*Heps2 + Geps
    addpd  xmm7, xmm5
    addpd  xmm11, xmm9
    mulpd  xmm1, xmm12   ;# eps*Fp
    mulpd  xmm5, xmm13
    mulpd  xmm9, xmm14
    movapd xmm12, [rsp + nb304_qqMH]
    movapd xmm13, [rsp + nb304_qqMM]
    addpd  xmm1, xmm0     ;# VV
    addpd  xmm5, xmm4
    addpd  xmm9, xmm8
    mulpd  xmm1, xmm12   ;# VV*qq = vcoul
    mulpd  xmm5, xmm12
    mulpd  xmm9, xmm13
    mulpd  xmm3, xmm12    ;# FF*qq = fij
    mulpd  xmm7, xmm12
    mulpd  xmm11, xmm13
    
    ;# accumulate vctot
    addpd  xmm1, [rsp + nb304_vctot]
    addpd  xmm5, xmm9
    addpd  xmm1, xmm5
    movapd [rsp + nb304_vctot], xmm1
    
    movapd xmm10, [rsp + nb304_tsc]
    mulpd  xmm3, xmm10  ;# fscal
    mulpd  xmm7, xmm10
    mulpd  xmm10, xmm11
        
    xorpd xmm4, xmm4
    xorpd xmm8, xmm8
    xorpd xmm11, xmm11
    
    subpd xmm4, xmm3
    subpd xmm8, xmm7
    subpd xmm11, xmm10
    
    mulpd xmm4, [rsp + nb304_rinvH1M]
    mulpd xmm8, [rsp + nb304_rinvH2M]
    mulpd xmm11, [rsp + nb304_rinvMM]
    
    ;# move j M forces to xmm0-xmm2
    mov rdi, [rbp + nb304_faction]
	movlpd xmm0, [rdi + rax*8 + 72]
	movlpd xmm1, [rdi + rax*8 + 80]
	movlpd xmm2, [rdi + rax*8 + 88]
	movhpd xmm0, [rdi + rbx*8 + 72]
	movhpd xmm1, [rdi + rbx*8 + 80]
	movhpd xmm2, [rdi + rbx*8 + 88]

    movapd xmm3, xmm4
    movapd xmm5, xmm4
    movapd xmm7, xmm8
    movapd xmm9, xmm8
    movapd xmm10, xmm11
    movapd xmm12, xmm11

	mulpd xmm3, [rsp + nb304_dxH1M]
	mulpd xmm4, [rsp + nb304_dyH1M]
	mulpd xmm5, [rsp + nb304_dzH1M]
	mulpd xmm7, [rsp + nb304_dxH2M]
	mulpd xmm8, [rsp + nb304_dyH2M]
	mulpd xmm9, [rsp + nb304_dzH2M]
	mulpd xmm10, [rsp + nb304_dxMM]
	mulpd xmm11, [rsp + nb304_dyMM]
	mulpd xmm12, [rsp + nb304_dzMM]

    addpd xmm0, xmm3
    addpd xmm1, xmm4
    addpd xmm2, xmm5
    addpd xmm3, [rsp + nb304_fixH1]
    addpd xmm4, [rsp + nb304_fiyH1]
    addpd xmm5, [rsp + nb304_fizH1]

    addpd xmm0, xmm7
    addpd xmm1, xmm8
    addpd xmm2, xmm9
    addpd xmm7, [rsp + nb304_fixH2]
    addpd xmm8, [rsp + nb304_fiyH2]
    addpd xmm9, [rsp + nb304_fizH2]

    addpd xmm0, xmm10
    addpd xmm1, xmm11
    addpd xmm2, xmm12
    addpd xmm10, [rsp + nb304_fixM]
    addpd xmm11, [rsp + nb304_fiyM]
    addpd xmm12, [rsp + nb304_fizM]

    movapd [rsp + nb304_fixH1], xmm3
    movapd [rsp + nb304_fiyH1], xmm4
    movapd [rsp + nb304_fizH1], xmm5
    movapd [rsp + nb304_fixH2], xmm7
    movapd [rsp + nb304_fiyH2], xmm8
    movapd [rsp + nb304_fizH2], xmm9
    movapd [rsp + nb304_fixM], xmm10
    movapd [rsp + nb304_fiyM], xmm11
    movapd [rsp + nb304_fizM], xmm12
   
    ;# store back j M forces from xmm0-xmm2
	movlpd [rdi + rax*8 + 72], xmm0
	movlpd [rdi + rax*8 + 80], xmm1
	movlpd [rdi + rax*8 + 88], xmm2
	movhpd [rdi + rbx*8 + 72], xmm0
	movhpd [rdi + rbx*8 + 80], xmm1
	movhpd [rdi + rbx*8 + 88], xmm2
	
	;# should we do one more iteration? 
	sub dword ptr [rsp + nb304_innerk],  2
	jl    .nb304_checksingle
	jmp   .nb304_unroll_loop
.nb304_checksingle:
	mov   edx, [rsp + nb304_innerk]
	and   edx, 1
	jnz   .nb304_dosingle
	jmp   .nb304_updateouterdata
.nb304_dosingle:
	mov   rdx, [rsp + nb304_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [rdx]	

	mov rsi, [rbp + nb304_pos]
	lea   rax, [rax + rax*2]  

	
	;# move j H1 coordinates to local temp variables 
    movsd xmm0, [rsi + rax*8 + 24] 
    movsd xmm1, [rsi + rax*8 + 32] 
    movsd xmm2, [rsi + rax*8 + 40] 

    ;# xmm0 = H1x
    ;# xmm1 = H1y
    ;# xmm2 = H1z
        
    movsd xmm3, xmm0
    movsd xmm4, xmm1
    movsd xmm5, xmm2
    movsd xmm6, xmm0
    movsd xmm7, xmm1
    movsd xmm8, xmm2
    
    subsd xmm0, [rsp + nb304_ixH1]
    subsd xmm1, [rsp + nb304_iyH1]
    subsd xmm2, [rsp + nb304_izH1]
    subsd xmm3, [rsp + nb304_ixH2]
    subsd xmm4, [rsp + nb304_iyH2]
    subsd xmm5, [rsp + nb304_izH2]
    subsd xmm6, [rsp + nb304_ixM]
    subsd xmm7, [rsp + nb304_iyM]
    subsd xmm8, [rsp + nb304_izM]
    
	movsd [rsp + nb304_dxH1H1], xmm0
	movsd [rsp + nb304_dyH1H1], xmm1
	movsd [rsp + nb304_dzH1H1], xmm2
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	movsd [rsp + nb304_dxH2H1], xmm3
	movsd [rsp + nb304_dyH2H1], xmm4
	movsd [rsp + nb304_dzH2H1], xmm5
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	movsd [rsp + nb304_dxMH1], xmm6
	movsd [rsp + nb304_dyMH1], xmm7
	movsd [rsp + nb304_dzMH1], xmm8
	mulsd  xmm6, xmm6
	mulsd  xmm7, xmm7
	mulsd  xmm8, xmm8
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm3, xmm4
	addsd  xmm3, xmm5
    addsd  xmm6, xmm7
    addsd  xmm6, xmm8

	;# start doing invsqrt for jH1 atoms
    cvtsd2ss xmm1, xmm0
    cvtsd2ss xmm4, xmm3
    cvtsd2ss xmm7, xmm6
	rsqrtss xmm1, xmm1
	rsqrtss xmm4, xmm4
    rsqrtss xmm7, xmm7
    cvtss2sd xmm1, xmm1
    cvtss2sd xmm4, xmm4
    cvtss2sd xmm7, xmm7
	
	movsd  xmm2, xmm1
	movsd  xmm5, xmm4
    movsd  xmm8, xmm7
    
	mulsd   xmm1, xmm1 ;# lu*lu
	mulsd   xmm4, xmm4 ;# lu*lu
    mulsd   xmm7, xmm7 ;# lu*lu
		
	movsd  xmm9, [rsp + nb304_three]
	movsd  xmm10, xmm9
    movsd  xmm11, xmm9

	mulsd   xmm1, xmm0 ;# rsq*lu*lu
	mulsd   xmm4, xmm3 ;# rsq*lu*lu 
    mulsd   xmm7, xmm6 ;# rsq*lu*lu
	
	subsd   xmm9, xmm1
	subsd   xmm10, xmm4
    subsd   xmm11, xmm7 ;# 3-rsq*lu*lu

	mulsd   xmm9, xmm2
	mulsd   xmm10, xmm5
    mulsd   xmm11, xmm8 ;# lu*(3-rsq*lu*lu)

	movsd  xmm15, [rsp + nb304_half]
	mulsd   xmm9, xmm15  ;# first iteration for rinvH1H1 
	mulsd   xmm10, xmm15 ;# first iteration for rinvH2H1
    mulsd   xmm11, xmm15 ;# first iteration for rinvMH1	

    ;# second iteration step    
	movsd  xmm2, xmm9
	movsd  xmm5, xmm10
    movsd  xmm8, xmm11
    
	mulsd   xmm2, xmm2 ;# lu*lu
	mulsd   xmm5, xmm5 ;# lu*lu
    mulsd   xmm8, xmm8 ;# lu*lu
		
	movsd  xmm1, [rsp + nb304_three]
	movsd  xmm4, xmm1
    movsd  xmm7, xmm1

	mulsd   xmm2, xmm0 ;# rsq*lu*lu
	mulsd   xmm5, xmm3 ;# rsq*lu*lu 
    mulsd   xmm8, xmm6 ;# rsq*lu*lu
	
	subsd   xmm1, xmm2
	subsd   xmm4, xmm5
    subsd   xmm7, xmm8 ;# 3-rsq*lu*lu

	mulsd   xmm9, xmm1
	mulsd   xmm10, xmm4
    mulsd   xmm11, xmm7 ;# lu*(3-rsq*lu*lu)

	movsd  xmm15, [rsp + nb304_half]
	mulsd   xmm9, xmm15  ;#  rinvH1H1 
	mulsd   xmm10, xmm15 ;#   rinvH2H1
    mulsd   xmm11, xmm15 ;#   rinvMH1
		
	movsd  [rsp + nb304_rinvH1H1], xmm9
	movsd  [rsp + nb304_rinvH2H1], xmm10
	movsd  [rsp + nb304_rinvMH1], xmm11
	
	;# H1 interactions 
    ;# rsq in xmm0,xmm3,xmm6  
    ;# rinv in xmm9, xmm10, xmm11

    movsd  xmm1, [rsp + nb304_tsc]
    mulsd  xmm0, xmm9  ;# r
    mulsd  xmm3, xmm10
    mulsd  xmm6, xmm11
    mulsd  xmm0, xmm1 ;# rtab
    mulsd  xmm3, xmm1
    mulsd  xmm6, xmm1
    
    ;# truncate and convert to integers
    cvttsd2si r8d, xmm0
    cvttsd2si r10d, xmm3
    cvttsd2si r12d, xmm6        

    ;# convert back to float
    cvtsi2sd  xmm2, r8d
    cvtsi2sd  xmm5, r10d
    cvtsi2sd  xmm8, r12d
    
    ;# multiply by 4
    shl   r8, 2
    shl   r10d, 2
    shl   r12d, 2
    
    mov  rsi, [rbp + nb304_VFtab]

    ;# calculate eps
    subsd     xmm0, xmm2
    subsd     xmm3, xmm5
    subsd     xmm6, xmm8

    movsd    [rsp + nb304_epsH1], xmm0
    movsd    [rsp + nb304_epsH2], xmm3
    movsd    [rsp + nb304_epsM], xmm6

    ;# Load LOTS of table data
    movsd xmm0,  [rsi + r8*8]
    movsd xmm1,  [rsi + r8*8 + 8]
    movsd xmm2,  [rsi + r8*8 + 16]
    movsd xmm3,  [rsi + r8*8 + 24]
    movsd xmm4,  [rsi + r10*8]
    movsd xmm5,  [rsi + r10*8 + 8]
    movsd xmm6,  [rsi + r10*8 + 16]
    movsd xmm7,  [rsi + r10*8 + 24]
    movsd xmm8,  [rsi + r12*8]
    movsd xmm9,  [rsi + r12*8 + 8]
    movsd xmm10, [rsi + r12*8 + 16]
    movsd xmm11, [rsi + r12*8 + 24]
    ;# table data ready in xmm0-xmm3 , xmm4-xmm7 , and xmm8-xmm11
    
    movsd xmm12, [rsp + nb304_epsH1]
    movsd xmm13, [rsp + nb304_epsH2]
    movsd xmm14, [rsp + nb304_epsM]
    
    mulsd  xmm3, xmm12   ;# Heps
    mulsd  xmm7, xmm13
    mulsd  xmm11, xmm14 
    mulsd  xmm2, xmm12   ;# Geps
    mulsd  xmm6, xmm13
    mulsd  xmm10, xmm14 
    mulsd  xmm3, xmm12   ;# Heps2
    mulsd  xmm7, xmm13
    mulsd  xmm11, xmm14 

    addsd  xmm1, xmm2   ;# F+Geps
    addsd  xmm5, xmm6
    addsd  xmm9, xmm10 
    addsd  xmm1, xmm3   ;# F+Geps+Heps2 = Fp
    addsd  xmm5, xmm7
    addsd  xmm9, xmm11 
    addsd  xmm3, xmm3    ;# 2*Heps2
    addsd  xmm7, xmm7
    addsd  xmm11, xmm11
    addsd  xmm3, xmm2    ;# 2*Heps2+Geps
    addsd  xmm7, xmm6  
    addsd  xmm11, xmm10
    addsd  xmm3, xmm1   ;# FF = Fp + 2*Heps2 + Geps
    addsd  xmm7, xmm5
    addsd  xmm11, xmm9
    mulsd  xmm1, xmm12   ;# eps*Fp
    mulsd  xmm5, xmm13
    mulsd  xmm9, xmm14
    movsd xmm12, [rsp + nb304_qqHH]
    movsd xmm13, [rsp + nb304_qqMH]
    addsd  xmm1, xmm0     ;# VV
    addsd  xmm5, xmm4
    addsd  xmm9, xmm8
    mulsd  xmm1, xmm12   ;# VV*qq = vcoul
    mulsd  xmm5, xmm12
    mulsd  xmm9, xmm13
    mulsd  xmm3, xmm12    ;# FF*qq = fij
    mulsd  xmm7, xmm12
    mulsd  xmm11, xmm13
    
    ;# accumulate vctot
    addsd  xmm1, [rsp + nb304_vctot]
    addsd  xmm5, xmm9
    addsd  xmm1, xmm5
    movsd [rsp + nb304_vctot], xmm1
    
    movsd xmm10, [rsp + nb304_tsc]
    mulsd  xmm3, xmm10  ;# fscal
    mulsd  xmm7, xmm10
    mulsd  xmm10, xmm11
    
    xorpd xmm4, xmm4
    xorpd xmm8, xmm8
    xorpd xmm11, xmm11
    
    subsd xmm4, xmm3
    subsd xmm8, xmm7
    subsd xmm11, xmm10

    mulsd xmm4, [rsp + nb304_rinvH1H1]
    mulsd xmm8, [rsp + nb304_rinvH2H1]
    mulsd xmm11, [rsp + nb304_rinvMH1]
    
    ;# move j H1 forces to xmm0-xmm2
    mov rdi, [rbp + nb304_faction]
	movsd xmm0, [rdi + rax*8 + 24]
	movsd xmm1, [rdi + rax*8 + 32]
	movsd xmm2, [rdi + rax*8 + 40]

    movapd xmm3, xmm4
    movapd xmm5, xmm4
    movapd xmm7, xmm8
    movapd xmm9, xmm8
    movapd xmm10, xmm11
    movapd xmm12, xmm11

	mulsd xmm3, [rsp + nb304_dxH1H1]
	mulsd xmm4, [rsp + nb304_dyH1H1]
	mulsd xmm5, [rsp + nb304_dzH1H1]
	mulsd xmm7, [rsp + nb304_dxH2H1]
	mulsd xmm8, [rsp + nb304_dyH2H1]
	mulsd xmm9, [rsp + nb304_dzH2H1]
	mulsd xmm10, [rsp + nb304_dxMH1]
	mulsd xmm11, [rsp + nb304_dyMH1]
	mulsd xmm12, [rsp + nb304_dzMH1]

    addsd xmm0, xmm3
    addsd xmm1, xmm4
    addsd xmm2, xmm5
    addsd xmm3, [rsp + nb304_fixH1]
    addsd xmm4, [rsp + nb304_fiyH1]
    addsd xmm5, [rsp + nb304_fizH1]

    addsd xmm0, xmm7
    addsd xmm1, xmm8
    addsd xmm2, xmm9
    addsd xmm7, [rsp + nb304_fixH2]
    addsd xmm8, [rsp + nb304_fiyH2]
    addsd xmm9, [rsp + nb304_fizH2]

    addsd xmm0, xmm10
    addsd xmm1, xmm11
    addsd xmm2, xmm12
    addsd xmm10, [rsp + nb304_fixM]
    addsd xmm11, [rsp + nb304_fiyM]
    addsd xmm12, [rsp + nb304_fizM]

    movsd [rsp + nb304_fixH1], xmm3
    movsd [rsp + nb304_fiyH1], xmm4
    movsd [rsp + nb304_fizH1], xmm5
    movsd [rsp + nb304_fixH2], xmm7
    movsd [rsp + nb304_fiyH2], xmm8
    movsd [rsp + nb304_fizH2], xmm9
    movsd [rsp + nb304_fixM], xmm10
    movsd [rsp + nb304_fiyM], xmm11
    movsd [rsp + nb304_fizM], xmm12
   
    ;# store back j H1 forces from xmm0-xmm2
	movsd [rdi + rax*8 + 24], xmm0
	movsd [rdi + rax*8 + 32], xmm1
	movsd [rdi + rax*8 + 40], xmm2

	;# move j H2 coordinates to local temp variables 
    mov rsi, [rbp + nb304_pos]
    movsd xmm0, [rsi + rax*8 + 48] 
    movsd xmm1, [rsi + rax*8 + 56] 
    movsd xmm2, [rsi + rax*8 + 64] 

    ;# xmm0 = H2x
    ;# xmm1 = H2y
    ;# xmm2 = H2z
        
    movsd xmm3, xmm0
    movsd xmm4, xmm1
    movsd xmm5, xmm2
    movsd xmm6, xmm0
    movsd xmm7, xmm1
    movsd xmm8, xmm2
    
    subsd xmm0, [rsp + nb304_ixH1]
    subsd xmm1, [rsp + nb304_iyH1]
    subsd xmm2, [rsp + nb304_izH1]
    subsd xmm3, [rsp + nb304_ixH2]
    subsd xmm4, [rsp + nb304_iyH2]
    subsd xmm5, [rsp + nb304_izH2]
    subsd xmm6, [rsp + nb304_ixM]
    subsd xmm7, [rsp + nb304_iyM]
    subsd xmm8, [rsp + nb304_izM]
    
	movsd [rsp + nb304_dxH1H2], xmm0
	movsd [rsp + nb304_dyH1H2], xmm1
	movsd [rsp + nb304_dzH1H2], xmm2
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	movsd [rsp + nb304_dxH2H2], xmm3
	movsd [rsp + nb304_dyH2H2], xmm4
	movsd [rsp + nb304_dzH2H2], xmm5
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	movsd [rsp + nb304_dxMH2], xmm6
	movsd [rsp + nb304_dyMH2], xmm7
	movsd [rsp + nb304_dzMH2], xmm8
	mulsd  xmm6, xmm6
	mulsd  xmm7, xmm7
	mulsd  xmm8, xmm8
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm3, xmm4
	addsd  xmm3, xmm5
    addsd  xmm6, xmm7
    addsd  xmm6, xmm8

	;# start doing invsqrt for jH2 atoms
    cvtsd2ss xmm1, xmm0
    cvtsd2ss xmm4, xmm3
    cvtsd2ss xmm7, xmm6
	rsqrtss xmm1, xmm1
	rsqrtss xmm4, xmm4
    rsqrtss xmm7, xmm7
    cvtss2sd xmm1, xmm1
    cvtss2sd xmm4, xmm4
    cvtss2sd xmm7, xmm7
	
	movsd  xmm2, xmm1
	movsd  xmm5, xmm4
    movsd  xmm8, xmm7
    
	mulsd   xmm1, xmm1 ;# lu*lu
	mulsd   xmm4, xmm4 ;# lu*lu
    mulsd   xmm7, xmm7 ;# lu*lu
		
	movsd  xmm9, [rsp + nb304_three]
	movsd  xmm10, xmm9
    movsd  xmm11, xmm9

	mulsd   xmm1, xmm0 ;# rsq*lu*lu
	mulsd   xmm4, xmm3 ;# rsq*lu*lu 
    mulsd   xmm7, xmm6 ;# rsq*lu*lu
	
	subsd   xmm9, xmm1
	subsd   xmm10, xmm4
    subsd   xmm11, xmm7 ;# 3-rsq*lu*lu

	mulsd   xmm9, xmm2
	mulsd   xmm10, xmm5
    mulsd   xmm11, xmm8 ;# lu*(3-rsq*lu*lu)

	movsd  xmm15, [rsp + nb304_half]
	mulsd   xmm9, xmm15  ;# first iteration for rinvH1H2 
	mulsd   xmm10, xmm15 ;# first iteration for rinvH2H2
    mulsd   xmm11, xmm15 ;# first iteration for rinvMH2

    ;# second iteration step    
	movsd  xmm2, xmm9
	movsd  xmm5, xmm10
    movsd  xmm8, xmm11
    
	mulsd   xmm2, xmm2 ;# lu*lu
	mulsd   xmm5, xmm5 ;# lu*lu
    mulsd   xmm8, xmm8 ;# lu*lu
		
	movsd  xmm1, [rsp + nb304_three]
	movsd  xmm4, xmm1
    movsd  xmm7, xmm1

	mulsd   xmm2, xmm0 ;# rsq*lu*lu
	mulsd   xmm5, xmm3 ;# rsq*lu*lu 
    mulsd   xmm8, xmm6 ;# rsq*lu*lu
	
	subsd   xmm1, xmm2
	subsd   xmm4, xmm5
    subsd   xmm7, xmm8 ;# 3-rsq*lu*lu

	mulsd   xmm9, xmm1
	mulsd   xmm10, xmm4
    mulsd   xmm11, xmm7 ;# lu*(3-rsq*lu*lu)

	movsd  xmm15, [rsp + nb304_half]
	mulsd   xmm9, xmm15  ;#  rinvH1H2
	mulsd   xmm10, xmm15 ;#   rinvH2H2
    mulsd   xmm11, xmm15 ;#   rinvMH2
	
	movsd  [rsp + nb304_rinvH1H2], xmm9
	movsd  [rsp + nb304_rinvH2H2], xmm10
	movsd  [rsp + nb304_rinvMH2], xmm11
	
	;# H2 interactions 
    ;# rsq in xmm0,xmm3,xmm6  
    ;# rinv in xmm9, xmm10, xmm11

    movsd  xmm1, [rsp + nb304_tsc]
    mulsd  xmm0, xmm9  ;# r
    mulsd  xmm3, xmm10
    mulsd  xmm6, xmm11
    mulsd  xmm0, xmm1 ;# rtab
    mulsd  xmm3, xmm1
    mulsd  xmm6, xmm1
    
    ;# truncate and convert to integers
    cvttsd2si r8d, xmm0
    cvttsd2si r10d, xmm3
    cvttsd2si r12d, xmm6        

    ;# convert back to float
    cvtsi2sd  xmm2, r8d
    cvtsi2sd  xmm5, r10d
    cvtsi2sd  xmm8, r12d
    
    ;# multiply by 4
    shl   r8, 2
    shl   r10d, 2
    shl   r12d, 2
    
    mov  rsi, [rbp + nb304_VFtab]

    ;# calculate eps
    subsd     xmm0, xmm2
    subsd     xmm3, xmm5
    subsd     xmm6, xmm8

    movsd    [rsp + nb304_epsH1], xmm0
    movsd    [rsp + nb304_epsH2], xmm3
    movsd    [rsp + nb304_epsM], xmm6

    ;# Load LOTS of table data
    movsd xmm0,  [rsi + r8*8]
    movsd xmm1,  [rsi + r8*8 + 8]
    movsd xmm2,  [rsi + r8*8 + 16]
    movsd xmm3,  [rsi + r8*8 + 24]
    movsd xmm4,  [rsi + r10*8]
    movsd xmm5,  [rsi + r10*8 + 8]
    movsd xmm6,  [rsi + r10*8 + 16]
    movsd xmm7,  [rsi + r10*8 + 24]
    movsd xmm8,  [rsi + r12*8]
    movsd xmm9,  [rsi + r12*8 + 8]
    movsd xmm10, [rsi + r12*8 + 16]
    movsd xmm11, [rsi + r12*8 + 24]
    ;# table data ready in xmm0-xmm3 , xmm4-xmm7 , and xmm8-xmm11
    
    movsd xmm12, [rsp + nb304_epsH1]
    movsd xmm13, [rsp + nb304_epsH2]
    movsd xmm14, [rsp + nb304_epsM]
    
    mulsd  xmm3, xmm12   ;# Heps
    mulsd  xmm7, xmm13
    mulsd  xmm11, xmm14 
    mulsd  xmm2, xmm12   ;# Geps
    mulsd  xmm6, xmm13
    mulsd  xmm10, xmm14 
    mulsd  xmm3, xmm12   ;# Heps2
    mulsd  xmm7, xmm13
    mulsd  xmm11, xmm14 

    addsd  xmm1, xmm2   ;# F+Geps
    addsd  xmm5, xmm6
    addsd  xmm9, xmm10 
    addsd  xmm1, xmm3   ;# F+Geps+Heps2 = Fp
    addsd  xmm5, xmm7
    addsd  xmm9, xmm11 
    addsd  xmm3, xmm3    ;# 2*Heps2
    addsd  xmm7, xmm7
    addsd  xmm11, xmm11
    addsd  xmm3, xmm2    ;# 2*Heps2+Geps
    addsd  xmm7, xmm6  
    addsd  xmm11, xmm10
    addsd  xmm3, xmm1   ;# FF = Fp + 2*Heps2 + Geps
    addsd  xmm7, xmm5
    addsd  xmm11, xmm9
    mulsd  xmm1, xmm12   ;# eps*Fp
    mulsd  xmm5, xmm13
    mulsd  xmm9, xmm14
    movsd xmm12, [rsp + nb304_qqHH]
    movsd xmm13, [rsp + nb304_qqMH]
    addsd  xmm1, xmm0     ;# VV
    addsd  xmm5, xmm4
    addsd  xmm9, xmm8
    mulsd  xmm1, xmm12   ;# VV*qq = vcoul
    mulsd  xmm5, xmm12
    mulsd  xmm9, xmm13
    mulsd  xmm3, xmm12    ;# FF*qq = fij
    mulsd  xmm7, xmm12
    mulsd  xmm11, xmm13
    
    ;# accumulate vctot
    addsd  xmm1, [rsp + nb304_vctot]
    addsd  xmm5, xmm9
    addsd  xmm1, xmm5
    movsd [rsp + nb304_vctot], xmm1
    
    movsd xmm10, [rsp + nb304_tsc]
    mulsd  xmm3, xmm10  ;# fscal
    mulsd  xmm7, xmm10
    mulsd  xmm10, xmm11
    
    xorpd xmm4, xmm4
    xorpd xmm8, xmm8
    xorpd xmm11, xmm11
    
    subsd xmm4, xmm3
    subsd xmm8, xmm7
    subsd xmm11, xmm10

    mulsd xmm4, [rsp + nb304_rinvH1H2]
    mulsd xmm8, [rsp + nb304_rinvH2H2]
    mulsd xmm11, [rsp + nb304_rinvMH2]
    
    ;# move j H2 forces to xmm0-xmm2
    mov rdi, [rbp + nb304_faction]
	movsd xmm0, [rdi + rax*8 + 48]
	movsd xmm1, [rdi + rax*8 + 56]
	movsd xmm2, [rdi + rax*8 + 64]

    movapd xmm3, xmm4
    movapd xmm5, xmm4
    movapd xmm7, xmm8
    movapd xmm9, xmm8
    movapd xmm10, xmm11
    movapd xmm12, xmm11

	mulsd xmm3, [rsp + nb304_dxH1H2]
	mulsd xmm4, [rsp + nb304_dyH1H2]
	mulsd xmm5, [rsp + nb304_dzH1H2]
	mulsd xmm7, [rsp + nb304_dxH2H2]
	mulsd xmm8, [rsp + nb304_dyH2H2]
	mulsd xmm9, [rsp + nb304_dzH2H2]
	mulsd xmm10, [rsp + nb304_dxMH2]
	mulsd xmm11, [rsp + nb304_dyMH2]
	mulsd xmm12, [rsp + nb304_dzMH2]

    addsd xmm0, xmm3
    addsd xmm1, xmm4
    addsd xmm2, xmm5
    addsd xmm3, [rsp + nb304_fixH1]
    addsd xmm4, [rsp + nb304_fiyH1]
    addsd xmm5, [rsp + nb304_fizH1]

    addsd xmm0, xmm7
    addsd xmm1, xmm8
    addsd xmm2, xmm9
    addsd xmm7, [rsp + nb304_fixH2]
    addsd xmm8, [rsp + nb304_fiyH2]
    addsd xmm9, [rsp + nb304_fizH2]

    addsd xmm0, xmm10
    addsd xmm1, xmm11
    addsd xmm2, xmm12
    addsd xmm10, [rsp + nb304_fixM]
    addsd xmm11, [rsp + nb304_fiyM]
    addsd xmm12, [rsp + nb304_fizM]

    movsd [rsp + nb304_fixH1], xmm3
    movsd [rsp + nb304_fiyH1], xmm4
    movsd [rsp + nb304_fizH1], xmm5
    movsd [rsp + nb304_fixH2], xmm7
    movsd [rsp + nb304_fiyH2], xmm8
    movsd [rsp + nb304_fizH2], xmm9
    movsd [rsp + nb304_fixM], xmm10
    movsd [rsp + nb304_fiyM], xmm11
    movsd [rsp + nb304_fizM], xmm12
   
    ;# store back j H2 forces from xmm0-xmm2
	movsd [rdi + rax*8 + 48], xmm0
	movsd [rdi + rax*8 + 56], xmm1
	movsd [rdi + rax*8 + 64], xmm2
       
	;# move j M coordinates to local temp variables 
    mov rsi, [rbp + nb304_pos]
    movsd xmm0, [rsi + rax*8 + 72] 
    movsd xmm1, [rsi + rax*8 + 80] 
    movsd xmm2, [rsi + rax*8 + 88] 

    ;# xmm0 = Mx
    ;# xmm1 = My
    ;# xmm2 = Mz
        
    movsd xmm3, xmm0
    movsd xmm4, xmm1
    movsd xmm5, xmm2
    movsd xmm6, xmm0
    movsd xmm7, xmm1
    movsd xmm8, xmm2
    
    subsd xmm0, [rsp + nb304_ixH1]
    subsd xmm1, [rsp + nb304_iyH1]
    subsd xmm2, [rsp + nb304_izH1]
    subsd xmm3, [rsp + nb304_ixH2]
    subsd xmm4, [rsp + nb304_iyH2]
    subsd xmm5, [rsp + nb304_izH2]
    subsd xmm6, [rsp + nb304_ixM]
    subsd xmm7, [rsp + nb304_iyM]
    subsd xmm8, [rsp + nb304_izM]
    
	movsd [rsp + nb304_dxH1M], xmm0
	movsd [rsp + nb304_dyH1M], xmm1
	movsd [rsp + nb304_dzH1M], xmm2
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	movsd [rsp + nb304_dxH2M], xmm3
	movsd [rsp + nb304_dyH2M], xmm4
	movsd [rsp + nb304_dzH2M], xmm5
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	movsd [rsp + nb304_dxMM], xmm6
	movsd [rsp + nb304_dyMM], xmm7
	movsd [rsp + nb304_dzMM], xmm8
	mulsd  xmm6, xmm6
	mulsd  xmm7, xmm7
	mulsd  xmm8, xmm8
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm3, xmm4
	addsd  xmm3, xmm5
    addsd  xmm6, xmm7
    addsd  xmm6, xmm8

	;# start doing invsqrt for jM atoms
    cvtsd2ss xmm1, xmm0
    cvtsd2ss xmm4, xmm3
    cvtsd2ss xmm7, xmm6
	rsqrtss xmm1, xmm1
	rsqrtss xmm4, xmm4
    rsqrtss xmm7, xmm7
    cvtss2sd xmm1, xmm1
    cvtss2sd xmm4, xmm4
    cvtss2sd xmm7, xmm7
	
	movsd  xmm2, xmm1
	movsd  xmm5, xmm4
    movsd  xmm8, xmm7
    
	mulsd   xmm1, xmm1 ;# lu*lu
	mulsd   xmm4, xmm4 ;# lu*lu
    mulsd   xmm7, xmm7 ;# lu*lu
		
	movsd  xmm9, [rsp + nb304_three]
	movsd  xmm10, xmm9
    movsd  xmm11, xmm9

	mulsd   xmm1, xmm0 ;# rsq*lu*lu
	mulsd   xmm4, xmm3 ;# rsq*lu*lu 
    mulsd   xmm7, xmm6 ;# rsq*lu*lu
	
	subsd   xmm9, xmm1
	subsd   xmm10, xmm4
    subsd   xmm11, xmm7 ;# 3-rsq*lu*lu

	mulsd   xmm9, xmm2
	mulsd   xmm10, xmm5
    mulsd   xmm11, xmm8 ;# lu*(3-rsq*lu*lu)

	movsd  xmm15, [rsp + nb304_half]
	mulsd   xmm9, xmm15  ;# first iteration for rinvH1M 
	mulsd   xmm10, xmm15 ;# first iteration for rinvH2M
    mulsd   xmm11, xmm15 ;# first iteration for rinvMM

    ;# second iteration step    
	movsd  xmm2, xmm9
	movsd  xmm5, xmm10
    movsd  xmm8, xmm11
    
	mulsd   xmm2, xmm2 ;# lu*lu
	mulsd   xmm5, xmm5 ;# lu*lu
    mulsd   xmm8, xmm8 ;# lu*lu
		
	movsd  xmm1, [rsp + nb304_three]
	movsd  xmm4, xmm1
    movsd  xmm7, xmm1

	mulsd   xmm2, xmm0 ;# rsq*lu*lu
	mulsd   xmm5, xmm3 ;# rsq*lu*lu 
    mulsd   xmm8, xmm6 ;# rsq*lu*lu
	
	subsd   xmm1, xmm2
	subsd   xmm4, xmm5
    subsd   xmm7, xmm8 ;# 3-rsq*lu*lu

	mulsd   xmm9, xmm1
	mulsd   xmm10, xmm4
    mulsd   xmm11, xmm7 ;# lu*(3-rsq*lu*lu)

	movsd  xmm15, [rsp + nb304_half]
	mulsd   xmm9, xmm15  ;#  rinvH1M
	mulsd   xmm10, xmm15 ;#   rinvH2M
    mulsd   xmm11, xmm15 ;#   rinvMM
	
	movsd  [rsp + nb304_rinvH1M], xmm9
	movsd  [rsp + nb304_rinvH2M], xmm10
	movsd  [rsp + nb304_rinvMM], xmm11
	
	;# M interactions 
    ;# rsq in xmm0,xmm3,xmm6  
    ;# rinv in xmm9, xmm10, xmm11

    movsd  xmm1, [rsp + nb304_tsc]
    mulsd  xmm0, xmm9  ;# r
    mulsd  xmm3, xmm10
    mulsd  xmm6, xmm11
    mulsd  xmm0, xmm1 ;# rtab
    mulsd  xmm3, xmm1
    mulsd  xmm6, xmm1
    
    ;# truncate and convert to integers
    cvttsd2si r8d, xmm0
    cvttsd2si r10d, xmm3
    cvttsd2si r12d, xmm6        

    ;# convert back to float
    cvtsi2sd  xmm2, r8d
    cvtsi2sd  xmm5, r10d
    cvtsi2sd  xmm8, r12d
    
    ;# multiply by 4
    shl   r8, 2
    shl   r10d, 2
    shl   r12d, 2
    
    mov  rsi, [rbp + nb304_VFtab]

    ;# calculate eps
    subsd     xmm0, xmm2
    subsd     xmm3, xmm5
    subsd     xmm6, xmm8

    movsd    [rsp + nb304_epsH1], xmm0
    movsd    [rsp + nb304_epsH2], xmm3
    movsd    [rsp + nb304_epsM], xmm6

    ;# Load LOTS of table data
    movsd xmm0,  [rsi + r8*8]
    movsd xmm1,  [rsi + r8*8 + 8]
    movsd xmm2,  [rsi + r8*8 + 16]
    movsd xmm3,  [rsi + r8*8 + 24]
    movsd xmm4,  [rsi + r10*8]
    movsd xmm5,  [rsi + r10*8 + 8]
    movsd xmm6,  [rsi + r10*8 + 16]
    movsd xmm7,  [rsi + r10*8 + 24]
    movsd xmm8,  [rsi + r12*8]
    movsd xmm9,  [rsi + r12*8 + 8]
    movsd xmm10, [rsi + r12*8 + 16]
    movsd xmm11, [rsi + r12*8 + 24]
    ;# table data ready in xmm0-xmm3 , xmm4-xmm7 , and xmm8-xmm11
    
    movsd xmm12, [rsp + nb304_epsH1]
    movsd xmm13, [rsp + nb304_epsH2]
    movsd xmm14, [rsp + nb304_epsM]
    
    mulsd  xmm3, xmm12   ;# Heps
    mulsd  xmm7, xmm13
    mulsd  xmm11, xmm14 
    mulsd  xmm2, xmm12   ;# Geps
    mulsd  xmm6, xmm13
    mulsd  xmm10, xmm14 
    mulsd  xmm3, xmm12   ;# Heps2
    mulsd  xmm7, xmm13
    mulsd  xmm11, xmm14 

    addsd  xmm1, xmm2   ;# F+Geps
    addsd  xmm5, xmm6
    addsd  xmm9, xmm10 
    addsd  xmm1, xmm3   ;# F+Geps+Heps2 = Fp
    addsd  xmm5, xmm7
    addsd  xmm9, xmm11 
    addsd  xmm3, xmm3    ;# 2*Heps2
    addsd  xmm7, xmm7
    addsd  xmm11, xmm11
    addsd  xmm3, xmm2    ;# 2*Heps2+Geps
    addsd  xmm7, xmm6  
    addsd  xmm11, xmm10
    addsd  xmm3, xmm1   ;# FF = Fp + 2*Heps2 + Geps
    addsd  xmm7, xmm5
    addsd  xmm11, xmm9
    mulsd  xmm1, xmm12   ;# eps*Fp
    mulsd  xmm5, xmm13
    mulsd  xmm9, xmm14
    movsd xmm12, [rsp + nb304_qqMH]
    movsd xmm13, [rsp + nb304_qqMM]
    addsd  xmm1, xmm0     ;# VV
    addsd  xmm5, xmm4
    addsd  xmm9, xmm8
    mulsd  xmm1, xmm12   ;# VV*qq = vcoul
    mulsd  xmm5, xmm12
    mulsd  xmm9, xmm13
    mulsd  xmm3, xmm12    ;# FF*qq = fij
    mulsd  xmm7, xmm12
    mulsd  xmm11, xmm13
    
    ;# accumulate vctot
    addsd  xmm1, [rsp + nb304_vctot]
    addsd  xmm5, xmm9
    addsd  xmm1, xmm5
    movsd [rsp + nb304_vctot], xmm1
    
    movsd xmm10, [rsp + nb304_tsc]
    mulsd  xmm3, xmm10  ;# fscal
    mulsd  xmm7, xmm10
    mulsd  xmm10, xmm11
    
    xorpd xmm4, xmm4
    xorpd xmm8, xmm8
    xorpd xmm11, xmm11
    
    subsd xmm4, xmm3
    subsd xmm8, xmm7
    subsd xmm11, xmm10

    mulsd xmm4, [rsp + nb304_rinvH1M]
    mulsd xmm8, [rsp + nb304_rinvH2M]
    mulsd xmm11, [rsp + nb304_rinvMM]
    
    ;# move j M forces to xmm0-xmm2
    mov rdi, [rbp + nb304_faction]
	movsd xmm0, [rdi + rax*8 + 72]
	movsd xmm1, [rdi + rax*8 + 80]
	movsd xmm2, [rdi + rax*8 + 88]

    movapd xmm3, xmm4
    movapd xmm5, xmm4
    movapd xmm7, xmm8
    movapd xmm9, xmm8
    movapd xmm10, xmm11
    movapd xmm12, xmm11

	mulsd xmm3, [rsp + nb304_dxH1M]
	mulsd xmm4, [rsp + nb304_dyH1M]
	mulsd xmm5, [rsp + nb304_dzH1M]
	mulsd xmm7, [rsp + nb304_dxH2M]
	mulsd xmm8, [rsp + nb304_dyH2M]
	mulsd xmm9, [rsp + nb304_dzH2M]
	mulsd xmm10, [rsp + nb304_dxMM]
	mulsd xmm11, [rsp + nb304_dyMM]
	mulsd xmm12, [rsp + nb304_dzMM]

    addsd xmm0, xmm3
    addsd xmm1, xmm4
    addsd xmm2, xmm5
    addsd xmm3, [rsp + nb304_fixH1]
    addsd xmm4, [rsp + nb304_fiyH1]
    addsd xmm5, [rsp + nb304_fizH1]

    addsd xmm0, xmm7
    addsd xmm1, xmm8
    addsd xmm2, xmm9
    addsd xmm7, [rsp + nb304_fixH2]
    addsd xmm8, [rsp + nb304_fiyH2]
    addsd xmm9, [rsp + nb304_fizH2]

    addsd xmm0, xmm10
    addsd xmm1, xmm11
    addsd xmm2, xmm12
    addsd xmm10, [rsp + nb304_fixM]
    addsd xmm11, [rsp + nb304_fiyM]
    addsd xmm12, [rsp + nb304_fizM]

    movsd [rsp + nb304_fixH1], xmm3
    movsd [rsp + nb304_fiyH1], xmm4
    movsd [rsp + nb304_fizH1], xmm5
    movsd [rsp + nb304_fixH2], xmm7
    movsd [rsp + nb304_fiyH2], xmm8
    movsd [rsp + nb304_fizH2], xmm9
    movsd [rsp + nb304_fixM], xmm10
    movsd [rsp + nb304_fiyM], xmm11
    movsd [rsp + nb304_fizM], xmm12
   
    ;# store back j M forces from xmm0-xmm2
	movsd [rdi + rax*8 + 72], xmm0
	movsd [rdi + rax*8 + 80], xmm1
	movsd [rdi + rax*8 + 88], xmm2
	
.nb304_updateouterdata:
	mov   ecx, [rsp + nb304_ii3]
	mov   rdi, [rbp + nb304_faction]
	mov   rsi, [rbp + nb304_fshift]
	mov   edx, [rsp + nb304_is3]

	;# accumulate H1i forces in xmm0, xmm1, xmm2 
	movapd xmm0, [rsp + nb304_fixH1]
	movapd xmm1, [rsp + nb304_fiyH1]
	movapd xmm2, [rsp + nb304_fizH1]

	movhlps xmm3, xmm0
	movhlps xmm4, xmm1
	movhlps xmm5, xmm2
	addsd  xmm0, xmm3
	addsd  xmm1, xmm4
	addsd  xmm2, xmm5 ;# sum is in low xmm0-xmm2 

	;# increment i force 
	movsd  xmm3, [rdi + rcx*8 + 24]
	movsd  xmm4, [rdi + rcx*8 + 32]
	movsd  xmm5, [rdi + rcx*8 + 40]
	subsd  xmm3, xmm0
	subsd  xmm4, xmm1
	subsd  xmm5, xmm2
	movsd  [rdi + rcx*8 + 24],     xmm3
	movsd  [rdi + rcx*8 + 32], xmm4
	movsd  [rdi + rcx*8 + 40], xmm5

	;# accumulate force in xmm6/xmm7 for fshift 
	movapd xmm6, xmm0
	movsd xmm7, xmm2
	unpcklpd xmm6, xmm1

	;# accumulate H2i forces in xmm0, xmm1, xmm2 
	movapd xmm0, [rsp + nb304_fixH2]
	movapd xmm1, [rsp + nb304_fiyH2]
	movapd xmm2, [rsp + nb304_fizH2]

	movhlps xmm3, xmm0
	movhlps xmm4, xmm1
	movhlps xmm5, xmm2
	addsd  xmm0, xmm3
	addsd  xmm1, xmm4
	addsd  xmm2, xmm5 ;# sum is in low xmm0-xmm2 

	;# increment i force 
	movsd  xmm3, [rdi + rcx*8 + 48]
	movsd  xmm4, [rdi + rcx*8 + 56]
	movsd  xmm5, [rdi + rcx*8 + 64]
	subsd  xmm3, xmm0
	subsd  xmm4, xmm1
	subsd  xmm5, xmm2
	movsd  [rdi + rcx*8 + 48], xmm3
	movsd  [rdi + rcx*8 + 56], xmm4
	movsd  [rdi + rcx*8 + 64], xmm5

	;# accumulate force in xmm6/xmm7 for fshift 
	addsd xmm7, xmm2
	unpcklpd xmm0, xmm1
	addpd xmm6, xmm0

	;# accumulate H2i forces in xmm0, xmm1, xmm2 
	movapd xmm0, [rsp + nb304_fixM]
	movapd xmm1, [rsp + nb304_fiyM]
	movapd xmm2, [rsp + nb304_fizM]

	movhlps xmm3, xmm0
	movhlps xmm4, xmm1
	movhlps xmm5, xmm2
	addsd  xmm0, xmm3
	addsd  xmm1, xmm4
	addsd  xmm2, xmm5 ;# sum is in low xmm0-xmm2 

	movapd xmm3, xmm0	
	movapd xmm4, xmm1	
	movapd xmm5, xmm2	

	;# increment i force 
	movsd  xmm3, [rdi + rcx*8 + 72]
	movsd  xmm4, [rdi + rcx*8 + 80]
	movsd  xmm5, [rdi + rcx*8 + 88]
	subsd  xmm3, xmm0
	subsd  xmm4, xmm1
	subsd  xmm5, xmm2
	movsd  [rdi + rcx*8 + 72], xmm3
	movsd  [rdi + rcx*8 + 80], xmm4
	movsd  [rdi + rcx*8 + 88], xmm5

	;# accumulate force in xmm6/xmm7 for fshift 
	addsd xmm7, xmm2
	unpcklpd xmm0, xmm1
	addpd xmm6, xmm0

	;# increment fshift force 
	movlpd xmm3, [rsi + rdx*8]
	movhpd xmm3, [rsi + rdx*8 + 8]
	movsd  xmm4, [rsi + rdx*8 + 16]
	subpd  xmm3, xmm6
	subsd  xmm4, xmm7
	movlpd [rsi + rdx*8],      xmm3
	movhpd [rsi + rdx*8 + 8],  xmm3
	movsd  [rsi + rdx*8 + 16], xmm4

	;# get n from stack
	mov esi, [rsp + nb304_n]
        ;# get group index for i particle 
        mov   rdx, [rbp + nb304_gid]      	;# base of gid[]
        mov   edx, [rdx + rsi*4]		;# ggid=gid[n]

	;# accumulate total potential energy and update it 
	movapd xmm7, [rsp + nb304_vctot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 
        
	;# add earlier value from mem 
	mov   rax, [rbp + nb304_Vc]
	addsd xmm7, [rax + rdx*8] 
	;# move back to mem 
	movsd [rax + rdx*8], xmm7 
	
        ;# finish if last 
        mov ecx, [rsp + nb304_nn1]
	;# esi already loaded with n
	inc esi
        sub ecx, esi
        jz .nb304_outerend

        ;# not last, iterate outer loop once more!  
        mov [rsp + nb304_n], esi
        jmp .nb304_outer
.nb304_outerend:
        ;# check if more outer neighborlists remain
        mov   ecx, [rsp + nb304_nri]
	;# esi already loaded with n above
        sub   ecx, esi
        jz .nb304_end
        ;# non-zero, do one more workunit
        jmp   .nb304_threadloop
.nb304_end:
	mov eax, [rsp + nb304_nouter]
	mov ebx, [rsp + nb304_ninner]
	mov rcx, [rbp + nb304_outeriter]
	mov rdx, [rbp + nb304_inneriter]
	mov [rcx], eax
	mov [rdx], ebx

	add rsp, 1528
	emms


        pop r15
        pop r14
        pop r13
        pop r12

	pop rbx
	pop	rbp
	ret




.globl nb_kernel304nf_x86_64_sse2
.globl _nb_kernel304nf_x86_64_sse2
nb_kernel304nf_x86_64_sse2:	
_nb_kernel304nf_x86_64_sse2:	
;#	Room for return address and rbp (16 bytes)
.equiv          nb304nf_fshift,         16
.equiv          nb304nf_gid,            24
.equiv          nb304nf_pos,            32
.equiv          nb304nf_faction,        40
.equiv          nb304nf_charge,         48
.equiv          nb304nf_p_facel,        56
.equiv          nb304nf_argkrf,         64
.equiv          nb304nf_argcrf,         72
.equiv          nb304nf_Vc,             80
.equiv          nb304nf_type,           88
.equiv          nb304nf_p_ntype,        96
.equiv          nb304nf_vdwparam,       104
.equiv          nb304nf_Vvdw,           112
.equiv          nb304nf_p_tabscale,     120
.equiv          nb304nf_VFtab,          128
.equiv          nb304nf_invsqrta,       136
.equiv          nb304nf_dvda,           144
.equiv          nb304nf_p_gbtabscale,   152
.equiv          nb304nf_GBtab,          160
.equiv          nb304nf_p_nthreads,     168
.equiv          nb304nf_count,          176
.equiv          nb304nf_mtx,            184
.equiv          nb304nf_outeriter,      192
.equiv          nb304nf_inneriter,      200
.equiv          nb304nf_work,           208
	;# stack offsets for local variables  
	;# bottom of stack is cache-aligned for sse use 
.equiv          nb304nf_ixM,            0
.equiv          nb304nf_iyM,            16
.equiv          nb304nf_izM,            32
.equiv          nb304nf_ixH1,           48
.equiv          nb304nf_iyH1,           64
.equiv          nb304nf_izH1,           80
.equiv          nb304nf_ixH2,           96
.equiv          nb304nf_iyH2,           112
.equiv          nb304nf_izH2,           128
.equiv          nb304nf_jxM,            144
.equiv          nb304nf_jyM,            160
.equiv          nb304nf_jzM,            176
.equiv          nb304nf_jxH1,           192
.equiv          nb304nf_jyH1,           208
.equiv          nb304nf_jzH1,           224
.equiv          nb304nf_jxH2,           240
.equiv          nb304nf_jyH2,           256
.equiv          nb304nf_jzH2,           272
.equiv          nb304nf_qqMM,           288
.equiv          nb304nf_qqMH,           304
.equiv          nb304nf_qqHH,           320
.equiv          nb304nf_tsc,            336
.equiv          nb304nf_vctot,          352
.equiv          nb304nf_half,           368
.equiv          nb304nf_three,          384
.equiv          nb304nf_rsqMM,          400
.equiv          nb304nf_rsqMH1,         416
.equiv          nb304nf_rsqMH2,         432
.equiv          nb304nf_rsqH1M,         448
.equiv          nb304nf_rsqH1H1,        464
.equiv          nb304nf_rsqH1H2,        480
.equiv          nb304nf_rsqH2M,         496
.equiv          nb304nf_rsqH2H1,        512
.equiv          nb304nf_rsqH2H2,        528
.equiv          nb304nf_rinvMM,         544
.equiv          nb304nf_rinvMH1,        560
.equiv          nb304nf_rinvMH2,        576
.equiv          nb304nf_rinvH1M,        592
.equiv          nb304nf_rinvH1H1,       608
.equiv          nb304nf_rinvH1H2,       624
.equiv          nb304nf_rinvH2M,        640
.equiv          nb304nf_rinvH2H1,       656
.equiv          nb304nf_rinvH2H2,       672
.equiv          nb304nf_is3,            688
.equiv          nb304nf_ii3,            692
.equiv          nb304nf_nri,            696
.equiv          nb304nf_iinr,           704
.equiv          nb304nf_jindex,         712
.equiv          nb304nf_jjnr,           720
.equiv          nb304nf_shift,          728
.equiv          nb304nf_shiftvec,       736
.equiv          nb304nf_facel,          744
.equiv          nb304nf_innerjjnr,      752
.equiv          nb304nf_innerk,         760
.equiv          nb304nf_n,              764
.equiv          nb304nf_nn1,            768
.equiv          nb304nf_nouter,         772
.equiv          nb304nf_ninner,         776
	push rbp
	mov  rbp, rsp
	push rbx
	emms

        push r12
        push r13
        push r14
        push r15

	sub rsp, 792		;# local variable stack space (n*16+8)

	;# zero 32-bit iteration counters
	mov eax, 0
	mov [rsp + nb304nf_nouter], eax
	mov [rsp + nb304nf_ninner], eax

	mov edi, [rdi]
	mov [rsp + nb304nf_nri], edi
	mov [rsp + nb304nf_iinr], rsi
	mov [rsp + nb304nf_jindex], rdx
	mov [rsp + nb304nf_jjnr], rcx
	mov [rsp + nb304nf_shift], r8
	mov [rsp + nb304nf_shiftvec], r9
	mov rsi, [rbp + nb304nf_p_facel]
	movsd xmm0, [rsi]
	movsd [rsp + nb304nf_facel], xmm0

	mov rax, [rbp + nb304nf_p_tabscale]
	movsd xmm3, [rax]
	shufpd xmm3, xmm3, 0
	movapd [rsp + nb304nf_tsc], xmm3

	;# create constant floating-point factors on stack
	mov eax, 0x00000000     ;# lower half of double half IEEE (hex)
	mov ebx, 0x3fe00000
	mov [rsp + nb304nf_half], eax
	mov [rsp + nb304nf_half+4], ebx
	movsd xmm1, [rsp + nb304nf_half]
	shufpd xmm1, xmm1, 0    ;# splat to all elements
	movapd xmm3, xmm1
	addpd  xmm3, xmm3       ;# one
	movapd xmm2, xmm3
	addpd  xmm2, xmm2       ;# two
	addpd  xmm3, xmm2	;# three
	movapd [rsp + nb304nf_half], xmm1
	movapd [rsp + nb304nf_three], xmm3

	;# assume we have at least one i particle - start directly 
	mov   rcx, [rsp + nb304nf_iinr]       ;# rcx = pointer into iinr[] 	
	mov   ebx, [rcx]	    ;# ebx =ii 

	mov   rdx, [rbp + nb304nf_charge]
	movsd xmm3, [rdx + rbx*8 + 24]	
	movsd xmm4, xmm3
	movsd xmm5, [rdx + rbx*8 + 8]	
	mov rsi, [rbp + nb304nf_p_facel]
	movsd xmm0, [rsi]
	movsd xmm6, [rsp + nb304nf_facel]
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm5
	mulsd  xmm5, xmm5
	mulsd  xmm3, xmm6
	mulsd  xmm4, xmm6
	mulsd  xmm5, xmm6
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	movapd [rsp + nb304nf_qqMM], xmm3
	movapd [rsp + nb304nf_qqMH], xmm4
	movapd [rsp + nb304nf_qqHH], xmm5		

.nb304nf_threadloop:
        mov   rsi, [rbp + nb304nf_count]        ;# pointer to sync counter
        mov   eax, [rsi]
.nb304nf_spinlock:
        mov   ebx, eax                          ;# ebx=*count=nn0
        add   ebx, 1                           	;# ebx=nn1=nn0+10
        lock
        cmpxchg [esi], ebx                      ;# write nn1 to *counter,
                                                ;# if it hasnt changed.
                                                ;# or reread *counter to eax.
        pause                                   ;# -> better p4 performance
        jnz .nb304nf_spinlock

        ;# if(nn1>nri) nn1=nri
        mov ecx, [rsp + nb304nf_nri]
        mov edx, ecx
        sub ecx, ebx
        cmovle ebx, edx                         ;# if(nn1>nri) nn1=nri
        ;# Cleared the spinlock if we got here.
        ;# eax contains nn0, ebx contains nn1.
        mov [rsp + nb304nf_n], eax
        mov [rsp + nb304nf_nn1], ebx
        sub ebx, eax                            ;# calc number of outer lists
	mov esi, eax				;# copy n to esi
        jg  .nb304nf_outerstart
        jmp .nb304nf_end

.nb304nf_outerstart:
	;# ebx contains number of outer iterations
	add ebx, [rsp + nb304nf_nouter]
	mov [rsp + nb304nf_nouter], ebx

.nb304nf_outer:
	mov   rax, [rsp + nb304nf_shift]      ;# rax = pointer into shift[] 
	mov   ebx, [rax + rsi*4]		;# rbx=shift[n] 
	
	lea   rbx, [rbx + rbx*2]    ;# rbx=3*is 
	mov   [rsp + nb304nf_is3],ebx    	;# store is3 

	mov   rax, [rsp + nb304nf_shiftvec]   ;# rax = base of shiftvec[] 

	movsd xmm0, [rax + rbx*8]
	movsd xmm1, [rax + rbx*8 + 8]
	movsd xmm2, [rax + rbx*8 + 16] 

	mov   rcx, [rsp + nb304nf_iinr]       ;# rcx = pointer into iinr[] 	
	mov   ebx, [rcx + rsi*4]	    ;# ebx =ii 

	lea   rbx, [rbx + rbx*2]	;# rbx = 3*ii=ii3 
	mov   rax, [rbp + nb304nf_pos]    ;# rax = base of pos[]  
	mov   [rsp + nb304nf_ii3], ebx	
	
	movapd xmm3, xmm0
	movapd xmm4, xmm1
	movapd xmm5, xmm2
	addsd xmm3, [rax + rbx*8 + 24]
	addsd xmm4, [rax + rbx*8 + 32]
	addsd xmm5, [rax + rbx*8 + 40]		
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	movapd [rsp + nb304nf_ixH1], xmm3
	movapd [rsp + nb304nf_iyH1], xmm4
	movapd [rsp + nb304nf_izH1], xmm5

	movsd xmm3, xmm0
	movsd xmm4, xmm1
	movsd xmm5, xmm2
	addsd xmm0, [rax + rbx*8 + 48]
	addsd xmm1, [rax + rbx*8 + 56]
	addsd xmm2, [rax + rbx*8 + 64]		
	addsd xmm3, [rax + rbx*8 + 72]
	addsd xmm4, [rax + rbx*8 + 80]
	addsd xmm5, [rax + rbx*8 + 88]		

	shufpd xmm0, xmm0, 0
	shufpd xmm1, xmm1, 0
	shufpd xmm2, xmm2, 0
	shufpd xmm3, xmm3, 0
	shufpd xmm4, xmm4, 0
	shufpd xmm5, xmm5, 0
	movapd [rsp + nb304nf_ixH2], xmm0
	movapd [rsp + nb304nf_iyH2], xmm1
	movapd [rsp + nb304nf_izH2], xmm2
	movapd [rsp + nb304nf_ixM], xmm3
	movapd [rsp + nb304nf_iyM], xmm4
	movapd [rsp + nb304nf_izM], xmm5

	;# clear vctot 
	xorpd xmm4, xmm4
	movapd [rsp + nb304nf_vctot], xmm4
	
	mov   rax, [rsp + nb304nf_jindex]
	mov   ecx, [rax + rsi*4]	     ;# jindex[n] 
	mov   edx, [rax + rsi*4 + 4]	     ;# jindex[n+1] 
	sub   edx, ecx               ;# number of innerloop atoms 

	mov   rsi, [rbp + nb304nf_pos]
	mov   rax, [rsp + nb304nf_jjnr]
	shl   ecx, 2
	add   rax, rcx
	mov   [rsp + nb304nf_innerjjnr], rax     ;# pointer to jjnr[nj0] 
	mov   ecx, edx
	sub   edx,  2
	add   ecx, [rsp + nb304nf_ninner]
	mov   [rsp + nb304nf_ninner], ecx
	add   edx, 0
	mov   [rsp + nb304nf_innerk], edx    ;# number of innerloop atoms 
	jge   .nb304nf_unroll_loop
	jmp   .nb304nf_checksingle
.nb304nf_unroll_loop:	
	;# twice unrolled innerloop here 
	mov   rdx, [rsp + nb304nf_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [rdx]	
	mov   ebx, [rdx + 4] 
	
	add qword ptr [rsp + nb304nf_innerjjnr], 8 ;# advance pointer (unrolled 2) 

	mov rsi, [rbp + nb304nf_pos]       ;# base of pos[] 

	lea   rax, [rax + rax*2]     ;# replace jnr with j3 
	lea   rbx, [rbx + rbx*2]	
	
	;# move j coordinates to local temp variables 
	movlpd xmm2, [rsi + rax*8 + 24]
	movlpd xmm3, [rsi + rax*8 + 32]
	movlpd xmm4, [rsi + rax*8 + 40]
	movlpd xmm5, [rsi + rax*8 + 48]
	movlpd xmm6, [rsi + rax*8 + 56]
	movlpd xmm7, [rsi + rax*8 + 64]
	movhpd xmm2, [rsi + rbx*8 + 24]
	movhpd xmm3, [rsi + rbx*8 + 32]
	movhpd xmm4, [rsi + rbx*8 + 40]
	movhpd xmm5, [rsi + rbx*8 + 48]
	movhpd xmm6, [rsi + rbx*8 + 56]
	movhpd xmm7, [rsi + rbx*8 + 64]
	movapd 	[rsp + nb304nf_jxH1], xmm2
	movapd 	[rsp + nb304nf_jyH1], xmm3
	movapd 	[rsp + nb304nf_jzH1], xmm4
	movapd 	[rsp + nb304nf_jxH2], xmm5
	movapd 	[rsp + nb304nf_jyH2], xmm6
	movapd 	[rsp + nb304nf_jzH2], xmm7
	movlpd xmm2, [rsi + rax*8 + 72]
	movlpd xmm3, [rsi + rax*8 + 80]
	movlpd xmm4, [rsi + rax*8 + 88]
	movhpd xmm2, [rsi + rbx*8 + 72]
	movhpd xmm3, [rsi + rbx*8 + 80]
	movhpd xmm4, [rsi + rbx*8 + 88]
	movapd 	[rsp + nb304nf_jxM], xmm2
	movapd 	[rsp + nb304nf_jyM], xmm3
	movapd 	[rsp + nb304nf_jzM], xmm4
	
	movapd xmm0, [rsp + nb304nf_ixM]
	movapd xmm1, [rsp + nb304nf_iyM]
	movapd xmm2, [rsp + nb304nf_izM]
	movapd xmm3, [rsp + nb304nf_ixM]
	movapd xmm4, [rsp + nb304nf_iyM]
	movapd xmm5, [rsp + nb304nf_izM]
	subpd  xmm0, [rsp + nb304nf_jxM]
	subpd  xmm1, [rsp + nb304nf_jyM]
	subpd  xmm2, [rsp + nb304nf_jzM]
	subpd  xmm3, [rsp + nb304nf_jxH1]
	subpd  xmm4, [rsp + nb304nf_jyH1]
	subpd  xmm5, [rsp + nb304nf_jzH1]
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm3, xmm4
	addpd  xmm3, xmm5
	movapd [rsp + nb304nf_rsqMM], xmm0
	movapd [rsp + nb304nf_rsqMH1], xmm3

	movapd xmm0, [rsp + nb304nf_ixM]
	movapd xmm1, [rsp + nb304nf_iyM]
	movapd xmm2, [rsp + nb304nf_izM]
	movapd xmm3, [rsp + nb304nf_ixH1]
	movapd xmm4, [rsp + nb304nf_iyH1]
	movapd xmm5, [rsp + nb304nf_izH1]
	subpd  xmm0, [rsp + nb304nf_jxH2]
	subpd  xmm1, [rsp + nb304nf_jyH2]
	subpd  xmm2, [rsp + nb304nf_jzH2]
	subpd  xmm3, [rsp + nb304nf_jxM]
	subpd  xmm4, [rsp + nb304nf_jyM]
	subpd  xmm5, [rsp + nb304nf_jzM]
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm3, xmm4
	addpd  xmm3, xmm5
	movapd [rsp + nb304nf_rsqMH2], xmm0
	movapd [rsp + nb304nf_rsqH1M], xmm3

	movapd xmm0, [rsp + nb304nf_ixH1]
	movapd xmm1, [rsp + nb304nf_iyH1]
	movapd xmm2, [rsp + nb304nf_izH1]
	movapd xmm3, [rsp + nb304nf_ixH1]
	movapd xmm4, [rsp + nb304nf_iyH1]
	movapd xmm5, [rsp + nb304nf_izH1]
	subpd  xmm0, [rsp + nb304nf_jxH1]
	subpd  xmm1, [rsp + nb304nf_jyH1]
	subpd  xmm2, [rsp + nb304nf_jzH1]
	subpd  xmm3, [rsp + nb304nf_jxH2]
	subpd  xmm4, [rsp + nb304nf_jyH2]
	subpd  xmm5, [rsp + nb304nf_jzH2]
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm3, xmm4
	addpd  xmm3, xmm5
	movapd [rsp + nb304nf_rsqH1H1], xmm0
	movapd [rsp + nb304nf_rsqH1H2], xmm3

	movapd xmm0, [rsp + nb304nf_ixH2]
	movapd xmm1, [rsp + nb304nf_iyH2]
	movapd xmm2, [rsp + nb304nf_izH2]
	movapd xmm3, [rsp + nb304nf_ixH2]
	movapd xmm4, [rsp + nb304nf_iyH2]
	movapd xmm5, [rsp + nb304nf_izH2]
	subpd  xmm0, [rsp + nb304nf_jxM]
	subpd  xmm1, [rsp + nb304nf_jyM]
	subpd  xmm2, [rsp + nb304nf_jzM]
	subpd  xmm3, [rsp + nb304nf_jxH1]
	subpd  xmm4, [rsp + nb304nf_jyH1]
	subpd  xmm5, [rsp + nb304nf_jzH1]
	mulpd  xmm0, xmm0
	mulpd  xmm1, xmm1
	mulpd  xmm2, xmm2
	mulpd  xmm3, xmm3
	mulpd  xmm4, xmm4
	mulpd  xmm5, xmm5
	addpd  xmm0, xmm1
	addpd  xmm0, xmm2
	addpd  xmm4, xmm3
	addpd  xmm4, xmm5
	movapd [rsp + nb304nf_rsqH2M], xmm0
	movapd [rsp + nb304nf_rsqH2H1], xmm4

	movapd xmm0, [rsp + nb304nf_ixH2]
	movapd xmm1, [rsp + nb304nf_iyH2]
	movapd xmm2, [rsp + nb304nf_izH2]
	subpd  xmm0, [rsp + nb304nf_jxH2]
	subpd  xmm1, [rsp + nb304nf_jyH2]
	subpd  xmm2, [rsp + nb304nf_jzH2]
	mulpd xmm0, xmm0
	mulpd xmm1, xmm1
	mulpd xmm2, xmm2
	addpd xmm0, xmm1
	addpd xmm0, xmm2
	movapd [rsp + nb304nf_rsqH2H2], xmm0
	
	;# start doing invsqrt use rsq values in xmm0, xmm4 
	cvtpd2ps xmm1, xmm0	
	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb304nf_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb304nf_half] ;# iter1 
	mulpd   xmm7, [rsp + nb304nf_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb304nf_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb304nf_half] ;# rinv 
	mulpd   xmm5, [rsp + nb304nf_half] ;# rinv 
	movapd [rsp + nb304nf_rinvH2H2], xmm1
	movapd [rsp + nb304nf_rinvH2H1], xmm5

	movapd xmm0, [rsp + nb304nf_rsqMM]
	movapd xmm4, [rsp + nb304nf_rsqMH1]	
	cvtpd2ps xmm1, xmm0	
	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb304nf_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb304nf_half] ;# iter1 of  
	mulpd   xmm7, [rsp + nb304nf_half] ;# iter1 of  

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb304nf_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb304nf_half] ;# rinv 
	mulpd   xmm5, [rsp + nb304nf_half] ;# rinv
	movapd [rsp + nb304nf_rinvMM], xmm1
	movapd [rsp + nb304nf_rinvMH1], xmm5

	movapd xmm0, [rsp + nb304nf_rsqMH2]
	movapd xmm4, [rsp + nb304nf_rsqH1M]	
	cvtpd2ps xmm1, xmm0	
	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb304nf_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb304nf_half] ;# iter1 
	mulpd   xmm7, [rsp + nb304nf_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb304nf_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb304nf_half] ;# rinv 
	mulpd   xmm5, [rsp + nb304nf_half] ;# rinv 
	movapd [rsp + nb304nf_rinvMH2], xmm1
	movapd [rsp + nb304nf_rinvH1M], xmm5

	movapd xmm0, [rsp + nb304nf_rsqH1H1]
	movapd xmm4, [rsp + nb304nf_rsqH1H2]	
	cvtpd2ps xmm1, xmm0	
	cvtpd2ps xmm5, xmm4	
	rsqrtps xmm1, xmm1
	rsqrtps xmm5, xmm5
	cvtps2pd xmm1, xmm1
	cvtps2pd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulpd   xmm1, xmm1	;# luA*luA 
	mulpd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb304nf_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	mulpd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subpd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm3, [rsp + nb304nf_half] ;# iter1a 
	mulpd   xmm7, [rsp + nb304nf_half] ;# iter1b 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulpd   xmm3, xmm3	;# luA*luA 
	mulpd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb304nf_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	mulpd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subpd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulpd   xmm1, [rsp + nb304nf_half] ;# rinv 
	mulpd   xmm5, [rsp + nb304nf_half] ;# rinv 
	movapd [rsp + nb304nf_rinvH1H1], xmm1
	movapd [rsp + nb304nf_rinvH1H2], xmm5

	movapd xmm0, [rsp + nb304nf_rsqH2M]
	cvtpd2ps xmm1, xmm0	
	rsqrtps xmm1, xmm1
	cvtps2pd xmm1, xmm1
	
	movapd  xmm2, xmm1	;# copy of luA 
	mulpd   xmm1, xmm1	;# luA*luA 
	movapd  xmm3, [rsp + nb304nf_three]
	mulpd   xmm1, xmm0	;# rsqA*luA*luA 
	subpd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	mulpd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm3, [rsp + nb304nf_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	mulpd   xmm3, xmm3	;# luA*luA 
	movapd  xmm1, [rsp + nb304nf_three]
	mulpd   xmm3, xmm0	;# rsqA*luA*luA 
	subpd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	mulpd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulpd   xmm1, [rsp + nb304nf_half] ;# rinv 
	movapd [rsp + nb304nf_rinvH2M], xmm1
	
	;# start with MM interaction 
	movapd xmm0, [rsp + nb304nf_rinvMM]
	movapd xmm1, xmm0
	mulpd  xmm1, [rsp + nb304nf_rsqMM] ;# xmm1=r 
	mulpd  xmm1, [rsp + nb304nf_tsc]

	cvttpd2pi mm6, xmm1	;# mm6 = lu idx 
	cvtpi2pd xmm6, mm6
	subpd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 
	
	pslld mm6, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6		;# indices in eax/ebx 

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	movapd xmm3, [rsi + rbx*8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	movapd xmm3, [rsi + rbx*8 + 16]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# coulomb table ready, in xmm4-xmm7  		
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqMM]
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	mulpd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul
    ;# increment vcoul - then we can get rid of mm5 
    ;# update vctot 
    addpd  xmm5, [rsp + nb304nf_vctot]
    movapd [rsp + nb304nf_vctot], xmm5

	;# M-H1 interaction 
	movapd xmm0, [rsp + nb304nf_rinvMH1]
	movapd xmm1, xmm0
	mulpd  xmm1, [rsp + nb304nf_rsqMH1] ;# xmm1=r 
	mulpd  xmm1, [rsp + nb304nf_tsc]

	cvttpd2pi mm6, xmm1	;# mm6 = lu idx 
	cvtpi2pd xmm6, mm6
	subpd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 
	
	pslld mm6, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6		;# indices in eax/ebx 

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	movapd xmm3, [rsi + rbx*8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	movapd xmm3, [rsi + rbx*8 + 16]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# coulomb table ready, in xmm4-xmm7  		
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqMH]
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	mulpd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addpd  xmm5, [rsp + nb304nf_vctot]
    movapd [rsp + nb304nf_vctot], xmm5

	;# M-H2 interaction  
	movapd xmm0, [rsp + nb304nf_rinvMH2]
	movapd xmm1, xmm0
	mulpd  xmm1, [rsp + nb304nf_rsqMH2] ;# xmm1=r 
	mulpd  xmm1, [rsp + nb304nf_tsc]
	
	cvttpd2pi mm6, xmm1	;# mm6 = lu idx 
	cvtpi2pd xmm6, mm6
	subpd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 
	
	pslld mm6, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6		;# indices in eax/ebx 

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	movapd xmm3, [rsi + rbx*8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	movapd xmm3, [rsi + rbx*8 + 16]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# coulomb table ready, in xmm4-xmm7  		
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqMH]
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	mulpd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addpd  xmm5, [rsp + nb304nf_vctot]
    movapd [rsp + nb304nf_vctot], xmm5

	;# H1-M interaction 
	movapd xmm0, [rsp + nb304nf_rinvH1M]
	movapd xmm1, xmm0
	mulpd  xmm1, [rsp + nb304nf_rsqH1M] ;# xmm1=r 
	mulpd  xmm1, [rsp + nb304nf_tsc]
	
	cvttpd2pi mm6, xmm1	;# mm6 = lu idx 
	cvtpi2pd xmm6, mm6
	subpd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 
	
	pslld mm6, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6		;# indices in eax/ebx 

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	movapd xmm3, [rsi + rbx*8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	movapd xmm3, [rsi + rbx*8 + 16]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# coulomb table ready, in xmm4-xmm7  		
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqMH]
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	mulpd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addpd  xmm5, [rsp + nb304nf_vctot]
    movapd [rsp + nb304nf_vctot], xmm5

	;# H1-H1 interaction 
	movapd xmm0, [rsp + nb304nf_rinvH1H1]
	movapd xmm1, xmm0
	mulpd  xmm1, [rsp + nb304nf_rsqH1H1] ;# xmm1=r 
	mulpd  xmm1, [rsp + nb304nf_tsc]	
	cvttpd2pi mm6, xmm1	;# mm6 = lu idx 
	cvtpi2pd xmm6, mm6
	subpd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 
	
	pslld mm6, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6		;# indices in eax/ebx 

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	movapd xmm3, [rsi + rbx*8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	movapd xmm3, [rsi + rbx*8 + 16]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# coulomb table ready, in xmm4-xmm7  		
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqHH]
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	mulpd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addpd  xmm5, [rsp + nb304nf_vctot]
    movapd [rsp + nb304nf_vctot], xmm5
	
	;# H1-H2 interaction 
	movapd xmm0, [rsp + nb304nf_rinvH1H2]
	movapd xmm1, xmm0
	mulpd  xmm1, [rsp + nb304nf_rsqH1H2] ;# xmm1=r 
	mulpd  xmm1, [rsp + nb304nf_tsc]
	cvttpd2pi mm6, xmm1	;# mm6 = lu idx 
	cvtpi2pd xmm6, mm6
	subpd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 
	
	pslld mm6, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6		;# indices in eax/ebx 

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	movapd xmm3, [rsi + rbx*8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	movapd xmm3, [rsi + rbx*8 + 16]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# coulomb table ready, in xmm4-xmm7  		
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqHH]
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	mulpd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addpd  xmm5, [rsp + nb304nf_vctot]
    movapd [rsp + nb304nf_vctot], xmm5

	;# H2-M interaction 
	movapd xmm0, [rsp + nb304nf_rinvH2M]
	movapd xmm1, xmm0
	mulpd  xmm1, [rsp + nb304nf_rsqH2M] ;# xmm1=r 
	mulpd  xmm1, [rsp + nb304nf_tsc]	
	cvttpd2pi mm6, xmm1	;# mm6 = lu idx 
	cvtpi2pd xmm6, mm6
	subpd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 
	
	pslld mm6, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6		;# indices in eax/ebx 

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	movapd xmm3, [rsi + rbx*8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	movapd xmm3, [rsi + rbx*8 + 16]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# coulomb table ready, in xmm4-xmm7  		
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqMH]
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	mulpd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addpd  xmm5, [rsp + nb304nf_vctot]
    movapd [rsp + nb304nf_vctot], xmm5

	;# H2-H1 interaction 
	movapd xmm0, [rsp + nb304nf_rinvH2H1]
	movapd xmm1, xmm0
	mulpd  xmm1, [rsp + nb304nf_rsqH2H1] ;# xmm1=r 
	mulpd  xmm1, [rsp + nb304nf_tsc]
	cvttpd2pi mm6, xmm1	;# mm6 = lu idx 
	cvtpi2pd xmm6, mm6
	subpd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 
	
	pslld mm6, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6		;# indices in eax/ebx 

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	movapd xmm3, [rsi + rbx*8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	movapd xmm3, [rsi + rbx*8 + 16]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# coulomb table ready, in xmm4-xmm7  		
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqHH]
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	mulpd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addpd  xmm5, [rsp + nb304nf_vctot]
    movapd [rsp + nb304nf_vctot], xmm5	

	;# H2-H2 interaction 
	movapd xmm0, [rsp + nb304nf_rinvH2H2]
	movapd xmm1, xmm0
	mulpd  xmm1, [rsp + nb304nf_rsqH2H2] ;# xmm1=r 
	mulpd  xmm1, [rsp + nb304nf_tsc]	
	cvttpd2pi mm6, xmm1	;# mm6 = lu idx 
	cvtpi2pd xmm6, mm6
	subpd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 
	
	pslld mm6, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]
	movd eax, mm6
	psrlq mm6, 32
	movd ebx, mm6		;# indices in eax/ebx 

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	movapd xmm3, [rsi + rbx*8]	;# Y2 F2 
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 Y2 
	unpckhpd xmm5, xmm3	;# F1 F2 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	movapd xmm3, [rsi + rbx*8 + 16]	;# G2 H2 
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 G2 
	unpckhpd xmm7, xmm3	;# H1 H2 
	;# coulomb table ready, in xmm4-xmm7  		
	mulpd  xmm6, xmm1	;# xmm6=Geps 
	mulpd  xmm7, xmm2	;# xmm7=Heps2 
	addpd  xmm5, xmm6
	addpd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqHH]
	mulpd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addpd  xmm5, xmm4 ;# xmm5=VV 
	mulpd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 
	
    addpd  xmm5, [rsp + nb304nf_vctot]
    movapd [rsp + nb304nf_vctot], xmm5
	
	;# should we do one more iteration? 
	sub dword ptr [rsp + nb304nf_innerk],  2
	jl    .nb304nf_checksingle
	jmp   .nb304nf_unroll_loop
.nb304nf_checksingle:
	mov   edx, [rsp + nb304nf_innerk]
	and   edx, 1
	jnz   .nb304nf_dosingle
	jmp   .nb304nf_updateouterdata
.nb304nf_dosingle:
	mov   rdx, [rsp + nb304nf_innerjjnr]     ;# pointer to jjnr[k] 
	mov   eax, [rdx]

	mov rsi, [rbp + nb304nf_pos]
	lea   rax, [rax + rax*2]  

	;# move j coordinates to local temp variables 
	movlpd xmm2, [rsi + rax*8 + 24]
	movlpd xmm3, [rsi + rax*8 + 32]
	movlpd xmm4, [rsi + rax*8 + 40]
	movlpd xmm5, [rsi + rax*8 + 48]
	movlpd xmm6, [rsi + rax*8 + 56]
	movlpd xmm7, [rsi + rax*8 + 64]
	movapd 	[rsp + nb304nf_jxH1], xmm2
	movapd 	[rsp + nb304nf_jyH1], xmm3
	movapd 	[rsp + nb304nf_jzH1], xmm4
	movapd 	[rsp + nb304nf_jxH2], xmm5
	movapd 	[rsp + nb304nf_jyH2], xmm6
	movapd 	[rsp + nb304nf_jzH2], xmm7
	movlpd xmm2, [rsi + rax*8 + 72]
	movlpd xmm3, [rsi + rax*8 + 80]
	movlpd xmm4, [rsi + rax*8 + 88]
	movapd 	[rsp + nb304nf_jxM], xmm2
	movapd 	[rsp + nb304nf_jyM], xmm3
	movapd 	[rsp + nb304nf_jzM], xmm4
	
	movapd xmm0, [rsp + nb304nf_ixM]
	movapd xmm1, [rsp + nb304nf_iyM]
	movapd xmm2, [rsp + nb304nf_izM]
	movapd xmm3, [rsp + nb304nf_ixM]
	movapd xmm4, [rsp + nb304nf_iyM]
	movapd xmm5, [rsp + nb304nf_izM]
	subsd  xmm0, [rsp + nb304nf_jxM]
	subsd  xmm1, [rsp + nb304nf_jyM]
	subsd  xmm2, [rsp + nb304nf_jzM]
	subsd  xmm3, [rsp + nb304nf_jxH1]
	subsd  xmm4, [rsp + nb304nf_jyH1]
	subsd  xmm5, [rsp + nb304nf_jzH1]
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm3, xmm4
	addsd  xmm3, xmm5
	movapd [rsp + nb304nf_rsqMM], xmm0
	movapd [rsp + nb304nf_rsqMH1], xmm3

	movapd xmm0, [rsp + nb304nf_ixM]
	movapd xmm1, [rsp + nb304nf_iyM]
	movapd xmm2, [rsp + nb304nf_izM]
	movapd xmm3, [rsp + nb304nf_ixH1]
	movapd xmm4, [rsp + nb304nf_iyH1]
	movapd xmm5, [rsp + nb304nf_izH1]
	subsd  xmm0, [rsp + nb304nf_jxH2]
	subsd  xmm1, [rsp + nb304nf_jyH2]
	subsd  xmm2, [rsp + nb304nf_jzH2]
	subsd  xmm3, [rsp + nb304nf_jxM]
	subsd  xmm4, [rsp + nb304nf_jyM]
	subsd  xmm5, [rsp + nb304nf_jzM]
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm3, xmm4
	addsd  xmm3, xmm5
	movapd [rsp + nb304nf_rsqMH2], xmm0
	movapd [rsp + nb304nf_rsqH1M], xmm3

	movapd xmm0, [rsp + nb304nf_ixH1]
	movapd xmm1, [rsp + nb304nf_iyH1]
	movapd xmm2, [rsp + nb304nf_izH1]
	movapd xmm3, [rsp + nb304nf_ixH1]
	movapd xmm4, [rsp + nb304nf_iyH1]
	movapd xmm5, [rsp + nb304nf_izH1]
	subsd  xmm0, [rsp + nb304nf_jxH1]
	subsd  xmm1, [rsp + nb304nf_jyH1]
	subsd  xmm2, [rsp + nb304nf_jzH1]
	subsd  xmm3, [rsp + nb304nf_jxH2]
	subsd  xmm4, [rsp + nb304nf_jyH2]
	subsd  xmm5, [rsp + nb304nf_jzH2]
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm3, xmm4
	addsd  xmm3, xmm5
	movapd [rsp + nb304nf_rsqH1H1], xmm0
	movapd [rsp + nb304nf_rsqH1H2], xmm3

	movapd xmm0, [rsp + nb304nf_ixH2]
	movapd xmm1, [rsp + nb304nf_iyH2]
	movapd xmm2, [rsp + nb304nf_izH2]
	movapd xmm3, [rsp + nb304nf_ixH2]
	movapd xmm4, [rsp + nb304nf_iyH2]
	movapd xmm5, [rsp + nb304nf_izH2]
	subsd  xmm0, [rsp + nb304nf_jxM]
	subsd  xmm1, [rsp + nb304nf_jyM]
	subsd  xmm2, [rsp + nb304nf_jzM]
	subsd  xmm3, [rsp + nb304nf_jxH1]
	subsd  xmm4, [rsp + nb304nf_jyH1]
	subsd  xmm5, [rsp + nb304nf_jzH1]
	mulsd  xmm0, xmm0
	mulsd  xmm1, xmm1
	mulsd  xmm2, xmm2
	mulsd  xmm3, xmm3
	mulsd  xmm4, xmm4
	mulsd  xmm5, xmm5
	addsd  xmm0, xmm1
	addsd  xmm0, xmm2
	addsd  xmm4, xmm3
	addsd  xmm4, xmm5
	movapd [rsp + nb304nf_rsqH2M], xmm0
	movapd [rsp + nb304nf_rsqH2H1], xmm4

	movapd xmm0, [rsp + nb304nf_ixH2]
	movapd xmm1, [rsp + nb304nf_iyH2]
	movapd xmm2, [rsp + nb304nf_izH2]
	subsd  xmm0, [rsp + nb304nf_jxH2]
	subsd  xmm1, [rsp + nb304nf_jyH2]
	subsd  xmm2, [rsp + nb304nf_jzH2]
	mulsd xmm0, xmm0
	mulsd xmm1, xmm1
	mulsd xmm2, xmm2
	addsd xmm0, xmm1
	addsd xmm0, xmm2
	movapd [rsp + nb304nf_rsqH2H2], xmm0
	
	;# start doing invsqrt use rsq values in xmm0, xmm4 
	cvtsd2ss xmm1, xmm0	
	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb304nf_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb304nf_half] ;# iter1 
	mulsd   xmm7, [rsp + nb304nf_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb304nf_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb304nf_half] ;# rinv 
	mulsd   xmm5, [rsp + nb304nf_half] ;# rinv 
	movapd [rsp + nb304nf_rinvH2H2], xmm1
	movapd [rsp + nb304nf_rinvH2H1], xmm5

	movapd xmm0, [rsp + nb304nf_rsqMM]
	movapd xmm4, [rsp + nb304nf_rsqMH1]	
	cvtsd2ss xmm1, xmm0	
	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb304nf_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb304nf_half] ;# iter1 of  
	mulsd   xmm7, [rsp + nb304nf_half] ;# iter1 of  

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb304nf_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb304nf_half] ;# rinv 
	mulsd   xmm5, [rsp + nb304nf_half] ;# rinv
	movapd [rsp + nb304nf_rinvMM], xmm1
	movapd [rsp + nb304nf_rinvMH1], xmm5

	movapd xmm0, [rsp + nb304nf_rsqMH2]
	movapd xmm4, [rsp + nb304nf_rsqH1M]	
	cvtsd2ss xmm1, xmm0	
	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb304nf_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb304nf_half] ;# iter1 
	mulsd   xmm7, [rsp + nb304nf_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb304nf_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb304nf_half] ;# rinv 
	mulsd   xmm5, [rsp + nb304nf_half] ;# rinv 
	movapd [rsp + nb304nf_rinvMH2], xmm1
	movapd [rsp + nb304nf_rinvH1M], xmm5

	movapd xmm0, [rsp + nb304nf_rsqH1H1]
	movapd xmm4, [rsp + nb304nf_rsqH1H2]	
	cvtsd2ss xmm1, xmm0	
	cvtsd2ss xmm5, xmm4	
	rsqrtss xmm1, xmm1
	rsqrtss xmm5, xmm5
	cvtss2sd xmm1, xmm1
	cvtss2sd xmm5, xmm5
	
	movapd  xmm2, xmm1	;# copy of luA 
	movapd  xmm6, xmm5	;# copy of luB 
	mulsd   xmm1, xmm1	;# luA*luA 
	mulsd   xmm5, xmm5	;# luB*luB 
	movapd  xmm3, [rsp + nb304nf_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	mulsd   xmm5, xmm4	;# rsqB*luB*luB 	
	movapd  xmm7, xmm3
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	subsd   xmm7, xmm5	;# 3-rsqB*luB*luB 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm7, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm3, [rsp + nb304nf_half] ;# iter1a 
	mulsd   xmm7, [rsp + nb304nf_half] ;# iter1b 

	movapd  xmm2, xmm3	;# copy of luA 
	movapd  xmm6, xmm7	;# copy of luB 
	mulsd   xmm3, xmm3	;# luA*luA 
	mulsd   xmm7, xmm7	;# luB*luB 
	movapd  xmm1, [rsp + nb304nf_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	mulsd   xmm7, xmm4	;# rsqB*luB*luB 	
	movapd  xmm5, xmm1
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	subsd   xmm5, xmm7	;# 3-rsqB*luB*luB 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm5, xmm6	;# luB*(3-rsqB*luB*luB) 
	mulsd   xmm1, [rsp + nb304nf_half] ;# rinv 
	mulsd   xmm5, [rsp + nb304nf_half] ;# rinv 
	movapd [rsp + nb304nf_rinvH1H1], xmm1
	movapd [rsp + nb304nf_rinvH1H2], xmm5

	movapd xmm0, [rsp + nb304nf_rsqH2M]
	cvtsd2ss xmm1, xmm0	
	rsqrtss xmm1, xmm1
	cvtss2sd xmm1, xmm1
	
	movapd  xmm2, xmm1	;# copy of luA 
	mulsd   xmm1, xmm1	;# luA*luA 
	movapd  xmm3, [rsp + nb304nf_three]
	mulsd   xmm1, xmm0	;# rsqA*luA*luA 
	subsd   xmm3, xmm1	;# 3-rsqA*luA*luA 
	mulsd   xmm3, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm3, [rsp + nb304nf_half] ;# iter1 

	movapd  xmm2, xmm3	;# copy of luA 
	mulsd   xmm3, xmm3	;# luA*luA 
	movapd  xmm1, [rsp + nb304nf_three]
	mulsd   xmm3, xmm0	;# rsqA*luA*luA 
	subsd   xmm1, xmm3	;# 3-rsqA*luA*luA 
	mulsd   xmm1, xmm2	;# luA*(3-rsqA*luA*luA) 
	mulsd   xmm1, [rsp + nb304nf_half] ;# rinv 
	movapd [rsp + nb304nf_rinvH2M], xmm1
	
	;# start with MM interaction 
	movapd xmm0, [rsp + nb304nf_rinvMM]
	movapd xmm1, xmm0
	mulsd  xmm1, [rsp + nb304nf_rsqMM] ;# xmm1=r 
	mulsd  xmm1, [rsp + nb304nf_tsc]

	cvttsd2si eax, xmm1	;# mm6 = lu idx 
	cvtsi2sd xmm6, eax
	subsd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulsd  xmm2, xmm2	;# xmm2=eps2 
	
	shl eax, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	xorpd xmm3, xmm3
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 
	unpckhpd xmm5, xmm3	;# F1  

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	xorpd xmm3, xmm3
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1  
	unpckhpd xmm7, xmm3	;# H1  
	;# coulomb table ready, in xmm4-xmm7  		
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqMM]
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	mulsd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 
    ;# increment vcoul - then we can get rid of mm5 
    ;# update vctot 
    addsd  xmm5, [rsp + nb304nf_vctot]
    movlpd [rsp + nb304nf_vctot], xmm5

	;# M-H1 interaction 
	movapd xmm0, [rsp + nb304nf_rinvMH1]
	movapd xmm1, xmm0
	mulsd  xmm1, [rsp + nb304nf_rsqMH1] ;# xmm1=r 
	mulsd  xmm1, [rsp + nb304nf_tsc]

	cvttsd2si eax, xmm1	;# mm6 = lu idx 
	cvtsi2sd xmm6, eax
	subsd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulsd  xmm2, xmm2	;# xmm2=eps2 
	
	shl eax, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	xorpd xmm3, xmm3
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1  
	unpckhpd xmm5, xmm3	;# F1  

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	xorpd xmm3, xmm3
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 
	unpckhpd xmm7, xmm3	;# H1 
	;# coulomb table ready, in xmm4-xmm7  		
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqMH]
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	mulsd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul  

    addsd  xmm5, [rsp + nb304nf_vctot]
    movlpd [rsp + nb304nf_vctot], xmm5

	;# M-H2 interaction  
	movapd xmm0, [rsp + nb304nf_rinvMH2]
	movapd xmm1, xmm0
	mulsd  xmm1, [rsp + nb304nf_rsqMH2] ;# xmm1=r 
	mulsd  xmm1, [rsp + nb304nf_tsc]
	
	cvttsd2si eax, xmm1	;# mm6 = lu idx 
	cvtsi2sd xmm6, eax
	subsd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulsd  xmm2, xmm2	;# xmm2=eps2 
	
	shl eax, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	xorpd xmm3, xmm3
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 
	unpckhpd xmm5, xmm3	;# F1 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	xorpd xmm3, xmm3
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 
	unpckhpd xmm7, xmm3	;# H1 
	;# coulomb table ready, in xmm4-xmm7  		
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqMH]
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	mulsd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addsd  xmm5, [rsp + nb304nf_vctot]
    movlpd [rsp + nb304nf_vctot], xmm5

	;# H1-M interaction 
	movapd xmm0, [rsp + nb304nf_rinvH1M]
	movapd xmm1, xmm0
	mulsd  xmm1, [rsp + nb304nf_rsqH1M] ;# xmm1=r 
	mulsd  xmm1, [rsp + nb304nf_tsc]
	
	cvttsd2si eax, xmm1	;# mm6 = lu idx 
	cvtsi2sd xmm6, eax
	subsd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulsd  xmm2, xmm2	;# xmm2=eps2 
	
	shl eax, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	xorpd xmm3, xmm3
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 
	unpckhpd xmm5, xmm3	;# F1 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	xorpd xmm3, xmm3
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 
	unpckhpd xmm7, xmm3	;# H1 
	;# coulomb table ready, in xmm4-xmm7  		
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqMH]
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	mulsd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addsd  xmm5, [rsp + nb304nf_vctot]
    movlpd [rsp + nb304nf_vctot], xmm5

	;# H1-H1 interaction 
	movapd xmm0, [rsp + nb304nf_rinvH1H1]
	movapd xmm1, xmm0
	mulsd  xmm1, [rsp + nb304nf_rsqH1H1] ;# xmm1=r 
	mulsd  xmm1, [rsp + nb304nf_tsc]	
	cvttsd2si eax, xmm1	;# mm6 = lu idx 
	cvtsi2sd xmm6, eax
	subsd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulsd  xmm2, xmm2	;# xmm2=eps2 
	
	shl eax, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	xorpd xmm3, xmm3
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 
	unpckhpd xmm5, xmm3	;# F1 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	xorpd xmm3, xmm3
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 
	unpckhpd xmm7, xmm3	;# H1 
	;# coulomb table ready, in xmm4-xmm7  		
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqHH]
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	mulsd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addsd  xmm5, [rsp + nb304nf_vctot]
    movlpd [rsp + nb304nf_vctot], xmm5

	;# H1-H2 interaction 
	movapd xmm0, [rsp + nb304nf_rinvH1H2]
	movapd xmm1, xmm0
	mulsd  xmm1, [rsp + nb304nf_rsqH1H2] ;# xmm1=r 
	mulsd  xmm1, [rsp + nb304nf_tsc]
	cvttsd2si eax, xmm1	;# mm6 = lu idx 
	cvtsi2sd xmm6, eax
	subsd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulsd  xmm2, xmm2	;# xmm2=eps2 
	
	shl eax, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	xorpd xmm3, xmm3
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 
	unpckhpd xmm5, xmm3	;# F1 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	xorpd xmm3, xmm3
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 
	unpckhpd xmm7, xmm3	;# H1 
	;# coulomb table ready, in xmm4-xmm7  		
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqHH]
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	mulsd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addsd  xmm5, [rsp + nb304nf_vctot]
    movlpd [rsp + nb304nf_vctot], xmm5

	;# H2-M interaction 
	movapd xmm0, [rsp + nb304nf_rinvH2M]
	movapd xmm1, xmm0
	mulsd  xmm1, [rsp + nb304nf_rsqH2M] ;# xmm1=r 
	mulsd  xmm1, [rsp + nb304nf_tsc]	
	cvttsd2si eax, xmm1	;# mm6 = lu idx 
	cvtsi2sd xmm6, eax
	subsd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulsd  xmm2, xmm2	;# xmm2=eps2 
	
	shl eax, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	xorpd xmm3, xmm3
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 
	unpckhpd xmm5, xmm3	;# F1 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	xorpd xmm3, xmm3
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 
	unpckhpd xmm7, xmm3	;# H1 
	;# coulomb table ready, in xmm4-xmm7  		
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqMH]
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	mulsd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addsd  xmm5, [rsp + nb304nf_vctot]
    movlpd [rsp + nb304nf_vctot], xmm5

	;# H2-H1 interaction 
	movapd xmm0, [rsp + nb304nf_rinvH2H1]
	movapd xmm1, xmm0
	mulsd  xmm1, [rsp + nb304nf_rsqH2H1] ;# xmm1=r 
	mulsd  xmm1, [rsp + nb304nf_tsc]
	cvttsd2si eax, xmm1	;# mm6 = lu idx 
	cvtsi2sd xmm6, eax
	subpd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulpd  xmm2, xmm2	;# xmm2=eps2 
	
	shl eax, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	xorpd xmm3, xmm3
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 
	unpckhpd xmm5, xmm3	;# F1 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	xorpd xmm3, xmm3
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 
	unpckhpd xmm7, xmm3	;# H1 
	;# coulomb table ready, in xmm4-xmm7  		
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqHH]
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	mulsd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addsd  xmm5, [rsp + nb304nf_vctot]
    movlpd [rsp + nb304nf_vctot], xmm5

	;# H2-H2 interaction 
	movapd xmm0, [rsp + nb304nf_rinvH2H2]
	movapd xmm1, xmm0
	mulsd  xmm1, [rsp + nb304nf_rsqH2H2] ;# xmm1=r 
	mulsd  xmm1, [rsp + nb304nf_tsc]	
	cvttsd2si eax, xmm1	;# mm6 = lu idx 
	cvtsi2sd xmm6, eax
	subsd xmm1, xmm6	;# xmm1=eps 
	movapd xmm2, xmm1	
	mulsd  xmm2, xmm2	;# xmm2=eps2 
	
	shl eax, 2		;# idx *= 4 
	mov  rsi, [rbp + nb304nf_VFtab]

	movapd xmm4, [rsi + rax*8]	;# Y1 F1 	
	xorpd xmm3, xmm3
	movapd xmm5, xmm4
	unpcklpd xmm4, xmm3	;# Y1 
	unpckhpd xmm5, xmm3	;# F1 

	movapd xmm6, [rsi + rax*8 + 16]	;# G1 H1 	
	xorpd xmm3, xmm3
	movapd xmm7, xmm6
	unpcklpd xmm6, xmm3	;# G1 
	unpckhpd xmm7, xmm3	;# H1 
	;# coulomb table ready, in xmm4-xmm7  		
	mulsd  xmm6, xmm1	;# xmm6=Geps 
	mulsd  xmm7, xmm2	;# xmm7=Heps2 
	addsd  xmm5, xmm6
	addsd  xmm5, xmm7	;# xmm5=Fp 	
	movapd xmm3, [rsp + nb304nf_qqHH]
	mulsd  xmm5, xmm1 ;# xmm5=eps*Fp 
	addsd  xmm5, xmm4 ;# xmm5=VV 
	mulsd  xmm5, xmm3 ;# vcoul=qq*VV  
    ;# at this point mm5 contains vcoul 

    addsd  xmm5, [rsp + nb304nf_vctot]
    movlpd [rsp + nb304nf_vctot], xmm5
	
.nb304nf_updateouterdata:
	;# get group index for i particle 
	;# get n from stack
	mov esi, [rsp + nb304nf_n]
        ;# get group index for i particle 
        mov   rdx, [rbp + nb304nf_gid]      	;# base of gid[]
        mov   edx, [rdx + rsi*4]		;# ggid=gid[n]

	;# accumulate total potential energy and update it 
	movapd xmm7, [rsp + nb304nf_vctot]
	;# accumulate 
	movhlps xmm6, xmm7
	addsd  xmm7, xmm6	;# low xmm7 has the sum now 
        
	;# add earlier value from mem 
	mov   rax, [rbp + nb304nf_Vc]
	addsd xmm7, [rax + rdx*8] 
	;# move back to mem 
	movsd [rax + rdx*8], xmm7 
	
        ;# finish if last 
        mov ecx, [rsp + nb304nf_nn1]
	;# esi already loaded with n
	inc esi
        sub ecx, esi
        jz .nb304nf_outerend

        ;# not last, iterate outer loop once more!  
        mov [rsp + nb304nf_n], esi
        jmp .nb304nf_outer
.nb304nf_outerend:
        ;# check if more outer neighborlists remain
        mov   ecx, [rsp + nb304nf_nri]
	;# esi already loaded with n above
        sub   ecx, esi
        jz .nb304nf_end
        ;# non-zero, do one more workunit
        jmp   .nb304nf_threadloop
.nb304nf_end:
	mov eax, [rsp + nb304nf_nouter]
	mov ebx, [rsp + nb304nf_ninner]
	mov rcx, [rbp + nb304nf_outeriter]
	mov rdx, [rbp + nb304nf_inneriter]
	mov [rcx], eax
	mov [rdx], ebx

	add rsp, 792
	emms


        pop r15
        pop r14
        pop r13
        pop r12

	pop rbx
	pop	rbp
	ret
