# Clock
set_property -dict { PACKAGE_PIN N11 IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -add -name sys_clk -period 20.00 [get_ports { clk }];

# Reset
set_property -dict { PACKAGE_PIN M14 IOSTANDARD LVCMOS33 PULLDOWN true } [get_ports { reset }];

# North — lights[11]=green  [10]=yellow  [9]=red
set_property -dict { PACKAGE_PIN J3 IOSTANDARD LVCMOS33 } [get_ports { lights[11] }];
set_property -dict { PACKAGE_PIN H3 IOSTANDARD LVCMOS33 } [get_ports { lights[10] }];
set_property -dict { PACKAGE_PIN J1 IOSTANDARD LVCMOS33 } [get_ports { lights[9]  }];

# East — lights[8]=green  [7]=yellow  [6]=red
set_property -dict { PACKAGE_PIN K1 IOSTANDARD LVCMOS33 } [get_ports { lights[8] }];
set_property -dict { PACKAGE_PIN L3 IOSTANDARD LVCMOS33 } [get_ports { lights[7] }];
set_property -dict { PACKAGE_PIN L2 IOSTANDARD LVCMOS33 } [get_ports { lights[6] }];

# South — lights[5]=green  [4]=yellow  [3]=red
set_property -dict { PACKAGE_PIN K3 IOSTANDARD LVCMOS33 } [get_ports { lights[5] }];
set_property -dict { PACKAGE_PIN K2 IOSTANDARD LVCMOS33 } [get_ports { lights[4] }];
set_property -dict { PACKAGE_PIN K5 IOSTANDARD LVCMOS33 } [get_ports { lights[3] }];

# West — lights[2]=green  [1]=yellow  [0]=red
set_property -dict { PACKAGE_PIN P6 IOSTANDARD LVCMOS33 } [get_ports { lights[2] }];
set_property -dict { PACKAGE_PIN R7 IOSTANDARD LVCMOS33 } [get_ports { lights[1] }];
set_property -dict { PACKAGE_PIN R6 IOSTANDARD LVCMOS33 } [get_ports { lights[0] }];
