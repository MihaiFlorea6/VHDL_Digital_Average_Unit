##-----------------------------------------------------------------
## Project: Digital Average Unit
## Author: Mihai Florea
## File: Nexys-A7-100T-Master.xdc
## Description: Port mapping for refactored Top Level entity.
##-----------------------------------------------------------------

## Clock signal (100MHz)
set_property -dict { PACKAGE_PIN E3    IOSTANDARD LVCMOS33 } [get_ports { i_clk_nexys }]; 
create_clock -add -name sys_clk_pin -period 10.00 -waveform {0 5} [get_ports { i_clk_nexys }];

## Switches for Control [2:0] (SW0 - SW2)
set_property -dict { PACKAGE_PIN J15    IOSTANDARD LVCMOS33 } [get_ports { i_control[0] }]; 
set_property -dict { PACKAGE_PIN L16    IOSTANDARD LVCMOS33 } [get_ports { i_control[1] }]; 
set_property -dict { PACKAGE_PIN M13    IOSTANDARD LVCMOS33 } [get_ports { i_control[2] }]; 

## Switches for Length [2:0] (SW3 - SW5)
set_property -dict { PACKAGE_PIN R15    IOSTANDARD LVCMOS33 } [get_ports { i_length[0] }]; 
set_property -dict { PACKAGE_PIN R17    IOSTANDARD LVCMOS33 } [get_ports { i_length[1] }]; 
set_property -dict { PACKAGE_PIN T18    IOSTANDARD LVCMOS33 } [get_ports { i_length[2] }]; 

## 7 Segment Display - Cathodes (Active Low)
set_property -dict { PACKAGE_PIN T10    IOSTANDARD LVCMOS33 } [get_ports { o_seg[0] }]; # ca
set_property -dict { PACKAGE_PIN R10    IOSTANDARD LVCMOS33 } [get_ports { o_seg[1] }]; # cb
set_property -dict { PACKAGE_PIN K16    IOSTANDARD LVCMOS33 } [get_ports { o_seg[2] }]; # cc
set_property -dict { PACKAGE_PIN K13    IOSTANDARD LVCMOS33 } [get_ports { o_seg[3] }]; # cd
set_property -dict { PACKAGE_PIN P15    IOSTANDARD LVCMOS33 } [get_ports { o_seg[4] }]; # ce
set_property -dict { PACKAGE_PIN T11    IOSTANDARD LVCMOS33 } [get_ports { o_seg[5] }]; # cf
set_property -dict { PACKAGE_PIN L18    IOSTANDARD LVCMOS33 } [get_ports { o_seg[6] }]; # cg

## 7 Segment Display - Anodes (Active Low)
set_property -dict { PACKAGE_PIN J17    IOSTANDARD LVCMOS33 } [get_ports { o_an[0] }]; 
set_property -dict { PACKAGE_PIN J18    IOSTANDARD LVCMOS33 } [get_ports { o_an[1] }]; 
set_property -dict { PACKAGE_PIN T9     IOSTANDARD LVCMOS33 } [get_ports { o_an[2] }]; 
set_property -dict { PACKAGE_PIN J14    IOSTANDARD LVCMOS33 } [get_ports { o_an[3] }]; 
set_property -dict { PACKAGE_PIN P14    IOSTANDARD LVCMOS33 } [get_ports { o_an[4] }]; 
set_property -dict { PACKAGE_PIN T14    IOSTANDARD LVCMOS33 } [get_ports { o_an[5] }]; 
set_property -dict { PACKAGE_PIN K2     IOSTANDARD LVCMOS33 } [get_ports { o_an[6] }]; 
set_property -dict { PACKAGE_PIN U13    IOSTANDARD LVCMOS33 } [get_ports { o_an[7] }]; 

## Buttons - CPU Reset (Central Button)
set_property -dict { PACKAGE_PIN N17    IOSTANDARD LVCMOS33 } [get_ports { i_reset }]; # btnc