#!/bin/bash


if [ ! -e "fsbl" ]; then
    ./scripts/repo_clone.sh --gitclone scripts/subtree.xml --reproduce scripts/git_version_github_v410/git_version_github_v410_2024-12-04.txt
fi

#传入开发版类型(sophpi)
function do-build() 
{(
    source build/cvisetup.sh
    defconfig $1
    clean_all
    build_fsbl
)}
#传入开发板类型（sophpi,milkv）
function copy-toolchain()
{       
    OUTPUT_PATH="output/$2"
    mkdir -p output/$2

    #copy uboot
    mkdir -p $OUTPUT_PATH/uboot
    cp -vr u-boot-2021.10/build/$1/u-boot-raw.bin $OUTPUT_PATH/uboot/
    #copy opensbi
    mkdir -p $OUTPUT_PATH/opensbi
    cp -vr opensbi/build/platform/generic/firmware/fw_dynamic.bin  $OUTPUT_PATH/opensbi/
    #coy fsbl
     mkdir -p $OUTPUT_PATH/fsbl
    cp -vr fsbl/build/$1/* $OUTPUT_PATH/fsbl/
    cp -vr fsbl/test/cv181x/ddr_param.bin $OUTPUT_PATH/fsbl/
    cp -vr fsbl/test/empty.bin $OUTPUT_PATH/fsbl/
    #copy dtb
    # mkdir -p $OUTPUT_PATH/dtb
    # cp -v ramdisk/build/$PROJECT_FULLNAME/workspace/multi.its $OUTPUT_PATH/dtb/
    # cp -v ramdisk/build/$PROJECT_FULLNAME/workspace/$PROJECT_FULLNAME.dtb $OUTPUT_PATH/dtb/
}

ALLBOARD_SOPH=(sg2002_wevb_riscv64_sd sg2000_wevb_riscv64_sd cv1800b_wevb_0008a_spinor)
AllBOARD_MILKV=(milkv-duo256-sd milkv-duos-sd milkv-duo-sd)
# 使用数组的键来遍历
for i in "${!ALLBOARD_SOPH[@]}"; do
    BOARD_SOPH=${ALLBOARD_SOPH[i]}
    BOARD_MILKV=${AllBOARD_MILKV[i]}    
    do-build $BOARD_SOPH
    copy-toolchain $BOARD_SOPH $BOARD_MILKV      
done
