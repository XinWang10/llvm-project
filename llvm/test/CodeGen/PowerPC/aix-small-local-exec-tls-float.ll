; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 3
; RUN: llc  -verify-machineinstrs -mcpu=pwr7 -ppc-asm-full-reg-names \
; RUN:      -mtriple powerpc64-ibm-aix-xcoff -mattr=+aix-small-local-exec-tls < %s \
; RUN:      | FileCheck %s --check-prefix=SMALL-LOCAL-EXEC-SMALLCM64
; RUN: llc  -verify-machineinstrs -mcpu=pwr7 -ppc-asm-full-reg-names \
; RUN:      -mtriple powerpc64-ibm-aix-xcoff --code-model=large \
; RUN:      -mattr=+aix-small-local-exec-tls < %s | FileCheck %s \
; RUN:      --check-prefix=SMALL-LOCAL-EXEC-LARGECM64

@ThreadLocalVarInit = thread_local(localexec) global float 1.000000e+00, align 4
@VarInit = local_unnamed_addr global float 8.700000e+01, align 4
@IThreadLocalVarInit = internal thread_local(localexec) global float 1.000000e+00, align 4
declare nonnull ptr @llvm.threadlocal.address.p0(ptr nonnull) #1
@e = thread_local(localexec) global [87 x float] zeroinitializer, align 4

define nonnull ptr @AddrTest1() local_unnamed_addr #0 {
; SMALL-LOCAL-EXEC-SMALLCM64-LABEL: AddrTest1:
; SMALL-LOCAL-EXEC-SMALLCM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    la r3, e[TL]@le+16(r13)
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    blr
;
; SMALL-LOCAL-EXEC-LARGECM64-LABEL: AddrTest1:
; SMALL-LOCAL-EXEC-LARGECM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    la r3, e[TL]@le+16(r13)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    blr
entry:
  %0 = tail call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @e)
  %arrayidx = getelementptr inbounds [87 x float], ptr %0, i64 0, i64 4
  ret ptr %arrayidx
}

define void @storeITLInit(float noundef %x) {
; SMALL-LOCAL-EXEC-SMALLCM64-LABEL: storeITLInit:
; SMALL-LOCAL-EXEC-SMALLCM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    stfs f1, IThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    blr
;
; SMALL-LOCAL-EXEC-LARGECM64-LABEL: storeITLInit:
; SMALL-LOCAL-EXEC-LARGECM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    stfs f1, IThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    blr
entry:
  %0 = tail call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @IThreadLocalVarInit)
  store float %x, ptr %0, align 4
  ret void
}

define void @storeTLInit(float noundef %x) {
; SMALL-LOCAL-EXEC-SMALLCM64-LABEL: storeTLInit:
; SMALL-LOCAL-EXEC-SMALLCM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    stfs f1, ThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    blr
;
; SMALL-LOCAL-EXEC-LARGECM64-LABEL: storeTLInit:
; SMALL-LOCAL-EXEC-LARGECM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    stfs f1, ThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    blr
entry:
  %0 = tail call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @ThreadLocalVarInit)
  store float %x, ptr %0, align 4
  ret void
}

define float @loadITLInit() {
; SMALL-LOCAL-EXEC-SMALLCM64-LABEL: loadITLInit:
; SMALL-LOCAL-EXEC-SMALLCM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    lfs f1, IThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    blr
;
; SMALL-LOCAL-EXEC-LARGECM64-LABEL: loadITLInit:
; SMALL-LOCAL-EXEC-LARGECM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    lfs f1, IThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    blr
entry:
  %0 = tail call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @IThreadLocalVarInit)
  %1 = load float, ptr %0, align 4
  ret float %1
}

define float @loadITLInit2() {
; SMALL-LOCAL-EXEC-SMALLCM64-LABEL: loadITLInit2:
; SMALL-LOCAL-EXEC-SMALLCM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    ld r3, L..C0(r2) # @VarInit
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    lfs f0, IThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    lfs f1, 0(r3)
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    fadds f1, f0, f1
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    blr
;
; SMALL-LOCAL-EXEC-LARGECM64-LABEL: loadITLInit2:
; SMALL-LOCAL-EXEC-LARGECM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    addis r3, L..C0@u(r2)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    lfs f0, IThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    ld r3, L..C0@l(r3)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    lfs f1, 0(r3)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    fadds f1, f0, f1
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    blr
entry:
  %0 = tail call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @IThreadLocalVarInit)
  %1 = load float, ptr %0, align 4
  %2 = load float, ptr @VarInit, align 4
  %add = fadd float %1, %2
  ret float %add
}

define float @loadTLInit() {
; SMALL-LOCAL-EXEC-SMALLCM64-LABEL: loadTLInit:
; SMALL-LOCAL-EXEC-SMALLCM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    lfs f1, ThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    blr
;
; SMALL-LOCAL-EXEC-LARGECM64-LABEL: loadTLInit:
; SMALL-LOCAL-EXEC-LARGECM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    lfs f1, ThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    blr
entry:
  %0 = tail call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @ThreadLocalVarInit)
  %1 = load float, ptr %0, align 4
  ret float %1
}

define float @loadTLInit2() {
; SMALL-LOCAL-EXEC-SMALLCM64-LABEL: loadTLInit2:
; SMALL-LOCAL-EXEC-SMALLCM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    ld r3, L..C0(r2) # @VarInit
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    lfs f0, ThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    lfs f1, 0(r3)
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    fadds f1, f0, f1
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    blr
;
; SMALL-LOCAL-EXEC-LARGECM64-LABEL: loadTLInit2:
; SMALL-LOCAL-EXEC-LARGECM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    addis r3, L..C0@u(r2)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    lfs f0, ThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    ld r3, L..C0@l(r3)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    lfs f1, 0(r3)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    fadds f1, f0, f1
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    blr
entry:
  %0 = tail call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @ThreadLocalVarInit)
  %1 = load float, ptr %0, align 4
  %2 = load float, ptr @VarInit, align 4
  %add = fadd float %1, %2
  ret float %add
}

define void @loadStore1(float noundef %x) {
; SMALL-LOCAL-EXEC-SMALLCM64-LABEL: loadStore1:
; SMALL-LOCAL-EXEC-SMALLCM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    vspltisw v2, 1
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    lfs f1, IThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    xvcvsxwdp vs0, vs34
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    vspltisw v3, 8
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    fadds f0, f1, f0
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    xvcvsxwdp vs1, vs35
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    fadds f0, f0, f1
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    stfs f0, IThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-SMALLCM64-NEXT:    blr
;
; SMALL-LOCAL-EXEC-LARGECM64-LABEL: loadStore1:
; SMALL-LOCAL-EXEC-LARGECM64:       # %bb.0: # %entry
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    vspltisw v2, 1
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    lfs f1, IThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    xvcvsxwdp vs0, vs34
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    vspltisw v3, 8
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    fadds f0, f1, f0
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    xvcvsxwdp vs1, vs35
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    fadds f0, f0, f1
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    stfs f0, IThreadLocalVarInit[TL]@le(r13)
; SMALL-LOCAL-EXEC-LARGECM64-NEXT:    blr
entry:
  %0 = tail call align 4 ptr @llvm.threadlocal.address.p0(ptr align 4 @IThreadLocalVarInit)
  %1 = load float, ptr %0, align 4
  %inc = fadd float %1, 1.000000e+00
  %add = fadd float %inc, 8.000000e+00
  store float %add, ptr %0, align 4
  ret void
}
