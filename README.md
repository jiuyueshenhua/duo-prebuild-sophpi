# usage

该仓库的上游基于sophpi，为打包rtthread.bin的仓库提供各种开发板的prebuild组件。具体背景可见[此issue](https://github.com/plctlab/plct-rt-thread/issues/7)

执行`./mk-tools.sh`，在`ouput`目录下会生产`milkv-duo-sd`，`milkv-duo256-sd`，`milkv-duos-sd`的prebuild组件。

`version.txt`记录了上游sophpi的版本和组件的版本。

# result



```RPM Spec
catcatbing@catcatbing-thinkpad-l15-gen-4 ~/d/p/sophpi-prebuild-backup (sg200x-evb)> tree -L 1 .
.
├── build
├── fsbl
├── host-tools
├── install
├── mk-tools.sh
├── opensbi
├── output
├── README.md
├── scripts
└── u-boot-2021.10

```




```RPM Spec
catcatbing@catcatbing-thinkpad-l15-gen-4 ~/d/p/sophpi-prebuild-backup (sg200x-evb)> tree -L 2  output/
output/
├── milkv-duo256-sd
│   ├── fsbl
│   ├── opensbi
│   ├── u-boot
│   └── uboot
├── milkv-duo-sd
│   ├── fsbl
│   ├── opensbi
│   └── uboot
└── milkv-duos-sd
    ├── fsbl
    ├── opensbi
    └── uboot

```

# todo

- 抽离出sophpi编译dts的流程。

  原sophpi必须在linux目录下编译dts，而且是先编译linux内核后才能编译dts。
询问gpt得，dts编译可以和内核编译分开。那么可以尝试从makefile中抽离出sophpi编译dts的流程。