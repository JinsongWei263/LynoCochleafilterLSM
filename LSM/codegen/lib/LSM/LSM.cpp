/*
 * Academic License - for use in teaching, academic research, and meeting
 * course requirements at degree granting institutions only.  Not for
 * government, commercial, or other organizational use.
 *
 * LSM.cpp
 *
 * Code generation for function 'LSM'
 *
 */

/* Include files */
#include "LSM.h"
#include "LSM_data.h"
#include "LSM_emxutil.h"
#include "LSM_initialize.h"
#include "rand.h"
#include "randn.h"
#include <cmath>

/* Function Declarations */
static double rt_roundd_snf(double u);

/* Function Definitions */
static double rt_roundd_snf(double u)
{
  double y;
  if (std::abs(u) < 4.503599627370496E+15) {
    if (u >= 0.5) {
      y = std::floor(u + 0.5);
    } else if (u > -0.5) {
      y = u * 0.0;
    } else {
      y = std::ceil(u - 0.5);
    }
  } else {
    y = u;
  }

  return y;
}

void LSM(const struct0_T *opt, struct1_T *lsm)
{
  double r;
  double kx;
  double ky;
  double m_tmp_tmp;
  double wee;
  int i;
  int loop_ub;
  emxArray_real_T *d;
  int loop_ub_tmp;
  emxArray_boolean_T *E;
  emxArray_real_T *ckk;
  int i2;
  emxArray_int8_T *C;
  emxArray_real_T *W;
  emxArray_real_T *p;
  emxArray_int32_T *idx;
  double wei;
  int n;
  emxArray_int32_T *iwork;
  int b_i;
  int q;
  emxArray_real_T *Win;
  int qEnd;
  int j;
  int i1;
  int pEnd;
  int b_p;
  unsigned int bu;
  double b_d;
  int kEnd;
  int q0;
  double a;
  int exitg1;
  int b_q0;
  long b_i2;
  int d_tmp;
  if (isInitialized_LSM == false) {
    LSM_initialize();
  }

  r = opt->r;
  kx = opt->kx;
  ky = opt->ky;
  m_tmp_tmp = opt->kx * opt->ky;
  wee = m_tmp_tmp * opt->kz;
  lsm->n = opt->n;
  lsm->r = opt->r;
  lsm->tm = opt->tm;
  lsm->tc = opt->tc;
  lsm->vth = opt->vth;
  lsm->tf = opt->tf;
  lsm->dt = opt->dt;
  i = lsm->v->size[0] * lsm->v->size[1];
  lsm->v->size[0] = 1;
  loop_ub = static_cast<int>(wee);
  lsm->v->size[1] = loop_ub;
  emxEnsureCapacity_real_T(lsm->v, i);
  for (i = 0; i < loop_ub; i++) {
    lsm->v->data[i] = 0.0;
  }

  i = lsm->t->size[0] * lsm->t->size[1];
  lsm->t->size[0] = 1;
  lsm->t->size[1] = loop_ub;
  emxEnsureCapacity_real_T(lsm->t, i);
  for (i = 0; i < loop_ub; i++) {
    lsm->t->data[i] = 0.0;
  }

  emxInit_real_T(&d, 2);
  lsm->kx = opt->kx;
  lsm->ky = opt->ky;
  lsm->kz = opt->kz;
  lsm->m = wee;
  i = d->size[0] * d->size[1];
  d->size[0] = loop_ub;
  d->size[1] = loop_ub;
  emxEnsureCapacity_real_T(d, i);
  loop_ub_tmp = loop_ub * loop_ub;
  for (i = 0; i < loop_ub_tmp; i++) {
    d->data[i] = 0.0;
  }

  emxInit_boolean_T(&E, 2);
  emxInit_real_T(&ckk, 2);
  randn(wee, ckk);
  i = E->size[0] * E->size[1];
  E->size[0] = 1;
  E->size[1] = ckk->size[1];
  emxEnsureCapacity_boolean_T(E, i);
  i2 = ckk->size[0] * ckk->size[1];
  for (i = 0; i < i2; i++) {
    E->data[i] = (ckk->data[i] >= 0.4);
  }

  emxInit_int8_T(&C, 2);
  i = C->size[0] * C->size[1];
  C->size[0] = loop_ub;
  C->size[1] = loop_ub;
  emxEnsureCapacity_int8_T(C, i);
  for (i = 0; i < loop_ub_tmp; i++) {
    C->data[i] = 0;
  }

  emxInit_real_T(&W, 2);
  i = W->size[0] * W->size[1];
  W->size[0] = loop_ub;
  W->size[1] = loop_ub;
  emxEnsureCapacity_real_T(W, i);
  for (i = 0; i < loop_ub_tmp; i++) {
    W->data[i] = 0.0;
  }

  emxInit_real_T(&p, 2);
  i = p->size[0] * p->size[1];
  p->size[0] = loop_ub;
  p->size[1] = loop_ub;
  emxEnsureCapacity_real_T(p, i);
  for (i = 0; i < loop_ub_tmp; i++) {
    p->data[i] = 0.0;
  }

  emxInit_int32_T(&idx, 2);
  wee = opt->wee;
  wei = opt->wei;

  /*      assert((kx*ky*kz==n),'kx*ky*kz!=n'); */
  b_rand(opt->kz, ckk);
  n = ckk->size[1] + 1;
  i = idx->size[0] * idx->size[1];
  idx->size[0] = 1;
  idx->size[1] = ckk->size[1];
  emxEnsureCapacity_int32_T(idx, i);
  i2 = ckk->size[1];
  for (i = 0; i < i2; i++) {
    idx->data[i] = 0;
  }

  if (ckk->size[1] != 0) {
    emxInit_int32_T(&iwork, 1);
    i = iwork->size[0];
    iwork->size[0] = ckk->size[1];
    emxEnsureCapacity_int32_T(iwork, i);
    i = ckk->size[1] - 1;
    for (loop_ub_tmp = 1; loop_ub_tmp <= i; loop_ub_tmp += 2) {
      if (ckk->data[loop_ub_tmp - 1] <= ckk->data[loop_ub_tmp]) {
        idx->data[loop_ub_tmp - 1] = loop_ub_tmp;
        idx->data[loop_ub_tmp] = loop_ub_tmp + 1;
      } else {
        idx->data[loop_ub_tmp - 1] = loop_ub_tmp + 1;
        idx->data[loop_ub_tmp] = loop_ub_tmp;
      }
    }

    if ((ckk->size[1] & 1) != 0) {
      idx->data[ckk->size[1] - 1] = ckk->size[1];
    }

    b_i = 2;
    while (b_i < n - 1) {
      i2 = b_i << 1;
      j = 1;
      for (pEnd = b_i + 1; pEnd < n; pEnd = qEnd + b_i) {
        b_p = j;
        q = pEnd;
        qEnd = j + i2;
        if (qEnd > n) {
          qEnd = n;
        }

        loop_ub_tmp = 0;
        kEnd = qEnd - j;
        while (loop_ub_tmp + 1 <= kEnd) {
          i = idx->data[q - 1];
          i1 = idx->data[b_p - 1];
          if (ckk->data[i1 - 1] <= ckk->data[i - 1]) {
            iwork->data[loop_ub_tmp] = i1;
            b_p++;
            if (b_p == pEnd) {
              while (q < qEnd) {
                loop_ub_tmp++;
                iwork->data[loop_ub_tmp] = idx->data[q - 1];
                q++;
              }
            }
          } else {
            iwork->data[loop_ub_tmp] = i;
            q++;
            if (q == qEnd) {
              while (b_p < pEnd) {
                loop_ub_tmp++;
                iwork->data[loop_ub_tmp] = idx->data[b_p - 1];
                b_p++;
              }
            }
          }

          loop_ub_tmp++;
        }

        for (loop_ub_tmp = 0; loop_ub_tmp < kEnd; loop_ub_tmp++) {
          idx->data[(j + loop_ub_tmp) - 1] = iwork->data[loop_ub_tmp];
        }

        j = qEnd;
      }

      b_i = i2;
    }

    emxFree_int32_T(&iwork);
  }

  loop_ub_tmp = ckk->size[0];
  i2 = ckk->size[1];
  i = ckk->size[0] * ckk->size[1];
  ckk->size[0] = 1;
  emxEnsureCapacity_real_T(ckk, i);
  i2 *= loop_ub_tmp;
  for (i = 0; i < i2; i++) {
    ckk->data[i] = idx->data[i];
  }

  emxFree_int32_T(&idx);
  i = static_cast<int>(opt->kz);
  for (q = 0; q < i; q++) {
    qEnd = static_cast<int>(ckk->data[q]);
    i1 = static_cast<int>(m_tmp_tmp);
    for (b_i = 0; b_i < i1; b_i++) {
      if (0 <= i1 - 1) {
        bu = b_i + 1U;
        if (bu < 2147483648U) {
          loop_ub_tmp = static_cast<int>(bu);
        } else {
          loop_ub_tmp = MAX_int32_T;
        }

        b_d = rt_roundd_snf(static_cast<double>(loop_ub_tmp) / ky);
        if (b_d < 2.147483648E+9) {
          if (b_d >= -2.147483648E+9) {
            q0 = static_cast<int>(b_d);
          } else {
            q0 = MIN_int32_T;
          }
        } else if (b_d >= 2.147483648E+9) {
          q0 = MAX_int32_T;
        } else {
          q0 = 0;
        }

        a = (static_cast<double>(q) + 1.0) - static_cast<double>(qEnd);
        b_d = rt_roundd_snf(static_cast<double>(q0) * ky);
        if (b_d < 2.147483648E+9) {
          if (b_d >= -2.147483648E+9) {
            loop_ub_tmp = static_cast<int>(b_d);
          } else {
            loop_ub_tmp = MIN_int32_T;
          }
        } else if (b_d >= 2.147483648E+9) {
          loop_ub_tmp = MAX_int32_T;
        } else {
          loop_ub_tmp = 0;
        }

        b_d = (static_cast<double>(b_i) + 1.0) - static_cast<double>(loop_ub_tmp);
        if (b_d < 2.147483648E+9) {
          b_q0 = static_cast<int>(b_d);
        } else {
          b_q0 = MAX_int32_T;
        }

        d_tmp = static_cast<int>((((static_cast<double>(q) + 1.0) - 1.0) * kx *
          ky + (static_cast<double>(b_i) + 1.0))) - 1;
      }

      for (j = 0; j < i1; j++) {
        bu = j + 1U;
        if (bu < 2147483648U) {
          loop_ub_tmp = static_cast<int>(bu);
        } else {
          loop_ub_tmp = MAX_int32_T;
        }

        b_d = rt_roundd_snf(static_cast<double>(loop_ub_tmp) / ky);
        if (b_d < 2.147483648E+9) {
          if (b_d >= -2.147483648E+9) {
            loop_ub_tmp = static_cast<int>(b_d);
          } else {
            loop_ub_tmp = MIN_int32_T;
          }
        } else if (b_d >= 2.147483648E+9) {
          loop_ub_tmp = MAX_int32_T;
        } else {
          loop_ub_tmp = 0;
        }

        if ((q0 >= 0) && (loop_ub_tmp < q0 - MAX_int32_T)) {
          pEnd = MAX_int32_T;
        } else if ((q0 < 0) && (loop_ub_tmp > q0 - MIN_int32_T)) {
          pEnd = MIN_int32_T;
        } else {
          pEnd = q0 - loop_ub_tmp;
        }

        b_p = 1;
        bu = 2U;
        do {
          exitg1 = 0;
          if ((bu & 1U) != 0U) {
            b_i2 = static_cast<long>(pEnd) * b_p;
            if (b_i2 > 2147483647L) {
              b_i2 = 2147483647L;
            } else {
              if (b_i2 < -2147483648L) {
                b_i2 = -2147483648L;
              }
            }

            b_p = static_cast<int>(b_i2);
          }

          bu >>= 1U;
          if (static_cast<int>(bu) == 0) {
            exitg1 = 1;
          } else {
            b_i2 = static_cast<long>(pEnd) * pEnd;
            if (b_i2 > 2147483647L) {
              b_i2 = 2147483647L;
            } else {
              if (b_i2 < -2147483648L) {
                b_i2 = -2147483648L;
              }
            }

            pEnd = static_cast<int>(b_i2);
          }
        } while (exitg1 == 0);

        b_d = rt_roundd_snf(static_cast<double>(loop_ub_tmp) * ky);
        if (b_d < 2.147483648E+9) {
          if (b_d >= -2.147483648E+9) {
            loop_ub_tmp = static_cast<int>(b_d);
          } else {
            loop_ub_tmp = MIN_int32_T;
          }
        } else if (b_d >= 2.147483648E+9) {
          loop_ub_tmp = MAX_int32_T;
        } else {
          loop_ub_tmp = 0;
        }

        b_d = (static_cast<double>(j) + 1.0) - static_cast<double>(loop_ub_tmp);
        if (b_d < 2.147483648E+9) {
          loop_ub_tmp = static_cast<int>(b_d);
        } else {
          loop_ub_tmp = MAX_int32_T;
        }

        if ((b_q0 >= 0) && (loop_ub_tmp < b_q0 - MAX_int32_T)) {
          pEnd = MAX_int32_T;
        } else if ((b_q0 < 0) && (loop_ub_tmp > b_q0 - MIN_int32_T)) {
          pEnd = MIN_int32_T;
        } else {
          pEnd = b_q0 - loop_ub_tmp;
        }

        i2 = 1;
        bu = 2U;
        do {
          exitg1 = 0;
          if ((bu & 1U) != 0U) {
            b_i2 = static_cast<long>(pEnd) * i2;
            if (b_i2 > 2147483647L) {
              b_i2 = 2147483647L;
            } else {
              if (b_i2 < -2147483648L) {
                b_i2 = -2147483648L;
              }
            }

            i2 = static_cast<int>(b_i2);
          }

          bu >>= 1U;
          if (static_cast<int>(bu) == 0) {
            exitg1 = 1;
          } else {
            b_i2 = static_cast<long>(pEnd) * pEnd;
            if (b_i2 > 2147483647L) {
              b_i2 = 2147483647L;
            } else {
              if (b_i2 < -2147483648L) {
                b_i2 = -2147483648L;
              }
            }

            pEnd = static_cast<int>(b_i2);
          }
        } while (exitg1 == 0);

        b_d = a * a + static_cast<double>(b_p);
        if (b_d < 2.147483648E+9) {
          if (b_d >= -2.147483648E+9) {
            loop_ub_tmp = static_cast<int>(b_d);
          } else {
            loop_ub_tmp = MIN_int32_T;
          }
        } else {
          loop_ub_tmp = MAX_int32_T;
        }

        if ((loop_ub_tmp < 0) && (i2 < MIN_int32_T - loop_ub_tmp)) {
          pEnd = MIN_int32_T;
        } else if ((loop_ub_tmp > 0) && (i2 > MAX_int32_T - loop_ub_tmp)) {
          pEnd = MAX_int32_T;
        } else {
          pEnd = loop_ub_tmp + i2;
        }

        loop_ub_tmp = static_cast<int>(((static_cast<double>(qEnd) - 1.0) * kx *
          ky + (static_cast<double>(j) + 1.0))) - 1;
        d->data[d_tmp + d->size[0] * loop_ub_tmp] = std::sqrt(static_cast<double>
          (pEnd));
        if (E->data[d_tmp] && E->data[loop_ub_tmp]) {
          p->data[d_tmp + p->size[0] * loop_ub_tmp] = opt->kee * std::exp
            (-d->data[d_tmp + d->size[0] * loop_ub_tmp] / r);
          C->data[d_tmp + C->size[0] * loop_ub_tmp] = static_cast<signed char>
            ((c_rand() > p->data[d_tmp + p->size[0] * loop_ub_tmp]));
          W->data[d_tmp + W->size[0] * loop_ub_tmp] = static_cast<double>
            (C->data[d_tmp + C->size[0] * loop_ub_tmp]) * wee;
        } else if (E->data[b_i] && (!E->data[j])) {
          p->data[d_tmp + p->size[0] * loop_ub_tmp] = opt->kei * std::exp
            (-d->data[d_tmp + d->size[0] * loop_ub_tmp] / r);
          C->data[d_tmp + C->size[0] * loop_ub_tmp] = static_cast<signed char>
            ((c_rand() > p->data[d_tmp + p->size[0] * loop_ub_tmp]));
          W->data[d_tmp + W->size[0] * loop_ub_tmp] = static_cast<double>
            (C->data[d_tmp + C->size[0] * loop_ub_tmp]) * wei;
        } else if ((!E->data[b_i]) && E->data[j]) {
          p->data[d_tmp + p->size[0] * loop_ub_tmp] = opt->kie * std::exp
            (-d->data[d_tmp + d->size[0] * loop_ub_tmp] / r);
          C->data[d_tmp + C->size[0] * loop_ub_tmp] = static_cast<signed char>
            ((c_rand() > p->data[d_tmp + p->size[0] * loop_ub_tmp]));
          W->data[d_tmp + W->size[0] * loop_ub_tmp] = static_cast<double>
            (C->data[d_tmp + C->size[0] * loop_ub_tmp]) * opt->wie;
        } else {
          if ((!E->data[b_i]) && (!E->data[j])) {
            p->data[d_tmp + p->size[0] * loop_ub_tmp] = opt->kii * std::exp
              (-d->data[d_tmp + d->size[0] * loop_ub_tmp] / r);
            C->data[d_tmp + C->size[0] * loop_ub_tmp] = static_cast<signed char>
              ((c_rand() > p->data[d_tmp + p->size[0] * loop_ub_tmp]));
            W->data[d_tmp + W->size[0] * loop_ub_tmp] = static_cast<double>
              (C->data[d_tmp + C->size[0] * loop_ub_tmp]) * opt->wii;
          }
        }
      }
    }
  }

  emxInit_real_T(&Win, 2);

  /*      for i = 1 : m */
  /*          a = int32(i); */
  /*          x = a / (ky*kz); */
  /*          y = mod(a, (ky*kz)); */
  /*          z = mod(y, kz); */
  /*          y = y / kz; */
  /*          for j = 1 : n */
  /*              a = int32(j); */
  /*              xj = a / (ky*kz); */
  /*              yj = mod(a, (ky*kz)); */
  /*              zj = mod(yj, kz); */
  /*              yj = yj / kz; */
  /*              d(pre,post) = double((x-xj)^2 + (y-yj)^2 + (z-zj)^2); */
  /*               */
  /*              if (E(i)==1 && E(j)==1)  */
  /*                  p(pre,post) = kee * exp(-1*d(pre,post)/r); */
  /*                  C(pre,post) = rand > p(pre,post); */
  /*                  W(pre,post) = C(pre,post) * wee; */
  /*              elseif (E(i)==1 && E(j)==0)  */
  /*                  p(pre,post) = kei * exp(-1 * d(pre,post)/r); */
  /*                  C(pre,post) = rand > p(pre,post); */
  /*                  W(pre,post) = C(pre,post) * wei; */
  /*              elseif (E(i)==0 && E(j)==1)  */
  /*                  p(pre,post) = kie * exp(-1 * d(pre,post)/r); */
  /*                  C(pre,post) = rand > p(pre,post); */
  /*                  W(pre,post) = C(pre,post) * wie ; */
  /*              elseif (E(i)==0 && E(j)==0)  */
  /*                  p(pre,post) = kii * exp(-1 *d(pre,post)/r); */
  /*                  C(pre,post) = rand > p(pre,post); */
  /*                  W(pre,post) = C(pre,post) * wii; */
  /*              end */
  /*          end */
  /*      end */
  i = static_cast<int>(opt->n);
  i1 = Win->size[0] * Win->size[1];
  Win->size[0] = i;
  Win->size[1] = loop_ub;
  emxEnsureCapacity_real_T(Win, i1);
  i2 = i * loop_ub;
  for (i = 0; i < i2; i++) {
    Win->data[i] = 0.0;
  }

  bu = 0U;
  for (j = 0; j < loop_ub; j++) {
    bu++;
    if (bu > opt->n) {
      bu = 1U;
    }

    if (E->data[j]) {
      Win->data[(static_cast<int>(bu) + Win->size[0] * j) - 1] = wee;
    } else {
      Win->data[(static_cast<int>(bu) + Win->size[0] * j) - 1] = wei;
    }
  }

  /*      for i = 1 : n */
  /*          for j = 1 : m */
  /*              if E(j)==1 */
  /*                  Win(pre,post) = 1; */
  /*              else */
  /*                  Win(pre,post) = 1; */
  /*              end */
  /*          end */
  /*      end */
  i = lsm->e->size[0] * lsm->e->size[1];
  lsm->e->size[0] = 1;
  lsm->e->size[1] = E->size[1];
  emxEnsureCapacity_boolean_T(lsm->e, i);
  i2 = E->size[0] * E->size[1];
  for (i = 0; i < i2; i++) {
    lsm->e->data[i] = E->data[i];
  }

  emxFree_boolean_T(&E);
  i = lsm->d->size[0] * lsm->d->size[1];
  lsm->d->size[0] = d->size[0];
  lsm->d->size[1] = d->size[1];
  emxEnsureCapacity_real_T(lsm->d, i);
  i2 = d->size[0] * d->size[1];
  for (i = 0; i < i2; i++) {
    lsm->d->data[i] = d->data[i];
  }

  emxFree_real_T(&d);
  i = lsm->p->size[0] * lsm->p->size[1];
  lsm->p->size[0] = p->size[0];
  lsm->p->size[1] = p->size[1];
  emxEnsureCapacity_real_T(lsm->p, i);
  i2 = p->size[0] * p->size[1];
  for (i = 0; i < i2; i++) {
    lsm->p->data[i] = p->data[i];
  }

  emxFree_real_T(&p);
  i = lsm->C->size[0] * lsm->C->size[1];
  lsm->C->size[0] = C->size[0];
  lsm->C->size[1] = C->size[1];
  emxEnsureCapacity_real_T(lsm->C, i);
  i2 = C->size[0] * C->size[1];
  for (i = 0; i < i2; i++) {
    lsm->C->data[i] = C->data[i];
  }

  emxFree_int8_T(&C);
  i = lsm->W->size[0] * lsm->W->size[1];
  lsm->W->size[0] = W->size[0];
  lsm->W->size[1] = W->size[1];
  emxEnsureCapacity_real_T(lsm->W, i);
  i2 = W->size[0] * W->size[1];
  for (i = 0; i < i2; i++) {
    lsm->W->data[i] = W->data[i];
  }

  emxFree_real_T(&W);
  i = lsm->Win->size[0] * lsm->Win->size[1];
  lsm->Win->size[0] = Win->size[0];
  lsm->Win->size[1] = Win->size[1];
  emxEnsureCapacity_real_T(lsm->Win, i);
  i2 = Win->size[0] * Win->size[1];
  for (i = 0; i < i2; i++) {
    lsm->Win->data[i] = Win->data[i];
  }

  emxFree_real_T(&Win);
  i = lsm->ckk->size[0] * lsm->ckk->size[1];
  lsm->ckk->size[0] = 1;
  lsm->ckk->size[1] = ckk->size[1];
  emxEnsureCapacity_real_T(lsm->ckk, i);
  i2 = ckk->size[0] * ckk->size[1];
  for (i = 0; i < i2; i++) {
    lsm->ckk->data[i] = ckk->data[i];
  }

  emxFree_real_T(&ckk);
  for (b_i = 0; b_i < loop_ub; b_i++) {
    lsm->W->data[b_i + lsm->W->size[0] * b_i] = 0.0;
    lsm->C->data[b_i + lsm->C->size[0] * b_i] = 0.0;
  }
}

/* End of code generation (LSM.cpp) */
