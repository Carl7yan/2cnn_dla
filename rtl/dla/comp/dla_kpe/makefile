UVM_HOME = /opt/uvm/uvm-1.2

VERDI_HOME = /opt/synopsys/verdi2018/verdi/Verdi_O-2018.09-SP2


.PHONY : COMPILE
COMPILE:
	vcs -full64 \
		-cpp g++-4.8 -cc gcc-4.8 -LDFLAGS -Wl,--no-as-needed -lpthread \
		-sverilog -debug_all -timescale=1ns/1ps \
		+incdir+$(UVM_HOME)/src+/home/carl/work/1projects/1In_CV/2cnn_dla/rtl/common/INC_global \
		$(UVM_HOME)/src/uvm_pkg.sv \
		$(UVM_HOME)/src/dpi/uvm_dpi.cc \
		/home/carl/work/1projects/1In_CV/2cnn_dla/rtl/include/PKG_dla_typedef/PKG_dla_typedef.sv \
		/home/carl/work/1projects/1In_CV/2cnn_dla/rtl/include/PKG_dla_regmap/PKG_dla_regmap.sv \
		/home/carl/work/1projects/1In_CV/2cnn_dla/rtl/dla/comp/dla_kpe/testbench_pkg.sv \
		-P  $(VERDI_HOME)/share/PLI/VCS/LINUXAMD64/novas.tab \
		$(VERDI_HOME)/share/PLI/VCS/LINUXAMD64/pli.a  \
		-CFLAGS -DVCS -cm tgl+fsm+line   -f filelist  libgen1.so

.PHONY : SIMULATION
SIMULATION:
	./simv +UVM_TESTNAME=my_case  -cm tgl+line+fsm +ERROR+30 -l uvm_test.log

.PHONY : C_COMPILE
C_COMPILE :
	gcc  -w -pipe -fPIC -std=c99 -shared  -o libgen1.so  kpe_algorithm.c KCEConvMacOperation.c dataset.c -I /usr/include -I /usr/local/include -I /opt/Synopsys/VCS2018/vcs/O-2018.09-SP2/includeVCS_installed/include

.PHONY : urg
URG :
	urg -full64 -dir /home/carl/work/1projects/1In_CV/2cnn_dla/rtl/dla/comp/dla_kpe/simv.vdb -report coverage_report -format both


.PHONY : cn
cn:
	-rm tr_db.log ucli.key vc_hdrs.h tb.fsdb simv -r csrc simv.daidir simv.vdb coverage_report *~ core *csrc vc_hdrs.h ucli.key urg* *.log  *csrc ./*.daidir  *simv* DVE* ucli* *.vpd *.vdb *.log *.fsdb *novas* *.dat *Log *rc *conf

