SECONDS=0

export ARCH=arm64
export CROSS_COMPILE="$HOME/gcc7/bin/aarch64-cortex_a53-linux-android-"

mkdir -p out
make O=out A6020_defconfig
make -j16 O=out Image.gz-dtb

if [ -f "out/arch/arm64/boot/Image.gz-dtb" ]; then
git clone -q https://github.com/ghostrider-reborn/AnyKernel3 -b A6020
cp out/arch/arm64/boot/Image.gz-dtb AnyKernel3
rm -f *zip
cd AnyKernel3
zip -r9 "../QuicksilveR-A6020-$(date '+%Y%m%d')" * -x '*.git*' README.md *placeholder
cd ..
#rm -rf AnyKernel3
#rm -rf out
echo -e "\nCompleted in $((SECONDS / 60)) minute(s) and $((SECONDS % 60)) second(s) !"
else
echo -e "\nBuild failed!"
fi
