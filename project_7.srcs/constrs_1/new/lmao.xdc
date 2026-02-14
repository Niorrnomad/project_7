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
# XDC File for aes256_top on VC707 Board

# Clock Assignment
# Using differential SYSCLK (200 MHz) on E19 (P) and E18 (N)
# Note: A wrapper module with IBUFDS is required to convert to single-ended clk
set_property -dict { PACKAGE_PIN E19 IOSTANDARD LVDS } [get_ports clk_p]
set_property -dict { PACKAGE_PIN E18 IOSTANDARD LVDS } [get_ports clk_n]
create_clock -period 5.000 -name sys_clk [get_ports clk_p]  # 200 MHz

# Reset Assignment
# Using CPU_RESET button on AV40
set_property -dict { PACKAGE_PIN AV40 IOSTANDARD LVCMOS18 } [get_ports reset]

# Control Signals
# encDec: User Switch 0 (AU40)
set_property -dict { PACKAGE_PIN AU40 IOSTANDARD LVCMOS18 } [get_ports encDec]
# loadkey: 8-bit, mapped to User Switches 1-8 (AW40, AY40, BA40, BB40, etc.)
set_property -dict { PACKAGE_PIN AW40 IOSTANDARD LVCMOS18 } [get_ports {loadkey[0]}]
set_property -dict { PACKAGE_PIN AY40 IOSTANDARD LVCMOS18 } [get_ports {loadkey[1]}]
set_property -dict { PACKAGE_PIN BA40 IOSTANDARD LVCMOS18 } [get_ports {loadkey[2]}]
set_property -dict { PACKAGE_PIN BB40 IOSTANDARD LVCMOS18 } [get_ports {loadkey[3]}]
set_property -dict { PACKAGE_PIN AV38 IOSTANDARD LVCMOS18 } [get_ports {loadkey[4]}]
set_property -dict { PACKAGE_PIN AW38 IOSTANDARD LVCMOS18 } [get_ports {loadkey[5]}]
set_property -dict { PACKAGE_PIN AY38 IOSTANDARD LVCMOS18 } [get_ports {loadkey[6]}]
set_property -dict { PACKAGE_PIN BA38 IOSTANDARD LVCMOS18 } [get_ports {loadkey[7]}]
# loadrcon: User Push Button North (AR40)
set_property -dict { PACKAGE_PIN AR40 IOSTANDARD LVCMOS18 } [get_ports loadrcon]
# loadTempKey: User Push Button East (AP40)
set_property -dict { PACKAGE_PIN AP40 IOSTANDARD LVCMOS18 } [get_ports loadTempKey]
# firstRound: User Push Button South (AT40)
set_property -dict { PACKAGE_PIN AT40 IOSTANDARD LVCMOS18 } [get_ports firstRound]
# kld: User Push Button West (AU38)
set_property -dict { PACKAGE_PIN AU38 IOSTANDARD LVCMOS18 } [get_ports kld]
# lowerQuadWord: User Push Button Center (AV39)
set_property -dict { PACKAGE_PIN AV39 IOSTANDARD LVCMOS18 } [get_ports lowerQuadWord]
# addr: 4-bit, mapped to GPIO DIP Switches 1-4 (AN14, AM14, AL14, AK14)
set_property -dict { PACKAGE_PIN AN14 IOSTANDARD LVCMOS18 } [get_ports {addr[0]}]
set_property -dict { PACKAGE_PIN AM14 IOSTANDARD LVCMOS18 } [get_ports {addr[1]}]
set_property -dict { PACKAGE_PIN AL14 IOSTANDARD LVCMOS18 } [get_ports {addr[2]}]
set_property -dict { PACKAGE_PIN AK14 IOSTANDARD LVCMOS18 } [get_ports {addr[3]}]
# we: GPIO DIP Switch 5 (AJ14)
set_property -dict { PACKAGE_PIN AJ14 IOSTANDARD LVCMOS18 } [get_ports we]
# control: 9-bit, mapped to GPIO DIP Switches 6-8 and additional pins
set_property -dict { PACKAGE_PIN AH14 IOSTANDARD LVCMOS18 } [get_ports {control[0]}]
set_property -dict { PACKAGE_PIN AG14 IOSTANDARD LVCMOS18 } [get_ports {control[1]}]
set_property -dict { PACKAGE_PIN AF14 IOSTANDARD LVCMOS18 } [get_ports {control[2]}]
set_property -dict { PACKAGE_PIN AE14 IOSTANDARD LVCMOS18 } [get_ports {control[3]}]
set_property -dict { PACKAGE_PIN AH13 IOSTANDARD LVCMOS18 } [get_ports {control[4]}]
set_property -dict { PACKAGE_PIN AG13 IOSTANDARD LVCMOS18 } [get_ports {control[5]}]
set_property -dict { PACKAGE_PIN AF13 IOSTANDARD LVCMOS18 } [get_ports {control[6]}]
set_property -dict { PACKAGE_PIN AE13 IOSTANDARD LVCMOS18 } [get_ports {control[7]}]
set_property -dict { PACKAGE_PIN AD13 IOSTANDARD LVCMOS18 } [get_ports {control[8]}]

# CipherKey: 256-bit (Subset mapped for debugging)
# Mapping first 8 bits to User LEDs 0-7 as an example
set_property -dict { PACKAGE_PIN AM39 IOSTANDARD LVCMOS18 } [get_ports {CipherKey[0]}]
set_property -dict { PACKAGE_PIN AN39 IOSTANDARD LVCMOS18 } [get_ports {CipherKey[1]}]
set_property -dict { PACKAGE_PIN AR37 IOSTANDARD LVCMOS18 } [get_ports {CipherKey[2]}]
set_property -dict { PACKAGE_PIN AT37 IOSTANDARD LVCMOS18 } [get_ports {CipherKey[3]}]
set_property -dict { PACKAGE_PIN AR35 IOSTANDARD LVCMOS18 } [get_ports {CipherKey[4]}]
set_property -dict { PACKAGE_PIN AP41 IOSTANDARD LVCMOS18 } [get_ports {CipherKey[5]}]
set_property -dict { PACKAGE_PIN AP42 IOSTANDARD LVCMOS18 } [get_ports {CipherKey[6]}]
set_property -dict { PACKAGE_PIN AU39 IOSTANDARD LVCMOS18 } [get_ports {CipherKey[7]}]
# Note: Remaining 248 bits not mapped; use memory interface in practice

# dataIn: 128-bit (Subset mapped for debugging)
# Mapping first 4 bits to GPIO pins as an example
set_property -dict { PACKAGE_PIN AC14 IOSTANDARD LVCMOS18 } [get_ports {dataIn[0]}]
set_property -dict { PACKAGE_PIN AB14 IOSTANDARD LVCMOS18 } [get_ports {dataIn[1]}]
set_property -dict { PACKAGE_PIN AA14 IOSTANDARD LVCMOS18 } [get_ports {dataIn[2]}]
set_property -dict { PACKAGE_PIN Y14  IOSTANDARD LVCMOS18 } [get_ports {dataIn[3]}]
# Note: Remaining 124 bits not mapped; use memory interface in practice

# dataOut: 128-bit (Subset mapped for debugging)
# Mapping first 8 bits to User LEDs 0-7
set_property -dict { PACKAGE_PIN AM39 IOSTANDARD LVCMOS18 } [get_ports {dataOut[0]}]
set_property -dict { PACKAGE_PIN AN39 IOSTANDARD LVCMOS18 } [get_ports {dataOut[1]}]
set_property -dict { PACKAGE_PIN AR37 IOSTANDARD LVCMOS18 } [get_ports {dataOut[2]}]
set_property -dict { PACKAGE_PIN AT37 IOSTANDARD LVCMOS18 } [get_ports {dataOut[3]}]
set_property -dict { PACKAGE_PIN AR35 IOSTANDARD LVCMOS18 } [get_ports {dataOut[4]}]
set_property -dict { PACKAGE_PIN AP41 IOSTANDARD LVCMOS18 } [get_ports {dataOut[5]}]
set_property -dict { PACKAGE_PIN AP42 IOSTANDARD LVCMOS18 } [get_ports {dataOut[6]}]
set_property -dict { PACKAGE_PIN AU39 IOSTANDARD LVCMOS18 } [get_ports {dataOut[7]}]
# Note: Remaining 120 bits not mapped; use memory interface in practice

# Timing Constraints
# Input delays
set_input_delay -clock [get_clocks sys_clk] -max 2.000 [get_ports {reset encDec loadkey[*] loadrcon loadTempKey firstRound kld lowerQuadWord addr[*] we control[*] dataIn[*]}]
set_input_delay -clock [get_clocks sys_clk] -min 0.500 [get_ports {reset encDec loadkey[*] loadrcon loadTempKey firstRound kld lowerQuadWord addr[*] we control[*] dataIn[*]}]
# Output delays
set_output_delay -clock [get_clocks sys_clk] -max 2.000 [get_ports {dataOut[*] CipherKey[*]}]
set_output_delay -clock [get_clocks sys_clk] -min 0.500 [get_ports {dataOut[*] CipherKey[*]}]

# Additional Configuration
set_property DRIVE 12 [get_ports {dataOut[*] CipherKey[*]}]
set_property SLEW SLOW [get_ports {dataOut[*] CipherKey[*]}]
# XDC File for blk_mem_gen_v4_3 on VC707 Board

# Clock Assignment for clka
# Using GPIO pin AU40 as a single-ended clock input
# Note: Requires an external clock source connected to AU40
set_property -dict { PACKAGE_PIN AU40 IOSTANDARD LVCMOS18 } [get_ports clka]
create_clock -period 10.000 -name clka [get_ports clka]  # Assumes 100 MHz clock

# Reset Assignment for rsta
# Using User Push Button North (AR40)
set_property -dict { PACKAGE_PIN AR40 IOSTANDARD LVCMOS18 } [get_ports rsta]

# Write Enable for wea (1-bit)
# Using User Switch 0 (AW40)
set_property -dict { PACKAGE_PIN AW40 IOSTANDARD LVCMOS18 } [get_ports wea]

# Address for addra (4-bit)
# Mapped to GPIO DIP Switches 1-4 (AN14, AM14, AL14, AK14)
set_property -dict { PACKAGE_PIN AN14 IOSTANDARD LVCMOS18 } [get_ports {addra[0]}]
set_property -dict { PACKAGE_PIN AM14 IOSTANDARD LVCMOS18 } [get_ports {addra[1]}]
set_property -dict { PACKAGE_PIN AL14 IOSTANDARD LVCMOS18 } [get_ports {addra[2]}]
set_property -dict { PACKAGE_PIN AK14 IOSTANDARD LVCMOS18 } [get_ports {addra[3]}]

# Data Input for dina (128-bit, subset mapped)
# Mapping first 4 bits to GPIO pins as an example
set_property -dict { PACKAGE_PIN AC14 IOSTANDARD LVCMOS18 } [get_ports {dina[0]}]
set_property -dict { PACKAGE_PIN AB14 IOSTANDARD LVCMOS18 } [get_ports {dina[1]}]
set_property -dict { PACKAGE_PIN AA14 IOSTANDARD LVCMOS18 } [get_ports {dina[2]}]
set_property -dict { PACKAGE_PIN Y14  IOSTANDARD LVCMOS18 } [get_ports {dina[3]}]
# Note: Remaining 124 bits not mapped; expand as needed

# Data Output for douta (128-bit, subset mapped)
# Mapping first 8 bits to User LEDs 0-7
set_property -dict { PACKAGE_PIN AM39 IOSTANDARD LVCMOS18 } [get_ports {douta[0]}]
set_property -dict { PACKAGE_PIN AN39 IOSTANDARD LVCMOS18 } [get_ports {douta[1]}]
set_property -dict { PACKAGE_PIN AR37 IOSTANDARD LVCMOS18 } [get_ports {douta[2]}]
set_property -dict { PACKAGE_PIN AT37 IOSTANDARD LVCMOS18 } [get_ports {douta[3]}]
set_property -dict { PACKAGE_PIN AR35 IOSTANDARD LVCMOS18 } [get_ports {douta[4]}]
set_property -dict { PACKAGE_PIN AP41 IOSTANDARD LVCMOS18 } [get_ports {douta[5]}]
set_property -dict { PACKAGE_PIN AP42 IOSTANDARD LVCMOS18 } [get_ports {douta[6]}]
set_property -dict { PACKAGE_PIN AU39 IOSTANDARD LVCMOS18 } [get_ports {douta[7]}]
# Note: Remaining 120 bits not mapped; expand as needed

# Timing Constraints
# Input delays
set_input_delay -clock [get_clocks clka] -max 2.000 [get_ports {rsta wea addra[*] dina[*]}]
set_input_delay -clock [get_clocks clka] -min 0.500 [get_ports {rsta wea addra[*] dina[*]}]
# Output delays
set_output_delay -clock [get_clocks clka] -max 2.000 [get_ports {douta[*]}]
set_output_delay -clock [get_clocks clka] -min 0.500 [get_ports {douta[*]}]

# Additional Configuration
set_property DRIVE 12 [get_ports {douta[*]}]
set_property SLEW SLOW [get_ports {douta[*]}]

# Notes:
# - This XDC assumes blk_mem_gen_v4_3 is used as a top-level module for testing.
# - In a typical design, memory ports are internal; adjust mappings accordingly.
# - Expand dina and douta mappings if more bits are needed for external interfacing.
# Notes:
# - Differential clock requires a wrapper module with IBUFDS to convert to single-ended clk.
# - Large buses (CipherKey, dataIn, dataOut) have only a subset mapped due to pin limitations.
# - Expand mappings for all bits if interfacing with external hardware or memory is intended.
# ----------------------------------------------------------------------------
#  End of Constraints File
# ----------------------------------------------------------------------------
