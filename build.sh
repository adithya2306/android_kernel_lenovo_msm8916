SECONDS=0

export ARCH=arm64
export CROSS_COMPILE="$HOME/tc/aarch64-linux-android-6.x/bin/aarch64-linux-android-"

mkdir -p out
make O=out A6020_defconfig
make -j$(nproc --all) O=out Image.gz-dtb || exit $?

if [ -f "out/arch/arm64/boot/Image.gz-dtb" ]; then
git clone -q https://github.com/ghostrider-reborn/AnyKernel3 -b A6020
cp out/arch/arm64/boot/Image.gz-dtb AnyKernel3
cd AnyKernel3
zip -r9 "../QuicksilveR-A6020-$(date '+%Y%m%d-%H%M').zip" * -x '*.git*' README.md *placeholder
cd ..
rm -rf AnyKernel3
rm -f out/arch/arm64/boot/Image.gz-dtb
echo -e "\nCompleted in $((SECONDS / 60)) minute(s) and $((SECONDS % 60)) second(s) !"
else
echo -e "\nBuild failed!"
fi
