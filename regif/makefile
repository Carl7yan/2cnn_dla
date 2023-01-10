UVM_HOME = /opt/uvm/uvm-1.2

VERDI_HOME = /opt/synopsys/verdi2018/verdi/Verdi_O-2018.09-SP2

.PHONY : COMPILE

COMPILE :
	vcs -full64 -sverilog  -debug_all \
		-cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -lpthread \
		+incdir+$(UVM_HOME)/src+\
		+incdir+/home/carl/work/1projects/1In_CV/2cnn_dla/rtl/common/INC_global+ \
		+incdir+/home/carl/work/1projects/1In_CV/2cnn_dla/regif/reg_model/uvm_reg+ \
		+incdir+/home/carl/work/1projects/1In_CV/2cnn_dla/regif/reg_model/uvm_reg_block+ \
		 $(UVM_HOME)/src/uvm_pkg.sv  \
		 /home/carl/work/1projects/1In_CV/2cnn_dla/rtl/include/PKG_dla_regmap/PKG_dla_regmap.sv \
		 /home/carl/work/1projects/1In_CV/2cnn_dla/rtl/include/PKG_dla_typedef/PKG_dla_typedef.sv  \
		 /home/carl/work/1projects/1In_CV/2cnn_dla/regif/reg_field_pkg.sv \
		 /home/carl/work/1projects/1In_CV/2cnn_dla/regif/reg_block_pkg.sv \
		 /home/carl/work/1projects/1In_CV/2cnn_dla/regif/reg_model_pkg.sv \
		 /home/carl/work/1projects/1In_CV/2cnn_dla/regif/testbench_pkg.sv \
		 $(UVM_HOME)/src/dpi/uvm_dpi.cc \
 	 -P $(VERDI_HOME)/share/PLI/VCS/LINUXAMD64/novas.tab $(VERDI_HOME)/share/PLI/VCS/LINUXAMD64/pli.a\
   -CFLAGS -DVCS -cm tgl+fsm+line+branch+cond  -timescale=1ns/1ps -notice +error+30  -f filelist

.PHONY : SIMULATION

SIMULATION :
	./simv +UVM_TESTNAME=my_case1  -cm tgl+line+fsm+branch_cond +ERROR+30 -l uvm_test.log

.PHONY : URG

URG :
	urg -full64 -dir /home/carl/work/1projects/1In_CV/2cnn_dla/regif/simv.vdb -report coverage_report -format both

.PHONY : clean

clean :
	-rm tr_db.log ucli.key vc_hdrs.h tb.fsdb simv -r csrc simv.daidir simv.vdb coverage_report


