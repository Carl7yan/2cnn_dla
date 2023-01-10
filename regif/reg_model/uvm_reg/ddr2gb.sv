`ifndef DDR2GB__SV
`define DDR2GB__SV

import uvm_pkg::*;

class ral_reg_regmodel_DDR2GB_DDR2GB_CTRL1 extends uvm_reg;
	rand uvm_reg_field reg_ddr2gb_ctrl_dir;

	function new(string name = "regmodel_DDR2GB_DDR2GB_CTRL1");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.reg_ddr2gb_ctrl_dir = uvm_reg_field::type_id::create("reg_ddr2gb_ctrl_dir",,get_full_name());
      this.reg_ddr2gb_ctrl_dir.configure(this, 1, 0, "RW", 0, 1'h1, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_regmodel_DDR2GB_DDR2GB_CTRL1)

endclass : ral_reg_regmodel_DDR2GB_DDR2GB_CTRL1


class ral_reg_regmodel_DDR2GB_DDR2GB_DDR_ADDR01 extends uvm_reg;
	rand uvm_reg_field reg_ddr2gb_addr0_laddr;

	function new(string name = "regmodel_DDR2GB_DDR2GB_DDR_ADDR01");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.reg_ddr2gb_addr0_laddr = uvm_reg_field::type_id::create("reg_ddr2gb_addr0_laddr",,get_full_name());
      this.reg_ddr2gb_addr0_laddr.configure(this, 32, 0, "RW", 0, 32'h20, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_regmodel_DDR2GB_DDR2GB_DDR_ADDR01)

endclass : ral_reg_regmodel_DDR2GB_DDR2GB_DDR_ADDR01


class ral_reg_regmodel_DDR2GB_DDR2GB_DDR_ADDR11 extends uvm_reg;
	rand uvm_reg_field reg_ddr2gb_addr1_haddr;

	function new(string name = "regmodel_DDR2GB_DDR2GB_DDR_ADDR11");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.reg_ddr2gb_addr1_haddr = uvm_reg_field::type_id::create("reg_ddr2gb_addr1_haddr",,get_full_name());
      this.reg_ddr2gb_addr1_haddr.configure(this, 22, 0, "RW", 0, 22'h16, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_regmodel_DDR2GB_DDR2GB_DDR_ADDR11)

endclass : ral_reg_regmodel_DDR2GB_DDR2GB_DDR_ADDR11


class ral_reg_regmodel_DDR2GB_DDR2GB_GB_ADDR1 extends uvm_reg;
	rand uvm_reg_field reg_ddr2gb_gbaddr_addr;
	rand uvm_reg_field reg_ddr2gb_gbaddr_ab_sel;
	rand uvm_reg_field reg_ddr2gb_gbaddr_ram_idx;
	rand uvm_reg_field reg_ddr2gb_gbaddr_len;

	function new(string name = "regmodel_DDR2GB_DDR2GB_GB_ADDR1");
		super.new(name, 32,build_coverage(UVM_NO_COVERAGE));
	endfunction: new
   virtual function void build();
      this.reg_ddr2gb_gbaddr_addr = uvm_reg_field::type_id::create("reg_ddr2gb_gbaddr_addr",,get_full_name());
      this.reg_ddr2gb_gbaddr_addr.configure(this, 13, 0, "RW", 0, 13'hd, 1, 0, 0);
      this.reg_ddr2gb_gbaddr_ab_sel = uvm_reg_field::type_id::create("reg_ddr2gb_gbaddr_ab_sel",,get_full_name());
      this.reg_ddr2gb_gbaddr_ab_sel.configure(this, 1, 13, "RW", 0, 1'h1, 1, 0, 0);
      this.reg_ddr2gb_gbaddr_ram_idx = uvm_reg_field::type_id::create("reg_ddr2gb_gbaddr_ram_idx",,get_full_name());
      this.reg_ddr2gb_gbaddr_ram_idx.configure(this, 4, 20, "RW", 0, 4'h4, 1, 0, 1);
      this.reg_ddr2gb_gbaddr_len = uvm_reg_field::type_id::create("reg_ddr2gb_gbaddr_len",,get_full_name());
      this.reg_ddr2gb_gbaddr_len.configure(this, 8, 24, "RW", 0, 8'h8, 1, 0, 1);
   endfunction: build

	`uvm_object_utils(ral_reg_regmodel_DDR2GB_DDR2GB_GB_ADDR1)

endclass : ral_reg_regmodel_DDR2GB_DDR2GB_GB_ADDR1


class DDR2GB extends uvm_reg_block;
	rand ral_reg_regmodel_DDR2GB_DDR2GB_CTRL1 DDR2GB_CTRL1;
	rand ral_reg_regmodel_DDR2GB_DDR2GB_DDR_ADDR01 DDR2GB_DDR_ADDR01;
	rand ral_reg_regmodel_DDR2GB_DDR2GB_DDR_ADDR11 DDR2GB_DDR_ADDR11;
	rand ral_reg_regmodel_DDR2GB_DDR2GB_GB_ADDR1 DDR2GB_GB_ADDR1;
	rand uvm_reg_field DDR2GB_CTRL1_reg_ddr2gb_ctrl_dir;
	rand uvm_reg_field reg_ddr2gb_ctrl_dir;
	rand uvm_reg_field DDR2GB_DDR_ADDR01_reg_ddr2gb_addr0_laddr;
	rand uvm_reg_field reg_ddr2gb_addr0_laddr;
	rand uvm_reg_field DDR2GB_DDR_ADDR11_reg_ddr2gb_addr1_haddr;
	rand uvm_reg_field reg_ddr2gb_addr1_haddr;
	rand uvm_reg_field DDR2GB_GB_ADDR1_reg_ddr2gb_gbaddr_addr;
	rand uvm_reg_field reg_ddr2gb_gbaddr_addr;
	rand uvm_reg_field DDR2GB_GB_ADDR1_reg_ddr2gb_gbaddr_ab_sel;
	rand uvm_reg_field reg_ddr2gb_gbaddr_ab_sel;
	rand uvm_reg_field DDR2GB_GB_ADDR1_reg_ddr2gb_gbaddr_ram_idx;
	rand uvm_reg_field reg_ddr2gb_gbaddr_ram_idx;
	rand uvm_reg_field DDR2GB_GB_ADDR1_reg_ddr2gb_gbaddr_len;
	rand uvm_reg_field reg_ddr2gb_gbaddr_len;

	function new(string name = "DDR2GB");
		super.new(name, build_coverage(UVM_NO_COVERAGE));
	endfunction: new

   virtual function void build();
      this.default_map = create_map("", 0, 4, UVM_LITTLE_ENDIAN, 0);
      this.DDR2GB_CTRL1 = ral_reg_regmodel_DDR2GB_DDR2GB_CTRL1::type_id::create("DDR2GB_CTRL1",,get_full_name());
      this.DDR2GB_CTRL1.configure(this, null, "");
      this.DDR2GB_CTRL1.build();
      this.default_map.add_reg(this.DDR2GB_CTRL1, `UVM_REG_ADDR_WIDTH'h10, "RW", 0);
		this.DDR2GB_CTRL1_reg_ddr2gb_ctrl_dir = this.DDR2GB_CTRL1.reg_ddr2gb_ctrl_dir;
		this.reg_ddr2gb_ctrl_dir = this.DDR2GB_CTRL1.reg_ddr2gb_ctrl_dir;
      this.DDR2GB_DDR_ADDR01 = ral_reg_regmodel_DDR2GB_DDR2GB_DDR_ADDR01::type_id::create("DDR2GB_DDR_ADDR01",,get_full_name());
      this.DDR2GB_DDR_ADDR01.configure(this, null, "");
      this.DDR2GB_DDR_ADDR01.build();
      this.default_map.add_reg(this.DDR2GB_DDR_ADDR01, `UVM_REG_ADDR_WIDTH'h11, "RW", 0);
		this.DDR2GB_DDR_ADDR01_reg_ddr2gb_addr0_laddr = this.DDR2GB_DDR_ADDR01.reg_ddr2gb_addr0_laddr;
		this.reg_ddr2gb_addr0_laddr = this.DDR2GB_DDR_ADDR01.reg_ddr2gb_addr0_laddr;
      this.DDR2GB_DDR_ADDR11 = ral_reg_regmodel_DDR2GB_DDR2GB_DDR_ADDR11::type_id::create("DDR2GB_DDR_ADDR11",,get_full_name());
      this.DDR2GB_DDR_ADDR11.configure(this, null, "");
      this.DDR2GB_DDR_ADDR11.build();
      this.default_map.add_reg(this.DDR2GB_DDR_ADDR11, `UVM_REG_ADDR_WIDTH'h12, "RW", 0);
		this.DDR2GB_DDR_ADDR11_reg_ddr2gb_addr1_haddr = this.DDR2GB_DDR_ADDR11.reg_ddr2gb_addr1_haddr;
		this.reg_ddr2gb_addr1_haddr = this.DDR2GB_DDR_ADDR11.reg_ddr2gb_addr1_haddr;
      this.DDR2GB_GB_ADDR1 = ral_reg_regmodel_DDR2GB_DDR2GB_GB_ADDR1::type_id::create("DDR2GB_GB_ADDR1",,get_full_name());
      this.DDR2GB_GB_ADDR1.configure(this, null, "");
      this.DDR2GB_GB_ADDR1.build();
      this.default_map.add_reg(this.DDR2GB_GB_ADDR1, `UVM_REG_ADDR_WIDTH'h13, "RW", 0);
		this.DDR2GB_GB_ADDR1_reg_ddr2gb_gbaddr_addr = this.DDR2GB_GB_ADDR1.reg_ddr2gb_gbaddr_addr;
		this.reg_ddr2gb_gbaddr_addr = this.DDR2GB_GB_ADDR1.reg_ddr2gb_gbaddr_addr;
		this.DDR2GB_GB_ADDR1_reg_ddr2gb_gbaddr_ab_sel = this.DDR2GB_GB_ADDR1.reg_ddr2gb_gbaddr_ab_sel;
		this.reg_ddr2gb_gbaddr_ab_sel = this.DDR2GB_GB_ADDR1.reg_ddr2gb_gbaddr_ab_sel;
		this.DDR2GB_GB_ADDR1_reg_ddr2gb_gbaddr_ram_idx = this.DDR2GB_GB_ADDR1.reg_ddr2gb_gbaddr_ram_idx;
		this.reg_ddr2gb_gbaddr_ram_idx = this.DDR2GB_GB_ADDR1.reg_ddr2gb_gbaddr_ram_idx;
		this.DDR2GB_GB_ADDR1_reg_ddr2gb_gbaddr_len = this.DDR2GB_GB_ADDR1.reg_ddr2gb_gbaddr_len;
		this.reg_ddr2gb_gbaddr_len = this.DDR2GB_GB_ADDR1.reg_ddr2gb_gbaddr_len;
   endfunction : build

	`uvm_object_utils(DDR2GB)

endclass : DDR2GB


/*
class ral_sys_regmodel extends uvm_reg_block;

   rand ral_block_regmodel_DDR2GB DDR2GB;

	function new(string name = "regmodel");
		super.new(name);
	endfunction: new

	function void build();
      this.default_map = create_map("", 0, 4, UVM_LITTLE_ENDIAN, 0);
      this.DDR2GB = ral_block_regmodel_DDR2GB::type_id::create("DDR2GB",,get_full_name());
      this.DDR2GB.configure(this, "");
      this.DDR2GB.build();
      this.default_map.add_submap(this.DDR2GB.default_map, `UVM_REG_ADDR_WIDTH'h1000);
	endfunction : build

	`uvm_object_utils(ral_sys_regmodel)
endclass : ral_sys_regmodel
*/



`endif
