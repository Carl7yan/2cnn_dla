#include <svdpi.h>
#include <stdbool.h>
#include <veriuser.h>


void kpe_algorithm(
                   svLogicVecVal * kpe_sum,
                   const svLogicVecVal  kpe_ifmap[14],
                   const svLogicVecVal  kpe_weight[14],
                   const svLogicVecVal* stgr_precision_kpe_shift,
                   const svLogic stgr_precision_ifmap,
                   const svLogicVecVal* stgr_precision_weight
                   )
                   
{
    static short int final_sum = 0;
    short int ifmap_sh[14] , weight_sh[14];
    int  ifmap_lg[14] , weight_lg[14],ifmap_lg2[14];

    char tmp1[14],tmp2[14];
    char tmp3,tmp4;

        for(int j = 0; j < 14; j++)
        {
            ifmap_sh[j] = kpe_ifmap[j].aval;
            ifmap_lg[j] = ifmap_sh[j];
            weight_sh[j] = kpe_weight[j].aval;
            weight_lg[j] = weight_sh[j];
            
        }


        if((stgr_precision_ifmap == 0) && ((stgr_precision_weight -> aval) == 0))
        {
            final_sum =  KCEConvMacOperation(ifmap_lg, weight_lg, stgr_precision_kpe_shift -> aval, 23, 15, 0, 1);
        }
        else if((stgr_precision_ifmap == 1) && ((stgr_precision_weight -> aval) == 1))
        {
            for(int i = 0; i < 14; i++)
            {
                tmp1[i] = ifmap_sh[i];
                ifmap_lg[i] = tmp1[i];
                tmp2[i] = ifmap_sh[i] >> 8;
                ifmap_lg2[i] = tmp2[i];
                //io_printf("tmp[%d] = %x, tmp[%d] = %x \n",i,tmp1[i],i,tmp2[i]);
            }
            tmp3 = KCEConvMacOperation(ifmap_lg, weight_lg, stgr_precision_kpe_shift -> aval, 11, 7, 0, 1);
            tmp4 = KCEConvMacOperation(ifmap_lg2, weight_lg, stgr_precision_kpe_shift -> aval, 11, 7, 0, 1);

            final_sum = tmp3;
            final_sum = final_sum & 0x00ff;
            final_sum = final_sum + (short int)(tmp4 << 8);

        }

        kpe_sum -> aval = final_sum;
        kpe_sum -> bval = 0;
}
