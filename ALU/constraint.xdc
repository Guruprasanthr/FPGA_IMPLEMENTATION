//switches
set_property -dict { PACKAGE_PIN L4    IOSTANDARD LVCMOS33 } [get_ports { a[0] }];
set_property -dict { PACKAGE_PIN M4    IOSTANDARD LVCMOS33 } [get_ports { a[1] }];
set_property -dict { PACKAGE_PIN M2    IOSTANDARD LVCMOS33 } [get_ports { a[2] }];
set_property -dict { PACKAGE_PIN M1    IOSTANDARD LVCMOS33 } [get_ports { a[3] }];

set_property -dict { PACKAGE_PIN N3    IOSTANDARD LVCMOS33 } [get_ports { b[0] }];
set_property -dict { PACKAGE_PIN N2    IOSTANDARD LVCMOS33 } [get_ports { b[1] }];
set_property -dict { PACKAGE_PIN N1    IOSTANDARD LVCMOS33 } [get_ports { b[2] }];
set_property -dict { PACKAGE_PIN P1    IOSTANDARD LVCMOS33 } [get_ports { b[3] }];

set_property -dict { PACKAGE_PIN P4    IOSTANDARD LVCMOS33 } [get_ports { op[0] }];
set_property -dict { PACKAGE_PIN T8    IOSTANDARD LVCMOS33 } [get_ports { op[1] }];
set_property -dict { PACKAGE_PIN R8    IOSTANDARD LVCMOS33 } [get_ports { op[2] }];

//leds
set_property -dict { PACKAGE_PIN J3    IOSTANDARD LVCMOS33 } [get_ports { y[0] }];
set_property -dict { PACKAGE_PIN H3    IOSTANDARD LVCMOS33 } [get_ports { y[1] }];
set_property -dict { PACKAGE_PIN J1    IOSTANDARD LVCMOS33 } [get_ports { y[2] }];
set_property -dict { PACKAGE_PIN K1    IOSTANDARD LVCMOS33 } [get_ports { y[3] }];
