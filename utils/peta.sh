#!/bin/sh
# ref:
#   https://forum.digilentinc.com/topic/2719-how-to-register-my-device-as-uio-on-petalinux/

# zynqMP | zynq | microblaze
PETA_ARCH=zynqMP
PETA_NAME=linux
PETA_FPGA=images/linux/design_1_wrapper.bit

### Create project for the target board
petalinux-create --type project --template $PETA_ARCH --name $PETA_NAME

### First Build (w/ TMPDIR to /ldisk)
cd $PETA_NAME
petalinux-config --get-hw-description=..
petalinux-build

### User configuration
cp components/plnx_workspace/device-tree-generation/pl.dtsi \
   components/plnx_workspace/device-tree-generation/system-conf.dtsi \
   project-spec/meta-user/recipes-dt/device-tree/files
sed -i -e "s/xlnx,kinpira-1.0/generic-uio/g" \
  project-spec/meta-user/recipes-dt/device-tree/files/pl.dtsi
sed -i -e "s/earlycon=cdns,mmio,0xFF000000,115200n8/earlycon=cdns,mmio,0xFF000000,115200n8 uio_pdrv_genirq.of_id=generic-uio/g" \
  project-spec/meta-user/recipes-dt/device-tree/files/system-conf.dtsi
cat << EOS > project-spec/meta-user/recipes-dt/device-tree/device-tree-generation_%.bbappend
SRC_URI_append ="\\
    file://system-top.dts\\
    file://pl.dtsi\\
    file://system-conf.dtsi\\
"
FILESEXTRAPATHS_prepend := "\${THISDIR}/files:"

do_compile_prepend () {
    install -m 644 \${WORKDIR}/pl.dtsi \${dts_dir}/
    install -m 644 \${WORKDIR}/system-conf.dtsi \${dts_dir}/
}
EOS

### Kernel Re-Build (w/ uio_pdrv_genirq)
petalinux-config --component kernel
petalinux-build

### Package images
petalinux-package --boot --fpga $PETA_FPGA --u-boot
petalinux-package --prebuilt --fpga $PETA_FPGA

### Boot on QEMU
petalinux-boot --qemu --prebuilt 3

### After boot
# (modprobe uio_pdrv_genirq)

