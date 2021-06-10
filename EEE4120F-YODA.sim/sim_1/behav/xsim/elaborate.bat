@echo off
REM ****************************************************************************
REM Vivado (TM) v2020.2 (64-bit)
REM
REM Filename    : elaborate.bat
REM Simulator   : Xilinx Vivado Simulator
REM Description : Script for elaborating the compiled design
REM
REM Generated by Vivado on Thu Jun 10 04:09:11 +0200 2021
REM SW Build 3064766 on Wed Nov 18 09:12:45 MST 2020
REM
REM Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
REM
REM usage: elaborate.bat
REM
REM ****************************************************************************
REM elaborate design
echo "xelab -wto 9e54c04e75344711b192d292af1292b1 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L fifo_generator_v13_2_5 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot rand_gen_tb_behav xil_defaultlib.rand_gen_tb xil_defaultlib.glbl -log elaborate.log"
call xelab  -wto 9e54c04e75344711b192d292af1292b1 --incr --debug typical --relax --mt 2 -L xil_defaultlib -L fifo_generator_v13_2_5 -L unisims_ver -L unimacro_ver -L secureip -L xpm --snapshot rand_gen_tb_behav xil_defaultlib.rand_gen_tb xil_defaultlib.glbl -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
