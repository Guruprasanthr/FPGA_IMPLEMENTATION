
# ── Clock (onboard oscillator) ────────────────────────────
set_property -dict { PACKAGE_PIN N11  IOSTANDARD LVCMOS33 } [get_ports { clk }];
create_clock -period 10.000 -name sys_clk [get_ports { clk }];

# ── Reset → pb[4] center button ──────────────────────────
set_property -dict { PACKAGE_PIN M14  IOSTANDARD LVCMOS33  PULLDOWN true } [get_ports { rst }];

# ── Enter → pb[0] top button ─────────────────────────────
set_property -dict { PACKAGE_PIN K13  IOSTANDARD LVCMOS33  PULLDOWN true } [get_ports { enter }];

# ── Password input → sw[3:0] ──────────────────────────────
set_property -dict { PACKAGE_PIN L5   IOSTANDARD LVCMOS33 } [get_ports { sw[0] }];
set_property -dict { PACKAGE_PIN L4   IOSTANDARD LVCMOS33 } [get_ports { sw[1] }];
set_property -dict { PACKAGE_PIN M4   IOSTANDARD LVCMOS33 } [get_ports { sw[2] }];
set_property -dict { PACKAGE_PIN M2   IOSTANDARD LVCMOS33 } [get_ports { sw[3] }];

# ── Door open indicator → led[0] ─────────────────────────
set_property -dict { PACKAGE_PIN J3   IOSTANDARD LVCMOS33 } [get_ports { op }];

# ── Error indicator → led[1] ─────────────────────────────
set_property -dict { PACKAGE_PIN H3   IOSTANDARD LVCMOS33 } [get_ports { err }];
