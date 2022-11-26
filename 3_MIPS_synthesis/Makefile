VHDLDIR=VHDL
VHDLDIR_FETCH=VHDL/fetch_section
WORKDIR=WORK
VCDDIR=VCD
VECDIR=OUTVECS
MAIN=testBench
MAIN_FETCH=fetchBench
TIME="100ns"
#
GHDL=ghdl
GHDLFLAGS=--ieee=synopsys --std=08
GHDLRUNFLAGS=--vcd=$(MAIN).vcd --stop-time=$(TIME)

all: fetch

fetch: run_fetch
	echo "Done!"

run_fetch: elaboration_fetch
	$(GHDL) -c $(GHDLFLAGS) -r $(MAIN_FETCH) $(GHDLRUNFLAGS)
	mv $(MAIN_FETCH).vcd $(VCDDIR)
	mv *.cf $(WORKDIR)

elaboration_fetch : analysis_fetch
	$(GHDL) -c $(GHDLFLAGS) -e $(MAIN_FETCH)

analysis_fetch: clean_fetch
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR_FETCH)/adder.vhd
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR_FETCH)/instruction_memory.vhd
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR_FETCH)/program_counter.vhd
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR_FETCH)/vectorGenerator_fetch.vhd
	$(GHDL) -a $(GHDLFLAGS) $(VHDLDIR_FETCH)/$(MAIN_FETCH).vhd

clean_fetch: prepare_fetch
	@rm -f $(WORKDIR)/*.cf $(VCDDIR)/*.vcd *.cf *.vcd

prepare_fetch:
	mkdir -p $(WORKDIR)
	mkdir -p $(VCDDIR)
	mkdir -p $(VECDIR)