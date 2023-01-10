`ifndef CONV_PAD_SIZE__SV
`define CONV_PAD_SIZE__SV

class CONV_PAD_SIZE extends uvm_reg;
    rand uvm_reg_field reg_conv_pad_size_pad_up;
    rand uvm_reg_field reg_conv_pad_size_pad_down;
    rand uvm_reg_field reg_conv_pad_size_pad_left;
    rand uvm_reg_field reg_conv_pad_size_pad_right;

    covergroup value_cg;
        option.per_instance = 1;
        reg_conv_pad_size_pad_up_cp: coverpoint reg_conv_pad_size_pad_up.value[3 : 0];
        reg_conv_pad_size_pad_down_cp: coverpoint reg_conv_pad_size_pad_down.value[3 : 0];
        reg_conv_pad_size_pad_left_cp: coverpoint reg_conv_pad_size_pad_left.value[3 : 0];
        reg_conv_pad_size_pad_right_cp: coverpoint reg_conv_pad_size_pad_right.value[3 : 0];
    endgroup

    virtual function void build();
        reg_conv_pad_size_pad_up = uvm_reg_field::type_id::create("reg_conv_pad_size_pad_up");
        reg_conv_pad_size_pad_down = uvm_reg_field::type_id::create("reg_conv_pad_size_pad_down");
        reg_conv_pad_size_pad_left = uvm_reg_field::type_id::create("reg_conv_pad_size_pad_left");
        reg_conv_pad_size_pad_right = uvm_reg_field::type_id::create("reg_conv_pad_size_pad_right");
        reg_conv_pad_size_pad_up.configure(this,4,24,"RW",0,4'b0,1,1,0);
        reg_conv_pad_size_pad_down.configure(this,4,16,"RW",0,4'b0,1,1,0);
        reg_conv_pad_size_pad_left.configure(this,4,8,"RW",0,4'b0,1,1,0);
        reg_conv_pad_size_pad_right.configure(this,4,0,"RW",0,4'b0,1,1,0);
    endfunction

    `uvm_object_utils(CONV_PAD_SIZE)

    function new(string name = "CONV_PAD_SIZE");
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