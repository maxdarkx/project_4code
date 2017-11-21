@echo off
set xv_path=C:\\Xilinx\\Vivado\\2017.2\\bin
call %xv_path%/xelab  -wto 17bef54669c24bcd9a090762740e9d64 -m64 --debug typical --relax --mt 2 -L xil_defaultlib -L secureip --snapshot machine_sim_behav xil_defaultlib.machine_sim -log elaborate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
