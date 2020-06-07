/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * LSM_initialize.cpp
 *
 * Code generation for function 'LSM_initialize'
 *
 */

/* Include files */
#include "LSM_initialize.h"
#include "LSM.h"
#include "LSM_data.h"
#include "eml_rand_mt19937ar_stateful.h"

/* Function Definitions */
void LSM_initialize()
{
  c_eml_rand_mt19937ar_stateful_i();
  isInitialized_LSM = true;
}

/* End of code generation (LSM_initialize.cpp) */
