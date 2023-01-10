`ifndef DRIVER_CBS_COVERAGE__SV
`define DRIVER_CBS_COVERAGE__SV

class driver_cbs_coverage extends driver_cbs;
    
    logic enable;
    logic [15 : 0] kpe_ifmap;
    logic [15 : 0] kpe_weight;
    
    logic ctrl_kpe_src0_enable;
    logic ctrl_kpe_src1_enable;
    logic ctrl_kpe_mul_enable;
    logic ctrl_kpe_acc_enable;
    logic ctrl_kpe_acc_rst;
    logic ctrl_kpe_bypass;
    logic[3 : 0] stgr_precision_kpe_shift;
    precision_ifmap_e stgr_precision_ifmap;
    precision_weight_e stgr_precision_weight;

    covergroup covport();
        //option.per_instance = 1;
        enable:coverpoint  enable
        {bins enable[] = {[0 : 1]};}
        coverpoint  kpe_ifmap
            {option.auto_bin_max = 16;}
        coverpoint  kpe_weight
            {option.auto_bin_max = 16;}
        coverpoint  ctrl_kpe_src0_enable;
        coverpoint  ctrl_kpe_src1_enable;
        coverpoint  ctrl_kpe_mul_enable;
        coverpoint  ctrl_kpe_acc_enable;
        coverpoint  ctrl_kpe_acc_rst;
        coverpoint  ctrl_kpe_bypass
            {bins ctrl_kpe_bypass[] = {[0 : 1]};}
        stgr_precision_kpe_shift:coverpoint  stgr_precision_kpe_shift
            {bins stgr_precision_kpe_shift[] = {[0 : 12]};}
        stgr_precision_ifmap:coverpoint  stgr_precision_ifmap
            {bins stgr_precision_ifmap[] = {[0 : 1]};}
        stgr_precision_weight:coverpoint  stgr_precision_weight
            {bins stgr_precision_weight[] = {[0 : 1]};}

         cross stgr_precision_ifmap,stgr_precision_weight;
         cross stgr_precision_ifmap,stgr_precision_kpe_shift
                {
                    ignore_bins l1 = binsof(stgr_precision_ifmap) intersect{1} &&
                                        binsof(stgr_precision_kpe_shift) intersect{[9 : 12]} ;
                }
         cross stgr_precision_weight,stgr_precision_kpe_shift
                {
                    ignore_bins l2 = binsof(stgr_precision_kpe_shift)intersect{[9 : 12]} &&
                                                            binsof(stgr_precision_weight)intersect{1};
                }
    endgroup

    function new();
        covport = new();
    endfunction

    virtual task pre_tx(ref virtual ini_if ii = null);
        this.enable = ii.enable;
        this.kpe_ifmap = ii.kpe_ifmap;
        this.kpe_weight = ii.kpe_weight;
        this.ctrl_kpe_src0_enable = ii.ctrl_kpe_src0_enable;
        this.ctrl_kpe_src1_enable = ii.ctrl_kpe_src1_enable;
        this.ctrl_kpe_mul_enable = ii.ctrl_kpe_mul_enable;
        this.ctrl_kpe_acc_enable = ii.ctrl_kpe_acc_enable;
        this.ctrl_kpe_acc_rst = ii.ctrl_kpe_acc_rst;
        this.ctrl_kpe_bypass = ii.ctrl_kpe_bypass;
        this.stgr_precision_kpe_shift = ii.stgr_precision_kpe_shift;
        this.stgr_precision_ifmap = ii.stgr_precision_ifmap;
        this.stgr_precision_weight = ii.stgr_precision_weight;

        covport.sample();
    endtask

endclass
`endif 