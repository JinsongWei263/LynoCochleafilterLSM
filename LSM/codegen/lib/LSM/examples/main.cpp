/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * main.cpp
 *
 * Code generation for function 'main'
 *
 */

/*************************************************************************/
/* This automatically generated example C++ main file shows how to call  */
/* entry-point functions that MATLAB Coder generated. You must customize */
/* this file for your application. Do not modify this file directly.     */
/* Instead, make a copy of this file, modify it, and integrate it into   */
/* your development environment.                                         */
/*                                                                       */
/* This file initializes entry-point function arguments to a default     */
/* size and value before calling the entry-point functions. It does      */
/* not store or use any values returned from the entry-point functions.  */
/* If necessary, it does pre-allocate memory for returned values.        */
/* You can use this file as a starting point for a main function that    */
/* you can deploy in your application.                                   */
/*                                                                       */
/* After you copy the file, and before you deploy it, you must make the  */
/* following changes:                                                    */
/* * For variable-size function arguments, change the example sizes to   */
/* the sizes that your application requires.                             */
/* * Change the example values of function arguments to the values that  */
/* your application requires.                                            */
/* * If the entry-point functions return values, store these values or   */
/* otherwise use them as required by your application.                   */
/*                                                                       */
/*************************************************************************/

/* Include files */
#include "main.h"
#include "LSM.h"
#include "LSM_emxAPI.h"
#include "LSM_terminate.h"

/* Function Declarations */
static double argInit_real_T();
static void argInit_struct0_T(struct0_T *result);
static void main_LSM();

/* Function Definitions */
static double argInit_real_T()
{
  return 0.0;
}

static void argInit_struct0_T(struct0_T *result)
{
  double result_tmp_tmp_tmp_tmp;

  /* Set the value of each structure field.
     Change this value to the value that the application requires. */
  result_tmp_tmp_tmp_tmp = argInit_real_T();
  result->n = result_tmp_tmp_tmp_tmp;
  result->r = result_tmp_tmp_tmp_tmp;
  result->tm = result_tmp_tmp_tmp_tmp;
  result->tc = result_tmp_tmp_tmp_tmp;
  result->tf = result_tmp_tmp_tmp_tmp;
  result->dt = argInit_real_T();
  result->kz = argInit_real_T();
  result->kx = argInit_real_T();
  result->ky = argInit_real_T();
  result->vth = argInit_real_T();
  result->kee = argInit_real_T();
  result->kei = argInit_real_T();
  result->kie = argInit_real_T();
  result->kii = argInit_real_T();
  result->wee = argInit_real_T();
  result->wei = argInit_real_T();
  result->wie = argInit_real_T();
  result->wii = argInit_real_T();
}

static void main_LSM()
{
  struct1_T lsm;
  struct0_T r;
  emxInit_struct1_T(&lsm);

  /* Initialize function 'LSM' input arguments. */
  /* Initialize function input argument 'opt'. */
  /* Call the entry-point 'LSM'. */
  argInit_struct0_T(&r);
  LSM(&r, &lsm);
  emxDestroy_struct1_T(lsm);
}

int main(int, const char * const [])
{
  /* The initialize function is being called automatically from your entry-point function. So, a call to initialize is not included here. */
  /* Invoke the entry-point functions.
     You can call entry-point functions multiple times. */
  main_LSM();

  /* Terminate the application.
     You do not need to do this more than one time. */
  LSM_terminate();
  return 0;
}

/* End of code generation (main.cpp) */
