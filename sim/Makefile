.PHONY: build lib clean sim simc

mkfile_path := $(dir $(abspath $(firstword $(MAKEFILE_LIST))))

VSIM        ?= vsim
VSIM_FLAGS  = -gUSE_SDVT_SPI=0 -gUSE_SDVT_CPI=0 -gBAUDRATE=115200 \
		-gENABLE_DEV_DPI=0 -gLOAD_L2=JTAG -gUSE_SDVT_I2S=0

SVLIB	    =  ../rtl/tb/remote_bitbang/librbs

all: clean lib build opt

# build the bitbang library, needed for simulating a jtag bridge to OpenOCD
build-deps:
	@echo '************  original makefile build-deps ************'
	$(MAKE) -C ../rtl/tb/remote_bitbang all

clean-deps:
	@echo '************  original makefile clean-deps ************'
	$(MAKE) -C ../rtl/tb/remote_bitbang clean

sim:
	@echo '************  original makefile sim ************'
	$(VSIM) -64 -gui vopt_tb -L models_lib -L vip_lib \
		-suppress vsim-3009 -suppress vsim-8683 \
		+UVM_NO_RELNOTES -stats -t ps \
		-sv_lib $(SVLIB) $(VSIM_FLAGS) \
		-do "set StdArithNoWarnings 1; set NumericStdNoWarnings 1"

simc:
	@echo '************  original makefile simc ************'
	$(VSIM) -64 -c vopt_tb -L models_lib -L vip_lib \
		-suppress vsim-3009 -suppress vsim-8683 \
		+UVM_NO_RELNOTES -stats -t ps \
		-sv_lib $(SVLIB) $(VSIM_FLAGS) \
		-do "set StdArithNoWarnings 1; set NumericStdNoWarnings 1" \
		-do "run -all" \
		-do "quit -code [examine -radix decimal sim:/tb_pulp/exit_status]"

opt:
	@echo '************  original makefile opt ************'
	$(mkfile_path)/tcl_files/rtl_vopt.tcl

build: build-deps
	@echo '************  original makefile build ************'
	@make --no-print-directory -f $(mkfile_path)/vcompile/build.mk build
	#@make --no-print-directory -f $(mkfile_path)/vcompile/rtl.mk build

lib:
	@echo '************  original makefile lib ************'
	@make --no-print-directory -f $(mkfile_path)/vcompile/build.mk lib
	#@make --no-print-directory -f $(mkfile_path)/vcompile/rtl.mk lib

clean: clean-deps
	@echo '************  original makefile clean ************'
	@make --no-print-directory -f $(mkfile_path)/vcompile/build.mk clean
	#@make --no-print-directory -f $(mkfile_path)/vcompile/rtl.mk clean
