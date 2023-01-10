#include <stdio.h>
#include <math.h>
#include <stdbool.h>
#include "dataset.h"
#include <veriuser.h>

int KCEConvMacOperation(int* fake_ifm_buffer, int* weight_buffer, int mult_shift_bit, int trun1,int trun2, int add_shift_bit, bool is_print)
{

/*****************************************************************************************************/
//	This function is to simulate the multiply operation in KCE.
//	Para	:   weight_buffer   : The pointer to weight buffer.
//				fake_ifm_buffer : The pointer to ifm pixels involved in this
//								  iteration. Although there is no ifm buffer in the KCE,
//								  we use this pointer to avoid calculating address in this function.
//				mult_shift_bit	: Shift the sum to avoid overflow. Positive means number right shift,
//								  negative means number left shift.
//				add_shift_bit	: Shift the sum to avoid overflow. Positive means number left shift,
//								  negative means number right shift.
//
//	Return  :   The output of the mac operation.
/*****************************************************************************************************/

	int result = 0;
	int products[14];
	for (int i = 0; i < 14; i++) {

		//products[i] = fake_ifm_buffer[i] * weight_buffer[i];

		int weight_tmp = weight_buffer[i];
		int ifm_tmp = fake_ifm_buffer[i];
		//io_printf("weight_tmp = %x, ifm_tmp = %x\n",weight_tmp,ifm_tmp);
		//int sign = 0;
		//if ((weight_tmp >= 0 && ifm_tmp < 0) || (ifm_tmp >= 0 && weight_tmp < 0))
		//	sign = 1;
		//weight_tmp = abs(weight_tmp);
		//ifm_tmp = abs(ifm_tmp);

		products[i] = weight_tmp * ifm_tmp;
		
		//io_printf("products[%d] = %x\n",i,products[i]);
		// Shift, truncate .
		//products[i] = TruncateOr((float)products[i] / pow(2, mult_shift_bit));
		//io_printf("the shift value %f\n",(double)products[i] / pow(2, mult_shift_bit));
		products[i] = TruncateOr((double)products[i] / pow(2, mult_shift_bit));
		//products[i] = round((float)products[i] / pow(2, mult_shift_bit));
		//io_printf("products[%d] = %x\n",i,products[i]);
		// Overflow. Extend to 20 bit, so we use the EXTEND_L.
		if (products[i] >= pow(2, trun1))
			products[i] = pow(2, trun1) - 1;
		else if (products[i] < -pow(2, trun1))
			products[i] = -pow(2, trun1);

		//io_printf("products[%d] = %x\n",i,products[i]);
		
		//if (sign)
		//	products[i] = -products[i];
	}

	for (int j = 0; j < 14; j++) {
		result += products[j];
		

		// Overflow. Extend to 20 bit, so we use the EXTEND_L.
		if (result >= pow(2, trun1))
			result = pow(2, trun1) - 1;
		else if (result < -pow(2, trun1))
			result = -pow(2, trun1);

		//io_printf("result = %x\n",result);
	}
	/*if (is_print) {
		FILE* fid1 = fopen(".\\yolo_180525_c7\\kce_output\\mult_ifm.txt", "a");
		for (int k = 0; k < 14; k++) {
			int num = fake_ifm_buffer[k];
			if (num < 0)
				num = num + pow(2, 16);
			fprintf(fid1, "%04x\t", num);
		}
		fprintf(fid1, "\n");
		fclose(fid1);

		FILE* fid2 = fopen(".\\yolo_180525_c7\\kce_output\\mult_weight.txt", "a");
		for (int k = 0; k < 14; k++) {
			int num = weight_buffer[k];
			if (num < 0)
				num = num + pow(2, 16);
			fprintf(fid2, "%04x\t", num);
		}
		fprintf(fid2, "\n");
		fclose(fid2);



		FILE* fid = fopen(".\\yolo_180525_c7\\kce_output\\mult_result.txt", "a");
		for (int k = 0; k < 14; k++) {
			int num = products[k];
			if (num < 0)
				num = num + pow(2, 16);
			fprintf(fid, "%04x\t", num);
		}
		fprintf(fid, "\n");
		fclose(fid);
	}*/

	// Shift, avoid too much overflow.

	result = TruncateOr((float)result * pow(2, add_shift_bit));
	
	// Overflow
	if (result >= pow(2, trun2))
		result = pow(2, trun2) - 1;
	else if (result < -pow(2, trun2))
		result = -pow(2, trun2);

	//io_printf("result = %x\n",result);

	return result;
}