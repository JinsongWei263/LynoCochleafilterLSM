/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * rand.h
 *
 * Code generation for function 'rand'
 *
 */

#ifndef RAND_H
#define RAND_H

/* Include files */
#include <cstddef>
#include <cstdlib>
#include "rtwtypes.h"
#include "LSM_types.h"

/* Function Declarations */
extern void b_rand(double varargin_2, emxArray_real_T *r);
extern double c_rand();
extern void genrand_uint32_vector(unsigned int mt[625], unsigned int u[2]);

#endif

/* End of code generation (rand.h) */
