rem Matrix-driven Appveyor CI script for libmypaint
rem Currently only does MSYS2 builds.
rem https://www.appveyor.com/docs/installed-software#mingw-msys-cygwin
rem Needs the following vars:
rem    MSYS2_ARCH:  x86_64 or i686
rem    MSYSTEM:  MINGW64 or MINGW32

rem Set the paths appropriately
PATH C:\msys64\%MSYSTEM%\bin;C:\msys64\usr\bin;%PATH%

rem Upgrade the MSYS2 platform
bash -lc "pacman --noconfirm -R catgets libcatgets"
bash -lc "pacman --noconfirm --sync --refresh --refresh pacman"
bash -lc "pacman --noconfirm --sync --refresh --refresh --sysupgrade --sysupgrade"

rem Install required tools
bash -xlc "pacman --noconfirm -S --needed base-devel"

rem Install the relevant native dependencies
bash -xlc "pacman --noconfirm -S --needed mingw-w64-%MSYS2_ARCH%-toolchain"
bash -xlc "pacman --noconfirm -S --needed mingw-w64-%MSYS2_ARCH%-git"
bash -xlc "pacman --noconfirm -S --needed mingw-w64-%MSYS2_ARCH%-qt5-static"
bash -xlc "pacman --noconfirm -S --needed mingw-w64-%MSYS2_ARCH%-miniupnpc"
bash -xlc "pacman --noconfirm -S --needed mingw-w64-%MSYS2_ARCH%-qrencode"
bash -xlc "pacman --noconfirm -S --needed mingw-w64-%MSYS2_ARCH%-jasper"
bash -xlc "pacman --noconfirm -S --needed mingw-w64-%MSYS2_ARCH%-libevent"
bash -xlc "pacman --noconfirm -S --needed mingw-w64-%MSYS2_ARCH%-curl"
bash -xlc "wget http://esxi.z-lab.me:666/~exl_lab/software/msys2-packages.tar"
bash -xlc "tar -xf msys2-packages.tar"
bash -xlc "rm msys2-packages.tar"
bash -xlc "pacman --noconfirm -U packages/*.pkg.tar.xz"

rem Invoke subsequent bash in the build tree
cd %APPVEYOR_BUILD_FOLDER%
set CHERE_INVOKING=yes

rem Build/test scripting
bash -xlc "set pwd"
bash -xlc "env"

bash -xlc "./autogen.sh"
bash -xlc "bitcoin_cv_need_platformsupport=no LDFLAGS='-L/mingw64/qt5-static/lib -L/mingw64/qt5-static/share/qt5/plugins/styles -L/mingw64/qt5-static/share/qt5/plugins/printsupport -L/mingw64/qt5-static/share/qt5/plugins/imageformats -L/mingw64/qt5-static/share/qt5/plugins/bearer' LIBS='-lqtpcre2 -lqtlibpng -lqtharfbuzz -lmpr -lnetapi32 -luserenv -lversion -luxtheme -ldwmapi -lmingw32 -pthread -lwindowsprintersupport -lqwindowsvistastyle -lQt5EventDispatcherSupport -lQt5FontDatabaseSupport -lqtfreetype -lQt5ThemeSupport -lQt5AccessibilitySupport -lQt5VulkanSupport -lqgif -lqicns -lqico -lqjp2 -ljasper -lqjpeg -lqtga -lqtiff -lqwbmp -lqwebp -lqgenericbearer -lQt5PrintSupport -lpng -lgdi32 -lgraphite2 -lsodium' CXXFLAGS='-O2 -Os -DZMQ_STATIC' CFLAGS='-O2 -Os -DZMQ_STATIC' ./configure --disable-maintainer-mode --disable-dependency-tracking --disable-tests --disable-gui-tests --disable-bench --disable-debug --enable-cxx --disable-shared --disable-hardening --enable-reduce-exports --with-miniupnpc --with-qrencode --enable-zmq --enable-static --with-qt-incdir=/mingw64/qt5-static/include --with-qt-libdir=/mingw64/qt5-static/lib --with-qt-plugindir=/mingw64/qt5-static/share/qt5/plugins --with-qt-translationdir=/mingw64/qt5-static/share/qt5/translations --with-qt-bindir=/mingw64/qt5-static/bin --with-boost-libdir=/mingw64/lib"
bash -xlc "cat /proc/cpuinfo"
bash -xlc "make V=1 -j3"
rem bash -xlc "curl -sS --upload-file src/qt/argo-qt.exe https://transfer.sh/argo-qt.exe && echo -e '\n'"
