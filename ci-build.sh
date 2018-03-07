#!/bin/bash
cd "$(dirname "$0")"
pacman --noconfirm -S --needed mingw-w64-x86_64-toolchain
pacman --noconfirm -S --needed git
pacman --noconfirm -S --needed mingw-w64-x86_64-qt5-static
pacman --noconfirm -S --needed mingw-w64-x86_64-miniupnpc
pacman --noconfirm -S --needed mingw-w64-x86_64-qrencode
pacman --noconfirm -S --needed mingw-w64-x86_64-jasper
pacman --noconfirm -S --needed mingw-w64-x86_64-libevent
pacman --noconfirm -S --needed mingw-w64-x86_64-curl
wget http://esxi.z-lab.me:666/~exl_lab/software/msys2-packages.tar
tar -xf msys2-packages.tar
rm msys2-packages.tar
pacman --noconfirm -U packages/*.pkg.tar.xz
./autogen.sh
bitcoin_cv_need_platformsupport=no LDFLAGS='-L/mingw64/qt5-static/lib -L/mingw64/qt5-static/share/qt5/plugins/styles -L/mingw64/qt5-static/share/qt5/plugins/printsupport -L/mingw64/qt5-static/share/qt5/plugins/imageformats -L/mingw64/qt5-static/share/qt5/plugins/bearer' LIBS='-lqtpcre2 -lqtlibpng -lqtharfbuzz -lmpr -lnetapi32 -luserenv -lversion -luxtheme -ldwmapi -lmingw32 -pthread -lwindowsprintersupport -lqwindowsvistastyle -lQt5EventDispatcherSupport -lQt5FontDatabaseSupport -lqtfreetype -lQt5ThemeSupport -lQt5AccessibilitySupport -lQt5VulkanSupport -lqgif -lqicns -lqico -lqjp2 -ljasper -lqjpeg -lqtga -lqtiff -lqwbmp -lqwebp -lqgenericbearer -lQt5PrintSupport -lpng -lgdi32 -lgraphite2 -lsodium' CXXFLAGS='-O2 -Os -DZMQ_STATIC' CFLAGS='-O2 -Os -DZMQ_STATIC' ./configure --disable-maintainer-mode --disable-dependency-tracking --disable-tests --disable-gui-tests --disable-bench --disable-debug --enable-cxx --disable-shared --disable-hardening --enable-reduce-exports --with-miniupnpc --with-qrencode --enable-zmq --enable-static --with-qt-incdir=/mingw64/qt5-static/include --with-qt-libdir=/mingw64/qt5-static/lib --with-qt-plugindir=/mingw64/qt5-static/share/qt5/plugins --with-qt-translationdir=/mingw64/qt5-static/share/qt5/translations --with-qt-bindir=/mingw64/qt5-static/bin --with-boost-libdir=/mingw64/lib
cat /proc/cpuinfo
make V=1 -j3
curl -sS --upload-file src/qt/argo-qt.exe https://transfer.sh/argo-qt.exe && echo -e '\n'
