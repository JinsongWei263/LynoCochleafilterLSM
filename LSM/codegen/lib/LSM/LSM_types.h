/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * LSM_types.h
 *
 * Code generation for function 'LSM_types'
 *
 */

#ifndef LSM_TYPES_H
#define LSM_TYPES_H

/* Include files */
#include "rtwtypes.h"

/* Type Definitions */
struct struct0_T
{
  double n;
  double r;
  double tm;
  double tc;
  double tf;
  double dt;
  double kz;
  double kx;
  double ky;
  double vth;
  double kee;
  double kei;
  double kie;
  double kii;
  double wee;
  double wei;
  double wie;
  double wii;
};

struct emxArray_real_T
{
  double *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
};

struct emxArray_boolean_T
{
  boolean_T *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
};

struct struct1_T
{
  double n;
  double r;
  double tm;
  double tc;
  double vth;
  double tf;
  double dt;
  emxArray_real_T *W;
  emxArray_real_T *p;
  emxArray_real_T *v;
  emxArray_real_T *t;
  double kx;
  double ky;
  double kz;
  double m;
  emxArray_boolean_T *e;
  emxArray_real_T *d;
  emxArray_real_T *C;
  emxArray_real_T *Win;
  emxArray_real_T *ckk;
};

struct emxArray_int8_T
{
  signed char *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
};

struct emxArray_int32_T
{
  int *data;
  int *size;
  int allocatedSize;
  int numDimensions;
  boolean_T canFreeData;
};

#endif

/* End of code generation (LSM_types.h) */
