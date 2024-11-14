include $(DESIGN_CONFIG)

export RESULT_DIR = $(DESIGN_HOME)/results/$(DESIGN_NICKNAME)
export TB_DIR = $(DESIGN_HOME)/testbench/$(DESIGN_NICKNAME)
export VERILOG_DIR = $(DESIGN_HOME)/src/$(DESIGN_NICKNAME)

.PHONY: sim
sim:$(RESULT_DIR)/$(DESIGN_NAME).vcd show_gtkwave

$(RESULT_DIR)/$(DESIGN_NAME): $(VERILOG_DIR)/*.v $(TB_DIR)/$(DESIGN_NAME)_tb.sv $(TB_DIR)/grid_data.txt
	iverilog -o $(RESULT_DIR)/$(DESIGN_NAME) $(VERILOG_DIR)/*.v $(TB_DIR)/$(DESIGN_NAME)_tb.sv

$(RESULT_DIR)/$(DESIGN_NAME).vcd: $(RESULT_DIR)/$(DESIGN_NAME)
	vvp $(RESULT_DIR)/$(DESIGN_NAME) > $(RESULT_DIR)/$(DESIGN_NAME).log

.PHONY: show_gtkwave
show_gtkwave:
	gtkwave $(RESULT_DIR)/$(DESIGN_NAME).vcd $(RESULT_DIR)/$(DESIGN_NAME)_conf.gtkw