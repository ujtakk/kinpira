#!/usr/bin/env ruby

### ERB(Meta) parameter
$dist       = true
$core       = 8   # Num of cores
$core_log   = (Math.log($core)/Math.log(2)).to_i
$max_size   = 32  # Corresponds to acceptable max input size
$max_line   = 5
$d_pixelbuf = 32  # Corresponds to acceptable max input size
$d_poolbuf  = 32  # Corresponds to acceptable max input size
$d_conv     = 5   # Delay clocks in the conv module
$d_accum    = 1   # Delay clocks in the accumlator module
$d_bias     = 2   # Delay clocks in the pool module
$d_relu     = 2   # Delay clocks in the pool module
$d_pool     = 2   # Delay clocks in the pool module

### Verilog parameter
# Hardware
$dwidth   = 16 # Data bitwidth
$lwidth   = 10 # Literal(Constant) data bitwidth
$step     = 10 # Step width(ns) per clock
$imgsize  = 12 # Address bitwidth of inputs: (12*12*20)
$outsize  = 8 # Address bitwidth of outputs: (12*12*20)
$netsize  = 11 # Address bitwidth of weights: (50*20*5*5)/8
$faccum   = 10 # Address bitwidth of conv fmap: (24*24)
$bufsize  = ( Math.log($max_size) / Math.log(2) ).to_i;;

# Network
$n_in   = 1
$n_f1   = 16
$n_f2   = 32
$fsize  = 5
$psize  = 2
$in_hei = 28
$fm1hei = $in_hei - $fsize + 1
$pm1hei = $fm1hei / $psize
$fm2hei = $pm1hei - $fsize + 1
$pm2hei = $fm2hei / $psize

