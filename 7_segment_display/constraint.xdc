set_property -dict { PACKAGE_PIN L5    IOSTANDARD LVCMOS33 } [get_ports { a[0] }];
set_property -dict { PACKAGE_PIN L4    IOSTANDARD LVCMOS33 } [get_ports { a[1] }];
set_property -dict { PACKAGE_PIN M4    IOSTANDARD LVCMOS33 } [get_ports { a[2] }];
set_property -dict { PACKAGE_PIN M2    IOSTANDARD LVCMOS33 } [get_ports { a[3] }];

set_property -dict { PACKAGE_PIN F2    IOSTANDARD LVCMOS33 } [get_ports {anode[0]}]; 
set_property -dict { PACKAGE_PIN E1    IOSTANDARD LVCMOS33 } [get_ports {anode[1]}];
set_property -dict { PACKAGE_PIN G5    IOSTANDARD LVCMOS33 } [get_ports {anode[2]}];
set_property -dict { PACKAGE_PIN G4    IOSTANDARD LVCMOS33 } [get_ports {anode[3]}];


set_property -dict { PACKAGE_PIN G2 IOSTANDARD LVCMOS33 } [get_ports {out[0]}]; #A
set_property -dict { PACKAGE_PIN G1 IOSTANDARD LVCMOS33 } [get_ports {out[1]}]; #B
set_property -dict { PACKAGE_PIN H5 IOSTANDARD LVCMOS33 } [get_ports {out[2]}]; #C
set_property -dict { PACKAGE_PIN H4 IOSTANDARD LVCMOS33 } [get_ports {out[3]}]; #D
set_property -dict { PACKAGE_PIN J5 IOSTANDARD LVCMOS33 } [get_ports {out[4]}]; #E
set_property -dict { PACKAGE_PIN J4 IOSTANDARD LVCMOS33 } [get_ports {out[5]}]; #F
set_property -dict { PACKAGE_PIN H2 IOSTANDARD LVCMOS33 } [get_ports {out[6]}]; #G

