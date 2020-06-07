/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * LSM_emxAPI.h
 *
 * Code generation for function 'LSM_emxAPI'
 *
 */

#ifndef LSM_EMXAPI_H
#define LSM_EMXAPI_H

/* Include files */
#include <cstddef>
#include <cstdlib>
#include "rtwtypes.h"
#include "LSM_types.h"

/* Function Declarations */
extern emxArray_boolean_T *emxCreateND_boolean_T(int numDimensions, const int
  *size);
extern emxArray_real_T *emxCreateND_real_T(int numDimensions, const int *size);
extern emxArray_boolean_T *emxCreateWrapperND_boolean_T(boolean_T *data, int
  numDimensions, const int *size);
extern emxArray_real_T *emxCreateWrapperND_real_T(double *data, int
  numDimensions, const int *size);
extern emxArray_boolean_T *emxCreateWrapper_boolean_T(boolean_T *data, int rows,
  int cols);
extern emxArray_real_T *emxCreateWrapper_real_T(double *data, int rows, int cols);
extern emxArray_boolean_T *emxCreate_boolean_T(int rows, int cols);
extern emxArray_real_T *emxCreate_real_T(int rows, int cols);
extern void emxDestroyArray_boolean_T(emxArray_boolean_T *emxArray);
extern void emxDestroyArray_real_T(emxArray_real_T *emxArray);
extern void emxDestroy_struct1_T(struct1_T emxArray);
extern void emxInit_struct1_T(struct1_T *pStruct);

#endif

/* End of code generation (LSM_emxAPI.h) */
