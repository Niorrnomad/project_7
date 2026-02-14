# ----------------------------------------------------------------------------
#  File Name:    VC707_constraints.xdc
#  Version:      1.0
#  Date:         2024-05-03
#  Description:  Constraints file for the Xilinx VC707 Evaluation Board
#                with the Virtex-7 XC7VX485T FPGA.
#  Author:         Gemini
#  Generated from: ug885_VC707_Eval_Bd (1).pdf
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
#  DDR3 Memory Constraints
# ----------------------------------------------------------------------------
# SODIMM DDR3 Bank 34
set_property IOSTANDARD SSTL15 [get_ports {DDR3_A[*]}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_BA[*]}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_CAS_B}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_CKE}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_CLK_P}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_CLK_N}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_CS_B}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_DM[*]}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_DQ[*]}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_DQS[*]}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_DQS_N[*]}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_ODT}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_RAS_B}]
set_property IOSTANDARD SSTL15 [get_ports {DDR3_WE_B}]

# Clock constraint for DDR3
create_clock -name clk_ddr3 -period 1.25 [get_ports DDR3_CLK_P]  # Example: 800 MHz (1/0.8e-9)

# ----------------------------------------------------------------------------
#  USB ULPI Constraints
# ----------------------------------------------------------------------------
set_property IOSTANDARD LVCMOS18 [get_ports {USB_SMSC_DATA[*]}]
set_property IOSTANDARD LVCMOS18 [get_ports USB_SMSC_NXT]
set_property IOSTANDARD LVCMOS18 [get_ports USB_SMSC_RESET_B]
set_property IOSTANDARD LVCMOS18 [get_ports USB_SMSC_STP]
set_property IOSTANDARD LVCMOS18 [get_ports USB_SMSC_DIR]
set_property IOSTANDARD LVCMOS18 [get_ports USB_SMSC_REFCLK_OPTION]
set_property IOSTANDARD LVCMOS18 [get_ports USB_SMSC_CLKOUT]

# Clock constraint for USB ULPI
create_clock -name clk_usb_ref -period 40  [get_ports USB_SMSC_CLKOUT] # Example 25MHz

# ----------------------------------------------------------------------------
#  System Clock Constraints
# ----------------------------------------------------------------------------
# System clock (200 MHz)
create_clock -name sys_clk -period 5.00 [get_ports SYSCLK_P]
set_property IOSTANDARD LVDS [get_ports SYSCLK_P]
set_property IOSTANDARD LVDS [get_ports SYSCLK_N]

# I2C Programmable User Clock
create_clock -name user_clk -period 6.4 [get_ports USERCLK_P]
set_property IOSTANDARD LVDS [get_ports USERCLK_P]
set_property IOSTANDARD LVDS [get_ports USERCLK_N]

# ----------------------------------------------------------------------------
#  LCD Character Display Constraints
# ----------------------------------------------------------------------------
set_property IOSTANDARD LVCMOS18 [get_ports {LCD_D[*]}]
set_property IOSTANDARD LVCMOS18 [get_ports LCD_E]
set_property IOSTANDARD LVCMOS18 [get_ports LCD_RS]
set_property IOSTANDARD LVCMOS18 [get_ports LCD_RW]

# ----------------------------------------------------------------------------
#  FPGA Pin Location Constraints ( सॉल्व UCIO-1)
#  Replace these with *actual* pin locations from the VC707 user guide!
# ----------------------------------------------------------------------------
set_property -dict { PACKAGE_PIN "AF16" IOSTANDARD LVCMOS18 } [get_ports ADDRA[0]]
set_property -dict { PACKAGE_PIN "AE16" IOSTANDARD LVCMOS18 } [get_ports ADDRA[1]]
set_property -dict { PACKAGE_PIN "AD14" IOSTANDARD LVCMOS18 } [get_ports ADDRA[2]]
set_property -dict { PACKAGE_PIN "AC14" IOSTANDARD LVCMOS18 } [get_ports ADDRA[3]]
set_property -dict { PACKAGE_PIN "AB15" IOSTANDARD LVCMOS18 } [get_ports ADDRA[4]]

set_property -dict { PACKAGE_PIN "AA15" IOSTANDARD LVCMOS18 } [get_ports ADDRB[0]]
set_property -dict { PACKAGE_PIN "Y14" IOSTANDARD LVCMOS18 } [get_ports ADDRB[1]]
set_property -dict { PACKAGE_PIN "W14" IOSTANDARD LVCMOS18 } [get_ports ADDRB[2]]
set_property -dict { PACKAGE_PIN "V15" IOSTANDARD LVCMOS18 } [get_ports ADDRB[3]]
set_property -dict { PACKAGE_PIN "V16" IOSTANDARD LVCMOS18 } [get_ports ADDRB[4]]

set_property -dict { PACKAGE_PIN "AB22" IOSTANDARD LVCMOS18 } [get_ports DINA[0]]
set_property -dict { PACKAGE_PIN "AC22" IOSTANDARD LVCMOS18 } [get_ports DINA[1]]
set_property -dict { PACKAGE_PIN "AD21" IOSTANDARD LVCMOS18 } [get_ports DINA[2]]
set_property -dict { PACKAGE_PIN "AD22" IOSTANDARD LVCMOS18 } [get_ports DINA[3]]
set_property -dict { PACKAGE_PIN "AE21" IOSTANDARD LVCMOS18 } [get_ports DINA[4]]
set_property -dict { PACKAGE_PIN "AE22" IOSTANDARD LVCMOS18 } [get_ports DINA[5]]
set_property -dict { PACKAGE_PIN "AF20" IOSTANDARD LVCMOS18 } [get_ports DINA[6]]
set_property -dict { PACKAGE_PIN "AF21" IOSTANDARD LVCMOS18 } [get_ports DINA[7]]
set_property -dict { PACKAGE_PIN "AH18" IOSTANDARD LVCMOS18 } [get_ports DINA[8]]
set_property -dict { PACKAGE_PIN "AH19" IOSTANDARD LVCMOS18 } [get_ports DINA[9]]
set_property -dict { PACKAGE_PIN "AJ18" IOSTANDARD LVCMOS18 } [get_ports DINA[10]]
set_property -dict { PACKAGE_PIN "AJ19" IOSTANDARD LVCMOS18 } [get_ports DINA[11]]
set_property -dict { PACKAGE_PIN "AK16" IOSTANDARD LVCMOS18 } [get_ports DINA[12]]
set_property -dict { PACKAGE_PIN "AK17" IOSTANDARD LVCMOS18 } [get_ports DINA[13]]
set_property -dict { PACKAGE_PIN "AM16" IOSTANDARD LVCMOS18 } [get_ports DINA[14]]
set_property -dict { PACKAGE_PIN "AM17" IOSTANDARD LVCMOS18 } [get_ports DINA[15]]
set_property -dict { PACKAGE_PIN "AN14" IOSTANDARD LVCMOS18 } [get_ports DINA[16]]
set_property -dict { PACKAGE_PIN "AN15" IOSTANDARD LVCMOS18 } [get_ports DINA[17]]
set_property -dict { PACKAGE_PIN "AP14" IOSTANDARD LVCMOS18 } [get_ports DINA[18]]
set_property -dict { PACKAGE_PIN "AP15" IOSTANDARD LVCMOS18 } [get_ports DINA[19]]
set_property -dict { PACKAGE_PIN "AR15" IOSTANDARD LVCMOS18 } [get_ports DINA[20]]
set_property -dict { PACKAGE_PIN "AR16" IOSTANDARD LVCMOS18 } [get_ports DINA[21]]
set_property -dict { PACKAGE_PIN "AT14" IOSTANDARD LVCMOS18 } [get_ports DINA[22]]
set_property -dict { PACKAGE_PIN "AT15" IOSTANDARD LVCMOS18 } [get_ports DINA[23]]
set_property -dict { PACKAGE_PIN "AU13" IOSTANDARD LVCMOS18 } [get_ports DINA[24]]
set_property -dict { PACKAGE_PIN "AU14" IOSTANDARD LVCMOS18 } [get_ports DINA[25]]
set_property -dict { PACKAGE_PIN "AV13" IOSTANDARD LVCMOS18 } [get_ports DINA[26]]
set_property -dict { PACKAGE_PIN "AV14" IOSTANDARD LVCMOS18 } [get_ports DINA[27]]
set_property -dict { PACKAGE_PIN "AW11" IOSTANDARD LVCMOS18 } [get_ports DINA[28]]
set_property -dict { PACKAGE_PIN "AW12" IOSTANDARD LVCMOS18 } [get_ports DINA[29]]
set_property -dict { PACKAGE_PIN "AY11" IOSTANDARD LVCMOS18 } [get_ports DINA[30]]
set_property -dict { PACKAGE_PIN "AY12" IOSTANDARD LVCMOS18 } [get_ports DINA[31]]

set_property -dict { PACKAGE_PIN "AA22" IOSTANDARD LVCMOS18 } [get_ports DINB[0]]
set_property -dict { PACKAGE_PIN "AB21" IOSTANDARD LVCMOS18 } [get_ports DINB[1]]
set_property -dict { PACKAGE_PIN "AC20" IOSTANDARD LVCMOS18 } [get_ports DINB[2]]
set_property -dict { PACKAGE_PIN "AC21" IOSTANDARD LVCMOS18 } [get_ports DINB[3]]
set_property -dict { PACKAGE_PIN "AD19" IOSTANDARD LVCMOS18 } [get_ports DINB[4]]
set_property -dict { PACKAGE_PIN "AD20" IOSTANDARD LVCMOS18 } [get_ports DINB[5]]
set_property -dict { PACKAGE_PIN "AE19" IOSTANDARD LVCMOS18 } [get_ports DINB[6]]
set_property -dict { PACKAGE_PIN "AE20" IOSTANDARD LVCMOS18 } [get_ports DINB[7]]
set_property -dict { PACKAGE_PIN "AF18" IOSTANDARD LVCMOS18 } [get_ports DINB[8]]
set_property -dict { PACKAGE_PIN "AF19" IOSTANDARD LVCMOS18 } [get_ports DINB[9]]
set_property -dict { PACKAGE_PIN "AG18" IOSTANDARD LVCMOS18 } [get_ports DINB[10]]
set_property -dict { PACKAGE_PIN "AG19" IOSTANDARD LVCMOS18 } [get_ports DINB[11]]
set_property -dict { PACKAGE_PIN "AH16" IOSTANDARD LVCMOS18 } [get_ports DINB[12]]
set_property -dict { PACKAGE_PIN "AH17" IOSTANDARD LVCMOS18 } [get_ports DINB[13]]
set_property -dict { PACKAGE_PIN "AJ16" IOSTANDARD LVCMOS18 } [get_ports DINB[14]]
set_property -dict { PACKAGE_PIN "AJ17" IOSTANDARD LVCMOS18 } [get_ports DINB[15]]
set_property -dict { PACKAGE_PIN "AK14" IOSTANDARD LVCMOS18 } [get_ports DINB[16]]
set_property -dict { PACKAGE_PIN "AK15" IOSTANDARD LVCMOS18 } [get_ports DINB[17]]
set_property -dict { PACKAGE_PIN "AL14" IOSTANDARD LVCMOS18 } [get_ports DINB[18]]
set_property -dict { PACKAGE_PIN "AL15" IOSTANDARD LVCMOS18 } [get_ports DINB[19]]
set_property -dict { PACKAGE_PIN "AM14" IOSTANDARD LVCMOS18 } [get_ports DINB[20]]
set_property -dict { PACKAGE_PIN "AM15" IOSTANDARD LVCMOS18 } [get_ports DINB[21]]
set_property -dict { PACKAGE_PIN "AN12" IOSTANDARD LVCMOS18 } [get_ports DINB[22]]
set_property -dict { PACKAGE_PIN "AN13" IOSTANDARD LVCMOS18 } [get_ports DINB[23]]
set_property -dict { PACKAGE_PIN "AP12" IOSTANDARD LVCMOS18 } [get_ports DINB[24]]
set_property -dict { PACKAGE_PIN "AP13" IOSTANDARD LVCMOS18 } [get_ports DINB[25]]
set_property -dict { PACKAGE_PIN "AR13" IOSTANDARD LVCMOS18 } [get_ports DINB[26]]
set_property -dict { PACKAGE_PIN "AR14" IOSTANDARD LVCMOS18 } [get_ports DINB[27]]
set_property -dict { PACKAGE_PIN "AT12" IOSTANDARD LVCMOS18 } [get_ports DINB[28]]
set_property -dict { PACKAGE_PIN "AT13" IOSTANDARD LVCMOS18 } [get_ports DINB[29]]
set_property -dict { PACKAGE_PIN "AU11" IOSTANDARD LVCMOS18 } [get_ports DINB[30]]
set_property -dict { PACKAGE_PIN "AU12" IOSTANDARD LVCMOS18 } [get_ports DINB[31]]

set_property -dict { PACKAGE_PIN "J21" IOSTANDARD LVCMOS18 } [get_ports DOUTA[0]]
set_property -dict { PACKAGE_PIN "H21" IOSTANDARD LVCMOS18 } [get_ports DOUTA[1]]
set_property -dict { PACKAGE_PIN "K22" IOSTANDARD LVCMOS18 } [get_ports DOUTA[2]]
set_property -dict { PACKAGE_PIN "K21" IOSTANDARD LVCMOS18 } [get_ports DOUTA[3]]
set_property -dict { PACKAGE_PIN "J22" IOSTANDARD LVCMOS18 } [get_ports DOUTA[4]]
set_property -dict { PACKAGE_PIN "H22" IOSTANDARD LVCMOS18 } [get_ports DOUTA[5]]
set_property -dict { PACKAGE_PIN "G22" IOSTANDARD LVCMOS18 } [get_ports DOUTA[6]]
set_property -dict { PACKAGE_PIN "G21" IOSTANDARD LVCMOS18 } [get_ports DOUTA[7]]
set_property -dict { PACKAGE_PIN "F21" IOSTANDARD LVCMOS18 } [get_ports DOUTA[8]]
set_property -dict { PACKAGE_PIN "F20" IOSTANDARD LVCMOS18 } [get_ports DOUTA[9]]
set_property -dict { PACKAGE_PIN "E21" IOSTANDARD LVCMOS18 } [get_ports DOUTA[10]]
set_property -dict { PACKAGE_PIN "E20" IOSTANDARD LVCMOS18 } [get_ports DOUTA[11]]
set_property -dict { PACKAGE_PIN "D21" IOSTANDARD LVCMOS18 } [get_ports DOUTA[12]]
set_property -dict { PACKAGE_PIN "D20" IOSTANDARD LVCMOS18 } [get_ports DOUTA[13]]
set_property -dict { PACKAGE_PIN "C22" IOSTANDARD LVCMOS18 } [get_ports DOUTA[14]]
set_property -dict { PACKAGE_PIN "C21" IOSTANDARD LVCMOS18 } [get_ports DOUTA[15]]
set_property -dict { PACKAGE_PIN "B22" IOSTANDARD LVCMOS18 } [get_ports DOUTA[16]]
set_property -dict { PACKAGE_PIN "B21" IOSTANDARD LVCMOS18 } [get_ports DOUTA[17]]
set_property -dict { PACKAGE_PIN "A21" IOSTANDARD LVCMOS18 } [get_ports DOUTA[18]]
set_property -dict { PACKAGE_PIN "A20" IOSTANDARD LVCMOS18 } [get_ports DOUTA[19]]
set_property -dict { PACKAGE_PIN "A19" IOSTANDARD LVCMOS18 } [get_ports DOUTA[20]]
set_property -dict { PACKAGE_PIN "A18" IOSTANDARD LVCMOS18 } [get_ports DOUTA[21]]
set_property -dict { PACKAGE_PIN "B19" IOSTANDARD LVCMOS18 } [get_ports DOUTA[22]]
set_property -dict { PACKAGE_PIN "B18" IOSTANDARD LVCMOS18 } [get_ports DOUTA[23]]
set_property -dict { PACKAGE_PIN "C19" IOSTANDARD LVCMOS18 } [get_ports DOUTA[24]]
set_property -dict { PACKAGE_PIN "C18" IOSTANDARD LVCMOS18 } [get_ports DOUTA[25]]
set_property -dict { PACKAGE_PIN "D19" IOSTANDARD LVCMOS18 } [get_ports DOUTA[26]]
set_property -dict { PACKAGE_PIN "D18" IOSTANDARD LVCMOS18 } [get_ports DOUTA[27]]
set_property -dict { PACKAGE_PIN "E19" IOSTANDARD LVCMOS18 } [get_ports DOUTA[28]]
set_property -dict { PACKAGE_PIN "E18" IOSTANDARD LVCMOS18 } [get_ports DOUTA[29]]
set_property -dict { PACKAGE_PIN "F19" IOSTANDARD LVCMOS18 } [get_ports DOUTA[30]]
set_property -dict { PACKAGE_PIN "F18" IOSTANDARD LVCMOS18 } [get_ports DOUTA[31]]

set_property -dict { PACKAGE_PIN "J19" IOSTANDARD LVCMOS18 } [get_ports DOUTB[0]]
set_property -dict { PACKAGE_PIN "H19" IOSTANDARD LVCMOS18 } [get_ports DOUTB[1]]
set_property -dict { PACKAGE_PIN "K20" IOSTANDARD LVCMOS18 } [get_ports DOUTB[2]]
set_property -dict { PACKAGE_PIN "K19" IOSTANDARD LVCMOS18 } [get_ports DOUTB[3]]
set_property -dict { PACKAGE_PIN "J20" IOSTANDARD LVCMOS18 } [get_ports DOUTB[4]]
set_property -dict { PACKAGE_PIN "H20" IOSTANDARD LVCMOS18 } [get_ports DOUTB[5]]
set_property -dict { PACKAGE_PIN "G20" IOSTANDARD LVCMOS18 } [get_ports DOUTB[6]]
set_property -dict { PACKAGE_PIN "G19" IOSTANDARD LVCMOS18 } [get_ports DOUTB[7]]
set_property -dict { PACKAGE_PIN "F17" IOSTANDARD LVCMOS18 } [get_ports DOUTB[8]]
set_property -dict { PACKAGE_PIN "E17" IOSTANDARD LVCMOS18 } [get_ports DOUTB[9]]
set_property -dict { PACKAGE_PIN "D16" IOSTANDARD LVCMOS18 } [get_ports DOUTB[10]]
set_property -dict { PACKAGE_PIN "C16" IOSTANDARD LVCMOS18 } [get_ports DOUTB[11]]
set_property -dict { PACKAGE_PIN "B16" IOSTANDARD LVCMOS18 } [get_ports DOUTB[12]]
set_property -dict { PACKAGE_PIN "A16" IOSTANDARD LVCMOS18 } [get_ports DOUTB[13]]
set_property -dict { PACKAGE_PIN "A15" IOSTANDARD LVCMOS18 } [get_ports DOUTB[14]]
set_property -dict { PACKAGE_PIN "A14" IOSTANDARD LVCMOS18 } [get_ports DOUTB[15]]
set_property -dict { PACKAGE_PIN "B14" IOSTANDARD LVCMOS18 } [get_ports DOUTB[16]]
set_property -dict { PACKAGE_PIN "B13"IOSTANDARD LVCMOS18 } [get_ports DOUTB[17]]
set_property -dict { PACKAGE_PIN "C15" IOSTANDARD LVCMOS18 } [get_ports DOUTB[18]]
set_property -dict { PACKAGE_PIN "C14" IOSTANDARD LVCMOS18 } [get_ports DOUTB[19]]
set_property -dict { PACKAGE_PIN "D15" IOSTANDARD LVCMOS18 } [get_ports DOUTB[20]]
set_property -dict { PACKAGE_PIN "D14" IOSTANDARD LVCMOS18 } [get_ports DOUTB[21]]
set_property -dict { PACKAGE_PIN "E15" IOSTANDARD LVCMOS18 } [get_ports DOUTB[22]]
set_property -dict { PACKAGE_PIN "E14" IOSTANDARD LVCMOS18 } [get_ports DOUTB[23]]
set_property -dict { PACKAGE_PIN "F15" IOSTANDARD LVCMOS18 } [get_ports DOUTB[24]]
set_property -dict { PACKAGE_PIN "F14" IOSTANDARD LVCMOS18 } [get_ports DOUTB[25]]
set_property -dict { PACKAGE_PIN "G16" IOSTANDARD LVCMOS18 } [get_ports DOUTB[26]]
set_property -dict { PACKAGE_PIN "G15" IOSTANDARD LVCMOS18 } [get_ports DOUTB[27]]
set_property -dict { PACKAGE_PIN "H15" IOSTANDARD LVCMOS18 } [get_ports DOUTB[28]]
set_property -dict { PACKAGE_PIN "H14" IOSTANDARD LVCMOS18 } [get_ports DOUTB[29]]
set_property -dict { PACKAGE_PIN "J16" IOSTANDARD LVCMOS18 } [get_ports DOUTB[30]]
set_property -dict { PACKAGE_PIN "J15" IOSTANDARD LVCMOS18 } [get_ports DOUTB[31]]

set_property -dict { PACKAGE_PIN "Y16" IOSTANDARD LVCMOS18 } [get_ports RDADDRECC[0]]
set_property -dict { PACKAGE_PIN "Y17" IOSTANDARD LVCMOS18 } [get_ports RDADDRECC[1]]
set_property -dict { PACKAGE_PIN "W16" IOSTANDARD LVCMOS18 } [get_ports RDADDRECC[2]]
set_property -dict { PACKAGE_PIN "W17" IOSTANDARD LVCMOS18 } [get_ports RDADDRECC[3]]
set_property -dict { PACKAGE_PIN "V18" IOSTANDARD LVCMOS18 } [get_ports RDADDRECC[4]]

set_property -dict { PACKAGE_PIN "AB16" IOSTANDARD LVCMOS18 } [get_ports WEA[0]]
set_property -dict { PACKAGE_PIN "AA16" IOSTANDARD LVCMOS18 } [get_ports WEB[0]]

set_property -dict { PACKAGE_PIN "AA10" IOSTANDARD LVDS } [get_ports CLKA]
set_property -dict { PACKAGE_PIN "B17" IOSTANDARD LVCMOS18 } [get_ports DBITERR]
set_property -dict { PACKAGE_PIN "D17" IOSTANDARD LVCMOS18 } [get_ports ENA]
set_property -dict { PACKAGE_PIN "E16" IOSTANDARD LVCMOS18 } [get_ports ENB]
set_property -dict { PACKAGE_PIN "C17" IOSTANDARD LVCMOS18 } [get_ports SBITERR]

# ----------------------------------------------------------------------------
#  End of Constraints File
# ----------------------------------------------------------------------------
