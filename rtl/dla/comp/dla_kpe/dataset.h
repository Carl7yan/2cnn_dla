#define _CRT_SECURE_NO_WARNINGS
#include<stdio.h>
#include<math.h>
#include<stdlib.h>

#define FULL_L 16
#define FRAC_L 13
#define EXTEND_L 8
#define MULT_VALUE (pow((float)2, FRAC_L))
#define MAX_VALUE (pow((float)2, FULL_L - FRAC_L - 1))

#define FULL_L_SOFTMAX 16
#define FRAC_L_SOFTMAX 13

int TruncateOr(double x);

int**** FourdMallocFix(int batch, int depth, int height, int width);

int FourdFreeFix(int**** fourd, int batch, int depth, int height, int width);

void FourdReadFix(int**** fourd, char* addr, int batch, int depth, int height, int width, float mult_value, float max_value);

void FourdQuantizeFix(int**** fourd, int batch, int depth, int height, int width, float pre_mult_value, float mult_value, float max_value);

void FourdWriteFix(int**** fourd, char* addr, int batch, int depth, int height, int width, float mult_value);

int** MatMallocFix(int mat_h, int mat_w);

int MatFreeFix(int** mat, int mat_h, int mat_w);

void MatReadFix(int** mat, char* addr, int mat_h, int mat_w, float mult_value, float max_value);

void MatQuantizeFix(int** mat, int mat_h, int mat_w, float pre_mult_value, float mult_value, float max_value);

void MatWriteFix(int** mat, char* addr, int mat_h, int mat_w, float mult_value);

void FourdReLUFix(int**** ifm, int**** ofm, int batch, int depth, int height, int width);

void MatReLUFix(int** ifm, int** ofm, int height, int width);

void FlattenFix(int**** ifm, int** ofm, int pi, int yi, int xi);

float** MatMallocFloat(int mat_h, int mat_w);

void MatFreeFloat(float** mat, int mat_h, int mat_w);

void MatReadFloat(float** mat, char* addr, int mat_h, int mat_w);

void MatSoftmaxFloat(float** in, float** out, int len);

void MatSoftmaxFix(int** in, int** out, int len, float mult_value, float max_value);

void FourdCopyFix(int**** ifm, int**** ofm, int batch, int depth, int height, int width);

void MatCopyFix(int** ifm, int** ofm, int mat_h, int mat_w);

void GetOneTopPrediction(int** input, int length, int* max_clas);

void GetFiveTopPrediction(int** input, int length, int* max_clas);

void SoftMaxFloat(float** in, float** out, int len);

void SoftMaxFixWithDeCompressFactor(int** in, int** out, int len, float factor, int frac_len);

void SoftMaxFixAutoDynamicFactor(int** in, int** out, int len);

void MatMaxandMinFix(int *max, int *min, int** mat, int mat_h, int mat_w);