#!/usr/bin/env ruby

# ERB(Meta) parameter
$dist     = false
$project  = `pwd`.chomp.split('/rtl')[0]
$d_mac    = 3   # Delay clocks in the pool module
$d_bias   = 2   # Delay clocks in the pool module
$d_relu   = 2   # Delay clocks in the pool module

### Verilog parameter
# Hardware
$step     = 10
$core     = 16
$core_log = (Math.log($core)/Math.log(2)).to_i
$dwidth   = 16
$lwidth   = 10
$imgsize  = 12 # Image size: 800 + 500 + 10
$netsize  = 14 # Network size: (801 * 500 + 501 * 10) / 32

# Network
$n_in = 512
$n_f1 = 256
$n_f2 = 10
