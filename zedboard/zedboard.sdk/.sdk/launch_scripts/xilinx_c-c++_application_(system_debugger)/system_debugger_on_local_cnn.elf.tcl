connect -url tcp:127.0.0.1:3121
source /ram/home/work/takau/kinpira/zedboard/zedboard.sdk/kinpira_wrapper_hw_platform_0/ps7_init.tcl
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zed 210248782826"} -index 0
rst -system
after 3000
targets -set -filter {jtag_cable_name =~ "Digilent Zed 210248782826" && level==0} -index 1
fpga -file /ram/home/work/takau/kinpira/zedboard/zedboard.sdk/kinpira_wrapper_hw_platform_0/kinpira_wrapper.bit
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zed 210248782826"} -index 0
loadhw /ram/home/work/takau/kinpira/zedboard/zedboard.sdk/kinpira_wrapper_hw_platform_0/system.hdf
targets -set -filter {name =~"APU" && jtag_cable_name =~ "Digilent Zed 210248782826"} -index 0
ps7_init
ps7_post_config
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zed 210248782826"} -index 0
dow /ram/home/work/takau/kinpira/zedboard/zedboard.sdk/cnn/Debug/cnn.elf
targets -set -nocase -filter {name =~ "ARM*#0" && jtag_cable_name =~ "Digilent Zed 210248782826"} -index 0
con
