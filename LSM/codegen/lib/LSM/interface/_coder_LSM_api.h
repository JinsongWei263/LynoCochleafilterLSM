/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_LSM_api.h
 *
 * Code generation for function '_coder_LSM_api'
 *
 */

#ifndef _CODER_LSM_API_H
#define _CODER_LSM_API_H

/* Include files */
#include <stddef.h>
#include <stdlib.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"

/* Type Definitions */
#ifndef struct_emxArray_boolean_T
#define struct_emxArray_boolean_T

struct emxArray_boolean_T
{
  boolean_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_boolean_T*/

#ifndef typedef_emxArray_boolean_T
#define typedef_emxArray_boolean_T

typedef struct emxArray_boolean_T emxArray_boolean_T;

#endif                                 /*typedef_emxArray_boolean_T*/

#ifndef struct_emxArray_real_T
#define struct_emxArray_real_T

struct emxArray_real_T
{
  real_T *data;
  int32_T *size;
  int32_T allocatedSize;
  int32_T numDimensions;
  boolean_T canFreeData;
};

#endif                                 /*struct_emxArray_real_T*/

#ifndef typedef_emxArray_real_T
#define typedef_emxArray_real_T

typedef struct emxArray_real_T emxArray_real_T;

#endif                                 /*typedef_emxArray_real_T*/

#ifndef typedef_struct0_T
#define typedef_struct0_T

typedef struct {
  real_T n;
  real_T r;
  real_T tm;
  real_T tc;
  real_T tf;
  real_T dt;
  real_T kz;
  real_T kx;
  real_T ky;
  real_T vth;
  real_T kee;
  real_T kei;
  real_T kie;
  real_T kii;
  real_T wee;
  real_T wei;
  real_T wie;
  real_T wii;
} struct0_T;

#endif                                 /*typedef_struct0_T*/

#ifndef typedef_struct1_T
#define typedef_struct1_T

typedef struct {
  real_T n;
  real_T r;
  real_T tm;
  real_T tc;
  real_T vth;
  real_T tf;
  real_T dt;
  emxArray_real_T *W;
  emxArray_real_T *p;
  emxArray_real_T *v;
  emxArray_real_T *t;
  real_T kx;
  real_T ky;
  real_T kz;
  real_T m;
  emxArray_boolean_T *e;
  emxArray_real_T *d;
  emxArray_real_T *C;
  emxArray_real_T *Win;
  emxArray_real_T *ckk;
} struct1_T;

#endif                                 /*typedef_struct1_T*/

/* Variable Declarations */
extern emlrtCTX emlrtRootTLSGlobal;
extern emlrtContext emlrtContextGlobal;

/* Function Declarations */
extern void LSM(struct0_T *opt, struct1_T *lsm);
extern void LSM_api(const mxArray * const prhs[1], int32_T nlhs, const mxArray
                    *plhs[1]);
extern void LSM_atexit(void);
extern void LSM_initialize(void);
extern void LSM_terminate(void);
extern void LSM_xil_shutdown(void);
extern void LSM_xil_terminate(void);

#endif

/* End of code generation (_coder_LSM_api.h) */
