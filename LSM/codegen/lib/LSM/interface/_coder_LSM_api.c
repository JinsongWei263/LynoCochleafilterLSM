/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * _coder_LSM_api.c
 *
 * Code generation for function '_coder_LSM_api'
 *
 */

/* Include files */
#include "_coder_LSM_api.h"
#include "_coder_LSM_mex.h"

/* Variable Definitions */
emlrtCTX emlrtRootTLSGlobal = NULL;
emlrtContext emlrtContextGlobal = { true,/* bFirstTime */
  false,                               /* bInitialized */
  131483U,                             /* fVersionInfo */
  NULL,                                /* fErrorFunction */
  "LSM",                               /* fFunctionName */
  NULL,                                /* fRTCallStack */
  false,                               /* bDebugMode */
  { 2045744189U, 2170104910U, 2743257031U, 4284093946U },/* fSigWrd */
  NULL                                 /* fSigMem */
};

/* Function Declarations */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct0_T *y);
static const mxArray *b_emlrt_marshallOut(const emxArray_real_T *u);
static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId);
static const mxArray *c_emlrt_marshallOut(const emxArray_real_T *u);
static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId);
static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *opt, const
  char_T *identifier, struct0_T *y);
static const mxArray *emlrt_marshallOut(const emlrtStack *sp, const struct1_T *u);
static void emxEnsureCapacity_boolean_T(emxArray_boolean_T *emxArray, int32_T
  oldNumel);
static void emxFreeStruct_struct1_T(struct1_T *pStruct);
static void emxFree_boolean_T(emxArray_boolean_T **pEmxArray);
static void emxFree_real_T(emxArray_real_T **pEmxArray);
static void emxInitStruct_struct1_T(const emlrtStack *sp, struct1_T *pStruct,
  boolean_T doPush);
static void emxInit_boolean_T(const emlrtStack *sp, emxArray_boolean_T
  **pEmxArray, int32_T numDimensions, boolean_T doPush);
static void emxInit_real_T(const emlrtStack *sp, emxArray_real_T **pEmxArray,
  int32_T numDimensions, boolean_T doPush);

/* Function Definitions */
static void b_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId, struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  static const char * fieldNames[18] = { "n", "r", "tm", "tc", "tf", "dt", "kz",
    "kx", "ky", "vth", "kee", "kei", "kie", "kii", "wee", "wei", "wie", "wii" };

  static const int32_T dims = 0;
  thisId.fParent = parentId;
  thisId.bParentIsCell = false;
  emlrtCheckStructR2012b(sp, parentId, u, 18, fieldNames, 0U, &dims);
  thisId.fIdentifier = "n";
  y->n = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 0, "n")),
    &thisId);
  thisId.fIdentifier = "r";
  y->r = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 1, "r")),
    &thisId);
  thisId.fIdentifier = "tm";
  y->tm = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 2,
    "tm")), &thisId);
  thisId.fIdentifier = "tc";
  y->tc = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 3,
    "tc")), &thisId);
  thisId.fIdentifier = "tf";
  y->tf = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 4,
    "tf")), &thisId);
  thisId.fIdentifier = "dt";
  y->dt = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 5,
    "dt")), &thisId);
  thisId.fIdentifier = "kz";
  y->kz = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 6,
    "kz")), &thisId);
  thisId.fIdentifier = "kx";
  y->kx = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 7,
    "kx")), &thisId);
  thisId.fIdentifier = "ky";
  y->ky = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 8,
    "ky")), &thisId);
  thisId.fIdentifier = "vth";
  y->vth = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 9,
    "vth")), &thisId);
  thisId.fIdentifier = "kee";
  y->kee = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 10,
    "kee")), &thisId);
  thisId.fIdentifier = "kei";
  y->kei = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 11,
    "kei")), &thisId);
  thisId.fIdentifier = "kie";
  y->kie = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 12,
    "kie")), &thisId);
  thisId.fIdentifier = "kii";
  y->kii = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 13,
    "kii")), &thisId);
  thisId.fIdentifier = "wee";
  y->wee = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 14,
    "wee")), &thisId);
  thisId.fIdentifier = "wei";
  y->wei = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 15,
    "wei")), &thisId);
  thisId.fIdentifier = "wie";
  y->wie = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 16,
    "wie")), &thisId);
  thisId.fIdentifier = "wii";
  y->wii = c_emlrt_marshallIn(sp, emlrtAlias(emlrtGetFieldR2017b(sp, u, 0, 17,
    "wii")), &thisId);
  emlrtDestroyArray(&u);
}

static const mxArray *b_emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  int32_T iv[2];
  const mxArray *m;
  real_T *pData;
  int32_T i;
  int32_T b_i;
  int32_T c_i;
  y = NULL;
  iv[0] = u->size[0];
  iv[1] = u->size[1];
  m = emlrtCreateNumericArray(2, &iv[0], mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m);
  i = 0;
  for (b_i = 0; b_i < u->size[1]; b_i++) {
    for (c_i = 0; c_i < u->size[0]; c_i++) {
      pData[i] = u->data[c_i + u->size[0] * b_i];
      i++;
    }
  }

  emlrtAssign(&y, m);
  return y;
}

static real_T c_emlrt_marshallIn(const emlrtStack *sp, const mxArray *u, const
  emlrtMsgIdentifier *parentId)
{
  real_T y;
  y = d_emlrt_marshallIn(sp, emlrtAlias(u), parentId);
  emlrtDestroyArray(&u);
  return y;
}

static const mxArray *c_emlrt_marshallOut(const emxArray_real_T *u)
{
  const mxArray *y;
  int32_T iv[2];
  const mxArray *m;
  real_T *pData;
  int32_T i;
  int32_T b_i;
  y = NULL;
  iv[0] = u->size[0];
  iv[1] = u->size[1];
  m = emlrtCreateNumericArray(2, &iv[0], mxDOUBLE_CLASS, mxREAL);
  pData = emlrtMxGetPr(m);
  i = 0;
  for (b_i = 0; b_i < u->size[1]; b_i++) {
    pData[i] = u->data[b_i];
    i++;
  }

  emlrtAssign(&y, m);
  return y;
}

static real_T d_emlrt_marshallIn(const emlrtStack *sp, const mxArray *src, const
  emlrtMsgIdentifier *msgId)
{
  real_T ret;
  static const int32_T dims = 0;
  emlrtCheckBuiltInR2012b(sp, msgId, src, "double", false, 0U, &dims);
  ret = *(real_T *)emlrtMxGetData(src);
  emlrtDestroyArray(&src);
  return ret;
}

static void emlrt_marshallIn(const emlrtStack *sp, const mxArray *opt, const
  char_T *identifier, struct0_T *y)
{
  emlrtMsgIdentifier thisId;
  thisId.fIdentifier = (const char *)identifier;
  thisId.fParent = NULL;
  thisId.bParentIsCell = false;
  b_emlrt_marshallIn(sp, emlrtAlias(opt), &thisId, y);
  emlrtDestroyArray(&opt);
}

static const mxArray *emlrt_marshallOut(const emlrtStack *sp, const struct1_T *u)
{
  const mxArray *y;
  emxArray_boolean_T *b_u;
  static const char * sv[20] = { "n", "r", "tm", "tc", "vth", "tf", "dt", "W",
    "p", "v", "t", "kx", "ky", "kz", "m", "e", "d", "C", "Win", "ckk" };

  const mxArray *b_y;
  const mxArray *m;
  int32_T i;
  int32_T loop_ub;
  int32_T iv[2];
  emlrtHeapReferenceStackEnterFcnR2012b(sp);
  emxInit_boolean_T(sp, &b_u, 2, true);
  y = NULL;
  emlrtAssign(&y, emlrtCreateStructMatrix(1, 1, 20, sv));
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->n);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "n", b_y, 0);
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->r);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "r", b_y, 1);
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->tm);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "tm", b_y, 2);
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->tc);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "tc", b_y, 3);
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->vth);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "vth", b_y, 4);
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->tf);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "tf", b_y, 5);
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->dt);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "dt", b_y, 6);
  emlrtSetFieldR2017b(y, 0, "W", b_emlrt_marshallOut(u->W), 7);
  emlrtSetFieldR2017b(y, 0, "p", b_emlrt_marshallOut(u->p), 8);
  emlrtSetFieldR2017b(y, 0, "v", c_emlrt_marshallOut(u->v), 9);
  emlrtSetFieldR2017b(y, 0, "t", c_emlrt_marshallOut(u->t), 10);
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->kx);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "kx", b_y, 11);
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->ky);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "ky", b_y, 12);
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->kz);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "kz", b_y, 13);
  b_y = NULL;
  m = emlrtCreateDoubleScalar(u->m);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "m", b_y, 14);
  i = b_u->size[0] * b_u->size[1];
  b_u->size[0] = 1;
  b_u->size[1] = u->e->size[1];
  emxEnsureCapacity_boolean_T(b_u, i);
  loop_ub = u->e->size[0] * u->e->size[1];
  for (i = 0; i < loop_ub; i++) {
    b_u->data[i] = u->e->data[i];
  }

  b_y = NULL;
  iv[0] = u->e->size[0];
  iv[1] = u->e->size[1];
  m = emlrtCreateLogicalArray(2, &iv[0]);
  emlrtInitLogicalArray(u->e->size[1], m, &b_u->data[0]);
  emlrtAssign(&b_y, m);
  emlrtSetFieldR2017b(y, 0, "e", b_y, 15);
  emlrtSetFieldR2017b(y, 0, "d", b_emlrt_marshallOut(u->d), 16);
  emlrtSetFieldR2017b(y, 0, "C", b_emlrt_marshallOut(u->C), 17);
  emlrtSetFieldR2017b(y, 0, "Win", b_emlrt_marshallOut(u->Win), 18);
  emlrtSetFieldR2017b(y, 0, "ckk", c_emlrt_marshallOut(u->ckk), 19);
  emxFree_boolean_T(&b_u);
  emlrtHeapReferenceStackLeaveFcnR2012b(sp);
  return y;
}

static void emxEnsureCapacity_boolean_T(emxArray_boolean_T *emxArray, int32_T
  oldNumel)
{
  int32_T newNumel;
  int32_T i;
  void *newData;
  if (oldNumel < 0) {
    oldNumel = 0;
  }

  newNumel = 1;
  for (i = 0; i < emxArray->numDimensions; i++) {
    newNumel *= emxArray->size[i];
  }

  if (newNumel > emxArray->allocatedSize) {
    i = emxArray->allocatedSize;
    if (i < 16) {
      i = 16;
    }

    while (i < newNumel) {
      if (i > 1073741823) {
        i = MAX_int32_T;
      } else {
        i *= 2;
      }
    }

    newData = emlrtCallocMex((uint32_T)i, sizeof(boolean_T));
    if (emxArray->data != NULL) {
      memcpy(newData, emxArray->data, sizeof(boolean_T) * oldNumel);
      if (emxArray->canFreeData) {
        emlrtFreeMex(emxArray->data);
      }
    }

    emxArray->data = (boolean_T *)newData;
    emxArray->allocatedSize = i;
    emxArray->canFreeData = true;
  }
}

static void emxFreeStruct_struct1_T(struct1_T *pStruct)
{
  emxFree_real_T(&pStruct->W);
  emxFree_real_T(&pStruct->p);
  emxFree_real_T(&pStruct->v);
  emxFree_real_T(&pStruct->t);
  emxFree_boolean_T(&pStruct->e);
  emxFree_real_T(&pStruct->d);
  emxFree_real_T(&pStruct->C);
  emxFree_real_T(&pStruct->Win);
  emxFree_real_T(&pStruct->ckk);
}

static void emxFree_boolean_T(emxArray_boolean_T **pEmxArray)
{
  if (*pEmxArray != (emxArray_boolean_T *)NULL) {
    if (((*pEmxArray)->data != (boolean_T *)NULL) && (*pEmxArray)->canFreeData)
    {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtFreeMex(*pEmxArray);
    *pEmxArray = (emxArray_boolean_T *)NULL;
  }
}

static void emxFree_real_T(emxArray_real_T **pEmxArray)
{
  if (*pEmxArray != (emxArray_real_T *)NULL) {
    if (((*pEmxArray)->data != (real_T *)NULL) && (*pEmxArray)->canFreeData) {
      emlrtFreeMex((*pEmxArray)->data);
    }

    emlrtFreeMex((*pEmxArray)->size);
    emlrtFreeMex(*pEmxArray);
    *pEmxArray = (emxArray_real_T *)NULL;
  }
}

static void emxInitStruct_struct1_T(const emlrtStack *sp, struct1_T *pStruct,
  boolean_T doPush)
{
  emxInit_real_T(sp, &pStruct->W, 2, doPush);
  emxInit_real_T(sp, &pStruct->p, 2, doPush);
  emxInit_real_T(sp, &pStruct->v, 2, doPush);
  emxInit_real_T(sp, &pStruct->t, 2, doPush);
  emxInit_boolean_T(sp, &pStruct->e, 2, doPush);
  emxInit_real_T(sp, &pStruct->d, 2, doPush);
  emxInit_real_T(sp, &pStruct->C, 2, doPush);
  emxInit_real_T(sp, &pStruct->Win, 2, doPush);
  emxInit_real_T(sp, &pStruct->ckk, 2, doPush);
}

static void emxInit_boolean_T(const emlrtStack *sp, emxArray_boolean_T
  **pEmxArray, int32_T numDimensions, boolean_T doPush)
{
  emxArray_boolean_T *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_boolean_T *)emlrtMallocMex(sizeof(emxArray_boolean_T));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(sp, (void *)pEmxArray, (void (*)(void *))
      emxFree_boolean_T);
  }

  emxArray = *pEmxArray;
  emxArray->data = (boolean_T *)NULL;
  emxArray->numDimensions = numDimensions;
  emxArray->size = (int32_T *)emlrtMallocMex(sizeof(int32_T) * numDimensions);
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (i = 0; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

static void emxInit_real_T(const emlrtStack *sp, emxArray_real_T **pEmxArray,
  int32_T numDimensions, boolean_T doPush)
{
  emxArray_real_T *emxArray;
  int32_T i;
  *pEmxArray = (emxArray_real_T *)emlrtMallocMex(sizeof(emxArray_real_T));
  if (doPush) {
    emlrtPushHeapReferenceStackR2012b(sp, (void *)pEmxArray, (void (*)(void *))
      emxFree_real_T);
  }

  emxArray = *pEmxArray;
  emxArray->data = (real_T *)NULL;
  emxArray->numDimensions = numDimensions;
  emxArray->size = (int32_T *)emlrtMallocMex(sizeof(int32_T) * numDimensions);
  emxArray->allocatedSize = 0;
  emxArray->canFreeData = true;
  for (i = 0; i < numDimensions; i++) {
    emxArray->size[i] = 0;
  }
}

void LSM_api(const mxArray * const prhs[1], int32_T nlhs, const mxArray *plhs[1])
{
  struct1_T lsm;
  struct0_T opt;
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  (void)nlhs;
  st.tls = emlrtRootTLSGlobal;
  emlrtHeapReferenceStackEnterFcnR2012b(&st);
  emxInitStruct_struct1_T(&st, &lsm, true);

  /* Marshall function inputs */
  emlrt_marshallIn(&st, emlrtAliasP(prhs[0]), "opt", &opt);

  /* Invoke the target function */
  LSM(&opt, &lsm);

  /* Marshall function outputs */
  plhs[0] = emlrt_marshallOut(&st, &lsm);
  emxFreeStruct_struct1_T(&lsm);
  emlrtHeapReferenceStackLeaveFcnR2012b(&st);
}

void LSM_atexit(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtEnterRtStackR2012b(&st);
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
  LSM_xil_terminate();
  LSM_xil_shutdown();
  emlrtExitTimeCleanup(&emlrtContextGlobal);
}

void LSM_initialize(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  mexFunctionCreateRootTLS();
  st.tls = emlrtRootTLSGlobal;
  emlrtClearAllocCountR2012b(&st, false, 0U, 0);
  emlrtEnterRtStackR2012b(&st);
  emlrtFirstTimeR2012b(emlrtRootTLSGlobal);
}

void LSM_terminate(void)
{
  emlrtStack st = { NULL,              /* site */
    NULL,                              /* tls */
    NULL                               /* prev */
  };

  st.tls = emlrtRootTLSGlobal;
  emlrtLeaveRtStackR2012b(&st);
  emlrtDestroyRootTLS(&emlrtRootTLSGlobal);
}

/* End of code generation (_coder_LSM_api.c) */
