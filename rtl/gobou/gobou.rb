#!/usr/bin/env ruby

require '../ninjin/ninjin'

# ERB(Meta) parameter
$core     = $gobou_core
$core_log = $gobou_core_log

$d_mac    = 3   # Delay clocks in the pool module
$d_bias   = 2   # Delay clocks in the pool module
$d_relu   = 2   # Delay clocks in the pool module

### Verilog parameter
# Hardware
$netsize  = $gobou_netsize # Network size: (801 * 500 + 501 * 10) / $core

# Network
$n_in = 800
$n_f1 = 500
$n_f2 = 10

