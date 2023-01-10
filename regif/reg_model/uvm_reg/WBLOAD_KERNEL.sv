`ifndef WBLOAD_KERNEL__SV
`define WBLOAD_KERNEL__SV

class WBLOAD_KERNEL extends uvm_reg;

    rand uvm_reg_field reg_wbload_kernel_kpe_cnt;
    rand uvm_reg_field reg_wbload_kernel_mask;

    covergroup value_cg;
        option.per_instance = 1;
        reg_wbload_kernel_kpe_cnt_cp: coverpoint reg_wbload_kernel_kpe_cnt.value[1 : 0];
        reg_wbload_kernel_mask_cp: coverpoint reg_wbload_kernel_mask.value[15 : 0];
    endgroup

    virtual function void build();
        reg_wbload_kernel_kpe_cnt = uvm_reg_field::type_id::create("reg_wbload_kernel_kpe_cnt");
        reg_wbload_kernel_mask = uvm_reg_field::type_id::create("reg_wbload_kernel_mask");
        reg_wbload_kernel_kpe_cnt.configure(this,2,28,"RW",0,2'b0,1,1,0);
        reg_wbload_kernel_mask.configure(this,16,0,"RW",0,16'b0,1,1,0);
    endfunction

    `uvm_object_utils(WBLOAD_KERNEL)

    function new(string name = "WBLOAD_KERNEL");
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