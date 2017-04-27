#!/usr/bin/env ruby

require '../ninjin/ninjin'

### ERB(Meta) parameter
$core       = $renkon_core # Num of cores
$core_log   = $renkon_core_log

$max_size   = 32  # Corresponds to acceptable max input size
$max_line   = 5

$fsize      = 5
$psize      = 2

$d_pixelbuf = 32  # Corresponds to acceptable max input size
$d_poolbuf  = 32  # Corresponds to acceptable max input size
$d_conv     = if $fsize == 5 then 5 else 4 end   # Delay clocks in the conv module
$d_accum    = 1   # Delay clocks in the accumlator module
$d_bias     = 2   # Delay clocks in the pool module
$d_relu     = 2   # Delay clocks in the pool module
$d_pool     = 2   # Delay clocks in the pool module

### Verilog parameter
# Hardware
$netsize  = $renkon_netsize # Address bitwidth of weights: (50*20*5*5)/8
$outsize  = 10 # Address bitwidth of outputs: (4*4*32)
$faccum   = 10 # Address bitwidth of conv fmap: (24*24)
$bufsize  = ( Math.log($max_size) / Math.log(2) ).to_i;;

# Network
$n_in   = 1
$n_f1   = 20
$n_f2   = 50
$in_hei = 28
$fm1hei = $in_hei - $fsize + 1
$pm1hei = $fm1hei / $psize
$fm2hei = $pm1hei - $fsize + 1
$pm2hei = $fm2hei / $psize

