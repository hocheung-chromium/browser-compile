Features:

1、新增关闭浏览器前弹出提示框功能（透过chrome://flags控制）
<https://github.com/ungoogled-software/ungoogled-chromium/blob/master/patches/extra/ungoogled-chromium/add-flag-for-close-confirmation.patch>

2、新增自定义新标签页(NTP)功能（透过chrome://flags控制）
<https://github.com/ungoogled-software/ungoogled-chromium/blob/master/patches/extra/ungoogled-chromium/add-flag-for-custom-ntp.patch>

3、新增关闭最后一个标签页是否关闭浏览器的功能（透过chrome://flags控制）
<https://github.com/ungoogled-software/ungoogled-chromium/blob/master/patches/extra/ungoogled-chromium/add-flag-to-close-window-with-last-tab.patch>

4、调整地址栏(omnibox)格式化（默认启用）
<https://github.com/ungoogled-software/ungoogled-chromium/blob/master/patches/extra/ungoogled-chromium/disable-formatting-in-omnibox.patch>

5、开启Reload功能的上下文菜单（默认启用）
<https://github.com/ungoogled-software/ungoogled-chromium/blob/master/patches/extra/ungoogled-chromium/enable-menu-on-reload-button.patch>

6、编译和性能优化
<https://github.com/RobRich999/Chromium_Clang/blob/master/Windows/win64-avx.patch>
<https://github.com/RobRich999/Chromium_Clang/blob/master/Windows/win64-avx2.patch>

7、HEVC增强补丁
<https://github.com/StaZhu/enable-chromium-hevc-hardware-decoding/blob/main/add-hevc-ffmpeg-decoder-parser.patch>

8、便携化补丁（透过chrome://flags控制）
<https://github.com/ungoogled-software/ungoogled-chromium-windows/blob/master/patches/ungoogled-chromium/windows/windows-disable-encryption.patch>
<https://github.com/ungoogled-software/ungoogled-chromium-windows/blob/master/patches/ungoogled-chromium/windows/windows-disable-machine-id.patch>

9、隐藏侧边栏补丁（透过chrome://flags控制）
<https://github.com/ungoogled-software/ungoogled-chromium/blob/master/patches/extra/ungoogled-chromium/add-flag-to-hide-side-panel-button.patch>

8、为AVX2版本的opus引入额外的优化（本人修改）

9、删去默认浏览器提示条（本人修改）

10、新增双击关闭标签页功能（本人修改）

11、jpeg-xl支持及其对应的图像仿真 （透过chrome://flags控制）
<https://chromium-review.googlesource.com/c/chromium/src/+/4255409>
<https://chromium-review.googlesource.com/c/devtools/devtools-frontend/+/4257582>
