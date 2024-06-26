; NOTE: Assertions have been autogenerated by utils/update_llc_test_checks.py UTC_ARGS: --version 4
; RUN: llc -mtriple=aarch64 -mattr=+sve < %s -o - | FileCheck --check-prefix=SVE %s
; RUN: llc -mtriple=aarch64 -mattr=+sve2 < %s -o - | FileCheck --check-prefix=SVE2 %s

define <vscale x 2 x i64> @bcax_nxv2i64_1(<vscale x 2 x i64> %0, <vscale x 2 x i64> %1, <vscale x 2 x i64> %2) {
; SVE-LABEL: bcax_nxv2i64_1:
; SVE:       // %bb.0:
; SVE-NEXT:    bic z1.d, z2.d, z1.d
; SVE-NEXT:    eor z0.d, z1.d, z0.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: bcax_nxv2i64_1:
; SVE2:       // %bb.0:
; SVE2-NEXT:    bcax z0.d, z0.d, z2.d, z1.d
; SVE2-NEXT:    ret
  %4 = xor <vscale x 2 x i64> %1, splat (i64 -1)
  %5 = and <vscale x 2 x i64> %4, %2
  %6 = xor <vscale x 2 x i64> %5, %0
  ret <vscale x 2 x i64> %6
}

define <vscale x 2 x i64> @bcax_nxv2i64_2(<vscale x 2 x i64> %0, <vscale x 2 x i64> %1, <vscale x 2 x i64> %2) {
; SVE-LABEL: bcax_nxv2i64_2:
; SVE:       // %bb.0:
; SVE-NEXT:    bic z0.d, z0.d, z1.d
; SVE-NEXT:    eor z0.d, z0.d, z2.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: bcax_nxv2i64_2:
; SVE2:       // %bb.0:
; SVE2-NEXT:    bcax z2.d, z2.d, z0.d, z1.d
; SVE2-NEXT:    mov z0.d, z2.d
; SVE2-NEXT:    ret
  %4 = xor <vscale x 2 x i64> %1, splat (i64 -1)
  %5 = and <vscale x 2 x i64> %4, %0
  %6 = xor <vscale x 2 x i64> %5, %2
  ret <vscale x 2 x i64> %6
}

define <vscale x 4 x i32> @bcax_nxv4i32_1(<vscale x 4 x i32> %0, <vscale x 4 x i32> %1, <vscale x 4 x i32> %2) {
; SVE-LABEL: bcax_nxv4i32_1:
; SVE:       // %bb.0:
; SVE-NEXT:    bic z1.d, z2.d, z1.d
; SVE-NEXT:    eor z0.d, z1.d, z0.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: bcax_nxv4i32_1:
; SVE2:       // %bb.0:
; SVE2-NEXT:    bcax z0.d, z0.d, z2.d, z1.d
; SVE2-NEXT:    ret
  %4 = xor <vscale x 4 x i32> %1, splat (i32 -1)
  %5 = and <vscale x 4 x i32> %4, %2
  %6 = xor <vscale x 4 x i32> %5, %0
  ret <vscale x 4 x i32> %6
}

define <vscale x 4 x i32> @bcax_nxv4i32_2(<vscale x 4 x i32> %0, <vscale x 4 x i32> %1, <vscale x 4 x i32> %2) {
; SVE-LABEL: bcax_nxv4i32_2:
; SVE:       // %bb.0:
; SVE-NEXT:    bic z0.d, z0.d, z1.d
; SVE-NEXT:    eor z0.d, z0.d, z2.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: bcax_nxv4i32_2:
; SVE2:       // %bb.0:
; SVE2-NEXT:    bcax z2.d, z2.d, z0.d, z1.d
; SVE2-NEXT:    mov z0.d, z2.d
; SVE2-NEXT:    ret
  %4 = xor <vscale x 4 x i32> %1, splat (i32 -1)
  %5 = and <vscale x 4 x i32> %4, %0
  %6 = xor <vscale x 4 x i32> %5, %2
  ret <vscale x 4 x i32> %6
}

define <vscale x 8 x i16> @bcax_nxv8i16_1(<vscale x 8 x i16> %0, <vscale x 8 x i16> %1, <vscale x 8 x i16> %2) {
; SVE-LABEL: bcax_nxv8i16_1:
; SVE:       // %bb.0:
; SVE-NEXT:    bic z1.d, z2.d, z1.d
; SVE-NEXT:    eor z0.d, z1.d, z0.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: bcax_nxv8i16_1:
; SVE2:       // %bb.0:
; SVE2-NEXT:    bcax z0.d, z0.d, z2.d, z1.d
; SVE2-NEXT:    ret
  %4 = xor <vscale x 8 x i16> %1, splat (i16 -1)
  %5 = and <vscale x 8 x i16> %4, %2
  %6 = xor <vscale x 8 x i16> %5, %0
  ret <vscale x 8 x i16> %6
}

define <vscale x 8 x i16> @bcax_nxv8i16_2(<vscale x 8 x i16> %0, <vscale x 8 x i16> %1, <vscale x 8 x i16> %2) {
; SVE-LABEL: bcax_nxv8i16_2:
; SVE:       // %bb.0:
; SVE-NEXT:    bic z0.d, z0.d, z1.d
; SVE-NEXT:    eor z0.d, z0.d, z2.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: bcax_nxv8i16_2:
; SVE2:       // %bb.0:
; SVE2-NEXT:    bcax z2.d, z2.d, z0.d, z1.d
; SVE2-NEXT:    mov z0.d, z2.d
; SVE2-NEXT:    ret
  %4 = xor <vscale x 8 x i16> %1, splat (i16 -1)
  %5 = and <vscale x 8 x i16> %4, %0
  %6 = xor <vscale x 8 x i16> %5, %2
  ret <vscale x 8 x i16> %6
}

define <vscale x 16 x i8> @bcax_nxv16i8_1(<vscale x 16 x i8> %0, <vscale x 16 x i8> %1, <vscale x 16 x i8> %2) {
; SVE-LABEL: bcax_nxv16i8_1:
; SVE:       // %bb.0:
; SVE-NEXT:    bic z1.d, z2.d, z1.d
; SVE-NEXT:    eor z0.d, z1.d, z0.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: bcax_nxv16i8_1:
; SVE2:       // %bb.0:
; SVE2-NEXT:    bcax z0.d, z0.d, z2.d, z1.d
; SVE2-NEXT:    ret
  %4 = xor <vscale x 16 x i8> %1, splat (i8 -1)
  %5 = and <vscale x 16 x i8> %4, %2
  %6 = xor <vscale x 16 x i8> %5, %0
  ret <vscale x 16 x i8> %6
}

define <vscale x 16 x i8> @bcax_nxv16i8_2(<vscale x 16 x i8> %0, <vscale x 16 x i8> %1, <vscale x 16 x i8> %2) {
; SVE-LABEL: bcax_nxv16i8_2:
; SVE:       // %bb.0:
; SVE-NEXT:    bic z0.d, z0.d, z1.d
; SVE-NEXT:    eor z0.d, z0.d, z2.d
; SVE-NEXT:    ret
;
; SVE2-LABEL: bcax_nxv16i8_2:
; SVE2:       // %bb.0:
; SVE2-NEXT:    bcax z2.d, z2.d, z0.d, z1.d
; SVE2-NEXT:    mov z0.d, z2.d
; SVE2-NEXT:    ret
  %4 = xor <vscale x 16 x i8> %1, splat (i8 -1)
  %5 = and <vscale x 16 x i8> %4, %0
  %6 = xor <vscale x 16 x i8> %5, %2
  ret <vscale x 16 x i8> %6
}
