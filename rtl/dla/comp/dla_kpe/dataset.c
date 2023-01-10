#include"dataset.h"
#include <veriuser.h>


int TruncateOr(double x)
{
	/*** This function is a kind of rounding strategy.
	The algorithm is presented below(numbers are presented in binary):
	0.0 ==> 0
	0.1 ==> 1
	1.0 ==> 1
	1.1 ==> 1
	*/
	//int x_i = floor(x);
	//int y = (x_i % 2) ? (x_i) : (floor(x + 0.5));
	//int y = round(x);
	//double k;
	int y ;
	/*if(x >= 0)
	{
		y = floor(x + 0.5);
	}
	else 
	{
		k = ceil(x) - 0.5;
		if(x >= k)
		{	
			y = k;
			io_printf("y = %x, k = %lf\n",y,k);
		}
		else 
		{
			y = ceil(x - 1);
			io_printf("ceil(x - 1) = %lf\n",ceil(x - 1));
			io_printf("y = %x\n",y);
		}
				
	}
	*/
	return y = floor(x + 0.5);
}


int**** FourdMallocFix(int batch, int depth, int height, int width)
{
	int i, j, k;
	int**** fourd = (int****)malloc(sizeof(int***) * batch);
	for (i = 0; i < batch; i++) {
		fourd[i] = (int***)malloc(sizeof(int**) * depth);
		for (j = 0; j < depth; j++) {
			fourd[i][j] = (int**)malloc(sizeof(int*) * height);
			for (k = 0; k < height; k++)
				fourd[i][j][k] = (int*)malloc(sizeof(int) * width);
		}
	}
	return fourd;
}

int FourdFreeFix(int**** fourd, int batch, int depth, int height, int width)
{
	int i, j, k;

	for (i = 0; i < batch; i++) {
		for (j = 0; j < depth; j++) {
			for (k = 0; k < height; k++) {
				free(fourd[i][j][k]);
			}
			free(fourd[i][j]);
		}
		free(fourd[i]);
	}
	free(fourd);
	return 0;
}

void FourdReadFix(int**** fourd, char* addr, int batch, int depth, int height, int width, float mult_value, float max_value)
{
	FILE* fid = fopen(addr, "r");
	float tmp;
	int i, j, k, t;
	for (i = 0; i < batch; i++)
		for (j = 0; j < depth; j++)
			for (k = 0; k < height; k++)
				for (t = 0; t < width; t++) {
					fscanf(fid, "%f", &tmp);
					
					//fourd[i][j][k][t] = floor(tmp * mult_value);
					//fourd[i][j][k][t] = TruncateOr(tmp * mult_value);
					fourd[i][j][k][t] = round(tmp * mult_value);

					if (fourd[i][j][k][t] >= max_value * mult_value)
						fourd[i][j][k][t] = max_value * mult_value - 1;
					else if (fourd[i][j][k][t] < -max_value * mult_value)
						fourd[i][j][k][t] = -max_value * mult_value;
					
				}
	
	fclose(fid);
}

void FourdQuantizeFix(int**** fourd, int batch, int depth, int height, int width, float pre_mult_value, float mult_value, float max_value)
{
	float tmp;
	int i, j, k, t;
	for (i = 0; i < batch; i++)
		for (j = 0; j < depth; j++)
			for (k = 0; k < height; k++)
				for (t = 0; t < width; t++) {
					tmp = (float)fourd[i][j][k][t] / pre_mult_value;

					//fourd[i][j][k][t] = TruncateOr(tmp * mult_value);
					fourd[i][j][k][t] = round(tmp * mult_value);
					//fourd[i][j][k][t] = floor(tmp * mult_value);

					if (fourd[i][j][k][t] >= max_value * mult_value)
						fourd[i][j][k][t] = max_value * mult_value - 1;
					else if (fourd[i][j][k][t] < -max_value * mult_value)
						fourd[i][j][k][t] = -max_value * mult_value;

				}
}

void FourdWriteFix(int**** fourd, char* addr, int batch, int depth, int height, int width, float mult_value)
{
	FILE* fid = fopen(addr, "w"); //change to "a" temporily
	int i, j, k, t;
	for (i = 0; i < batch; i++)
		for (j = 0; j < depth; j++) 
			for (k = 0; k < height; k++) 
				for (t = 0; t < width; t++)
					fprintf(fid, "%.18f\n", (float)fourd[i][j][k][t] / mult_value);
		
	fclose(fid);
}


int** MatMallocFix(int mat_h, int mat_w)
{
	int i;
	int** w = (int**)malloc(sizeof(int*) * mat_h);
	for (i = 0; i < mat_h; i++) {
		w[i] = (int*)malloc(sizeof(int) * mat_w);
	}
	return w;
}

int MatFreeFix(int** mat, int mat_h, int mat_w)
{
	int i;

	for (i = 0; i < mat_h; i++) {
		if (mat[i] != NULL)
			free(mat[i]);
	}
	free(mat);
	return 0;
}

void MatReadFix(int** mat, char* addr, int mat_h, int mat_w, float mult_value, float max_value)
{
	FILE* fid = fopen(addr, "r");
	float tmp;
	int i, j;
	for (i = 0; i < mat_h; i++)
		for (j = 0; j < mat_w; j++) {
			fscanf(fid, "%f", &tmp);

			//mat[i][j] = (int)(tmp * mult_value);        
			//mat[i][j] = TruncateOr(tmp * mult_value);
			mat[i][j] = round(tmp * mult_value);
			//mat[i][j] = floor(tmp * mult_value);

			if (mat[i][j] >= max_value * mult_value)
				mat[i][j] = max_value * mult_value - 1;

			else if (mat[i][j] < -max_value * mult_value)
				mat[i][j] = -max_value * mult_value;

		}
	fclose(fid);
}

void MatQuantizeFix(int** mat, int mat_h, int mat_w, float pre_mult_value, float mult_value, float max_value)
{
	float tmp;
	int i, j;
	for (i = 0; i < mat_h; i++)
		for (j = 0; j < mat_w; j++) {
			tmp = (float)mat[i][j] / pre_mult_value;

			//mat[i][j] = (int)(tmp * mult_value);        
			//mat[i][j] = TruncateOr(tmp * mult_value);
			mat[i][j] = round(tmp * mult_value);
			//mat[i][j] = floor(tmp * mult_value);

			if (mat[i][j] >= max_value * mult_value)
				mat[i][j] = max_value * mult_value - 1;
			else if (mat[i][j] < -max_value * mult_value)
				mat[i][j] = -max_value * mult_value;

		}
}


void MatWriteFix(int** mat, char* addr, int mat_h, int mat_w, float mult_value)
{
	FILE* fid = fopen(addr, "w");//change to "a" temporily
	int i, j;
	for (i = 0; i < mat_h; i++)
		for (j = 0; j < mat_w; j++)
			fprintf(fid, "%.15f\n", (double)mat[i][j] / mult_value);
	fclose(fid);
}

void FourdReLUFix(int**** ifm, int**** ofm, int batch, int depth, int height, int width)
{
	int i, j, k, t;
	for (i = 0; i < batch; i++)
		for (j = 0; j < depth; j++)
			for (k = 0; k < height; k++)
				for (t = 0; t < width; t++)
					ofm[i][j][k][t] = (ifm[i][j][k][t] > 0) ? ifm[i][j][k][t] : 0;
}

void MatReLUFix(int** ifm, int** ofm, int height, int width)
{
	int i, j;
	for (i = 0; i < height; i++)
		for (j = 0; j < width; j++)
			ofm[i][j] = (ifm[i][j] > 0) ? ifm[i][j] : 0;
}

void FlattenFix(int**** ifm, int** ofm, int pi, int yi, int xi)
{
	int x, y, p;
	for (p = 0; p < pi; p++)
		for (y = 0; y < yi; y++)
			for (x = 0; x < xi; x++)
				ofm[p * xi * yi + y * xi + x][0] = ifm[0][p][y][x];
}

float** MatMallocFloat(int mat_h, int mat_w)
{
	int Lout;
	float** w = (float**)malloc(sizeof(float*) * mat_h);
	for (Lout = 0; Lout < mat_h; Lout++) {
		w[Lout] = (float*)malloc(sizeof(float) * mat_w);
	}
	return w;
}

void MatFreeFloat(float** mat, int mat_h, int mat_w)
{
	for (int i = 0; i < mat_h; i++) {
		if (mat[i] != NULL)
			free(mat[i]);
	}
	free(mat);
}

void MatReadFloat(float** mat, char* addr, int mat_h, int mat_w)
{
	FILE* fid = fopen(addr, "r");
	float tmp;
	int i, j;
	for (i = 0; i < mat_h; i++)
		for (j = 0; j < mat_w; j++) {
			fscanf(fid, "%f", &tmp);
			mat[i][j] = tmp;
		}
	fclose(fid);
}

void MatSoftmaxFloat(float** in, float** out, int len)
{
	float** tmp0 = MatMallocFloat(len, len);
	int i, j;
	long double tmp = 0;

	for (i = 0; i < len; i++)
		for (j = 0; j < len; j++)
			tmp0[i][j] = (in[i][0] - in[j][0]);  //compress the ifm by 156 times at first, so multiply 156 
																   //in softmax

	for (i = 0; i < len; i++) {
		tmp = 0;
		for (j = 0; j < len; j++)
			tmp += exp(-tmp0[i][j]);
		out[i][0] = 1 / tmp;
	}
	MatFreeFloat(tmp0, len, len);
}


void MatSoftmaxFix(int** in, int** out, int len, float mult_value, float max_value)
{
	float** in_float = MatMallocFloat(len, 1);
	float** out_float = MatMallocFloat(len, 1);

	int i;
	float tmp;

	for (i = 0; i < len; i++)
		in_float[i][0] = (double)in[i][0] / mult_value;

	MatSoftmaxFloat(in_float, out_float, len);

	for (i = 0; i < len; i++) {
		tmp = out_float[i][0];
		if (tmp > max_value)
			tmp = max_value;
		else if (tmp < -max_value)
			tmp = -max_value;
		out[i][0] = tmp * mult_value;
	}
	MatFreeFloat(in_float, len, 1);
	MatFreeFloat(out_float, len, 1);
}

void FourdCopyFix(int**** ifm, int**** ofm, int batch, int depth, int height, int width)
{
	int i, j, k, t;
	for (i = 0; i < batch; i++)
		for (j = 0; j < depth; j++)
			for (k = 0; k < height; k++)
				for (t = 0; t < width; t++)
					ofm[i][j][k][t] = ifm[i][j][k][t];
}

void MatCopyFix(int** ifm, int** ofm, int mat_h, int mat_w)
{
	int i, j;
	for (i = 0; i < mat_h; i++)
		for (j = 0; j < mat_w; j++)
			ofm[i][j] = ifm[i][j];
}

void GetOneTopPrediction(int** input, int length, int* max_clas)
{
	int max_clas_value = -pow(2, FULL_L - 1);
	int k;
	for (k = 0; k < length; k++) {
		if (input[k][0] > max_clas_value) {
			*max_clas = k;
			max_clas_value = input[k][0];
		}
	}
}

void GetFiveTopPrediction(int** input, int length, int* max_clas)
{
	int max_clas_value[5];
	int i;
	for (i = 0; i < 5; i++) {
		max_clas_value[i] = -pow(2, FULL_L - 1);
		max_clas[i] = 0;
	}

	int k;
	for (k = 0; k < length; k++) {
		if (input[k][0] > max_clas_value[0]) {
			max_clas[4] = max_clas[3]; max_clas_value[4] = max_clas_value[3];
			max_clas[3] = max_clas[2]; max_clas_value[3] = max_clas_value[2];
			max_clas[2] = max_clas[1]; max_clas_value[2] = max_clas_value[1];
			max_clas[1] = max_clas[0]; max_clas_value[1] = max_clas_value[0];
			max_clas[0] = k; max_clas_value[0] = input[k][0];
		}
		else if (input[k][0] > max_clas_value[1]) {
			max_clas[4] = max_clas[3]; max_clas_value[4] = max_clas_value[3];
			max_clas[3] = max_clas[2]; max_clas_value[3] = max_clas_value[2];
			max_clas[2] = max_clas[1]; max_clas_value[2] = max_clas_value[1];
			max_clas[1] = k; max_clas_value[1] = input[k][0];
		}
		else if (input[k][0] > max_clas_value[2]) {
			max_clas[4] = max_clas[3]; max_clas_value[4] = max_clas_value[3];
			max_clas[3] = max_clas[2]; max_clas_value[3] = max_clas_value[2];
			max_clas[2] = k; max_clas_value[2] = input[k][0];
		}
		else if (input[k][0] > max_clas_value[3]) {
			max_clas[4] = max_clas[3]; max_clas_value[4] = max_clas_value[3];
			max_clas[3] = k; max_clas_value[3] = input[k][0];
		}
		else if (input[k][0] > max_clas_value[4]) {
			max_clas[4] = k; max_clas_value[4] = input[k][0];
		}
	}
}

void SoftMaxFloat(float** in, float** out, int len)
{
	float** tmp0 = MatMallocFloat(len, len);
	int i, j;
	long double tmp = 0;

	for (i = 0; i < len; i++)
		for (j = 0; j < len; j++)
			tmp0[i][j] = (in[i][0] - in[j][0]);

	for (i = 0; i < len; i++) {
		tmp = 0;
		for (j = 0; j < len; j++)
			tmp += exp(-tmp0[i][j]);
		out[i][0] = 1.0 / tmp;
	}
	MatFreeFloat(tmp0, len, len);
}

void SoftMaxFixWithDeCompressFactor(int** in, int** out, int len, float factor, int frac_len)
{
	float** in_float = MatMallocFloat(len, 1);
	float** out_float = MatMallocFloat(len, 1);

	int i;
	float tmp;

	for (i = 0; i < len; i++)
		in_float[i][0] = (double)in[i][0] / pow(2, frac_len) * factor;

	SoftMaxFloat(in_float, out_float, len);

	for (i = 0; i < len; i++) {
		tmp = out_float[i][0];
		tmp *= pow(2, FRAC_L_SOFTMAX);
		if (tmp >= pow(2, FULL_L_SOFTMAX - 1))
			tmp = pow(2, FULL_L_SOFTMAX - 1) - 1;
		else if (tmp < -pow(2, FULL_L_SOFTMAX - 1))
			tmp = -pow(2, FULL_L_SOFTMAX - 1);
		out[i][0] = tmp;
	}
	MatFreeFloat(in_float, len, 1);
	MatFreeFloat(out_float, len, 1);
}

void MatMaxandMinFix(int *max, int *min, int** mat, int mat_h, int mat_w)
{
	*max = -pow(2, FULL_L - 1);
	*min = pow(2, FULL_L - 1) - 1;

	for (int i = 0; i < mat_h; i++)
		for (int j = 0; j < mat_w; j++) {
			*max = (mat[i][j] > *max) ? mat[i][j] : *max;
			*min = (mat[i][j] < *min) ? mat[i][j] : *min;
		}

}

void SoftMaxFixAutoDynamicFactor(int** in, int** out, int len)
{
	float** in_float = MatMallocFloat(len, 1);
	float** out_float = MatMallocFloat(len, 1);

	int i;
	float tmp;

	int *in_max, *in_min;
	in_max = (int*)malloc(sizeof(int));
	in_min = (int*)malloc(sizeof(int));
	MatMaxandMinFix(in_max, in_min, in, len, 1);

	double auto_factor;
	auto_factor = (double)16 / (*in_max - *in_min);

	for (i = 0; i < len; i++)
		in_float[i][0] = (double)in[i][0] * auto_factor;

	SoftMaxFloat(in_float, out_float, len);

	for (i = 0; i < len; i++) {
		tmp = out_float[i][0];
		tmp *= pow(2, FRAC_L_SOFTMAX);
		if (tmp >= pow(2, FULL_L_SOFTMAX - 1))
			tmp = pow(2, FULL_L_SOFTMAX - 1) - 1;
		else if (tmp < -pow(2, FULL_L_SOFTMAX - 1))
			tmp = -pow(2, FULL_L_SOFTMAX - 1);
		out[i][0] = tmp;
	}

	MatFreeFloat(in_float, len, 1);
	MatFreeFloat(out_float, len, 1);
	free(in_min);
	free(in_max);
}

