/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_LSM_mex.h
 *
 * Code generation for function '_coder_LSM_mex'
 *
 */

#ifndef _CODER_LSM_MEX_H
#define _CODER_LSM_MEX_H

/* Include files */
#include <math.h>
#include <stdlib.h>
#include <string.h>
#include "tmwtypes.h"
#include "mex.h"
#include "emlrt.h"
#include "_coder_LSM_api.h"

/* Function Declarations */
MEXFUNCTION_LINKAGE void mexFunction(int32_T nlhs, mxArray *plhs[], int32_T nrhs,
  const mxArray *prhs[]);
extern emlrtCTX mexFunctionCreateRootTLS(void);

#endif

/* End of code generation (_coder_LSM_mex.h) */
