`ifndef WBLOAD_CHANNEL__SV
`define WBLOAD_CHANNEL__SV

class WBLOAD_CHANNEL extends uvm_reg;

    rand uvm_reg_field reg_wbload_channel_idx;
    rand uvm_reg_field reg_wbload_channel_cnt;

    covergroup value_cg;
        option.per_instance = 1;
        reg_wbload_channel_idx_cp: coverpoint reg_wbload_channel_idx.value[3 : 0];
        reg_wbload_channel_cnt_cp: coverpoint reg_wbload_channel_cnt.value[3 : 0];
    endgroup

    virtual function void build();
        reg_wbload_channel_idx = uvm_reg_field::type_id::create("reg_wbload_channel_idx");
        reg_wbload_channel_cnt = uvm_reg_field::type_id::create("reg_wbload_channel_cnt");
        reg_wbload_channel_idx.configure(this,4,8,"RW",0,4'b0,1,1,0);
        reg_wbload_channel_cnt.configure(this,4,0,"RW",0,4'b0,1,1,0);
    endfunction

    `uvm_object_utils(WBLOAD_CHANNEL)

    function new(string name = "WBLOAD_CHANNEL");
        super.new(name,32,UVM_CVR_ALL);
        set_coverage(UVM_CVR_FIELD_VALS);
        if(has_coverage(UVM_CVR_FIELD_VALS)) begin
            value_cg = new();
        end
    endfunction

    function void sample(
                         uvm_reg_data_t data,
                         uvm_reg_data_t byte_en,
                         bit            is_read,
                         uvm_reg_map    map);
        super.sample(data,byte_en,is_read,map);
        sample_values();
    endfunction

    function void sample_values();
        super.sample_values();
        if(get_coverage(UVM_CVR_FIELD_VALS)) begin
            value_cg.sample();
        end
    endfunction

endclass
`endif 