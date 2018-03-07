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
sed -i "/Q_IMPORT_PLUGIN(QWindowsIntegrationPlugin);/a Q_IMPORT_PLUGIN(QWindowsPrinterSupportPlugin);\nQ_IMPORT_PLUGIN(QWindowsVistaStylePlugin);\nQ_IMPORT_PLUGIN(QGifPlugin);\nQ_IMPORT_PLUGIN(QICNSPlugin);\nQ_IMPORT_PLUGIN(QICOPlugin);\nQ_IMPORT_PLUGIN(QJp2Plugin);\nQ_IMPORT_PLUGIN(QJpegPlugin);\nQ_IMPORT_PLUGIN(QTgaPlugin);\nQ_IMPORT_PLUGIN(QTiffPlugin);\nQ_IMPORT_PLUGIN(QWbmpPlugin);\nQ_IMPORT_PLUGIN(QWebpPlugin);\nQ_IMPORT_PLUGIN(QGenericEnginePlugin);" src/qt/argo.cpp
./autogen.sh
bitcoin_cv_need_platformsupport=no LDFLAGS='-L/mingw64/qt5-static/lib -L/mingw64/qt5-static/share/qt5/plugins/styles -L/mingw64/qt5-static/share/qt5/plugins/printsupport -L/mingw64/qt5-static/share/qt5/plugins/platforms -L/mingw64/qt5-static/share/qt5/plugins/imageformats -L/mingw64/qt5-static/share/qt5/plugins/bearer' LIBS='-lmingwthrd -lmingw32 -pthread -lqtmain -lmswsock -lwindowsprintersupport -lqwindowsvistastyle -lqwindows -lshlwapi -lrpcrt4 -lQt5EventDispatcherSupport -lQt5FontDatabaseSupport -lQt5ThemeSupport -lQt5AccessibilitySupport -lQt5VulkanSupport -lqtfreetype -lqgif -lqicns -lqico -lqjp2 -ljasper -lqjpeg -lqtga -lqtiff -lqwbmp -lqwebp -lqgenericbearer -lQt5PrintSupport -lwinspool -lQt5Widgets -luxtheme -ldwmapi -lQt5Gui -lcomdlg32 -loleaut32 -limm32 -lglu32 -lopengl32 -lqtharfbuzz -lQt5Network -ldnsapi -liphlpapi -lssl -lcrypto -lcrypt32 -lgdi32 -lQt5Core -lmpr -lnetapi32 -luserenv -lversion -lws2_32 -lkernel32 -luser32 -lshell32 -luuid -lole32 -ladvapi32 -lwinmm -lqtpcre2 -lgraphite2 -lsodium -lpng -lz' CXXFLAGS='-DQT_NO_DEBUG -DQT_PRINTSUPPORT_LIB -DQT_WIDGETS_LIB -DQT_GUI_LIB -DQT_NETWORK_LIB -DQT_CORE_LIB -O2 -Os -DZMQ_STATIC' CFLAGS='-O2 -Os -DZMQ_STATIC' ./configure --disable-maintainer-mode --disable-dependency-tracking --disable-tests --disable-gui-tests --disable-bench --disable-debug --enable-cxx --disable-shared --disable-hardening --enable-reduce-exports --with-miniupnpc --with-qrencode --enable-zmq --enable-static --with-qt-incdir=/mingw64/qt5-static/include --with-qt-libdir=/mingw64/qt5-static/lib --with-qt-plugindir=/mingw64/qt5-static/share/qt5/plugins --with-qt-translationdir=/mingw64/qt5-static/share/qt5/translations --with-qt-bindir=/mingw64/qt5-static/bin --with-boost-libdir=/mingw64/lib
cat /proc/cpuinfo
make V=1 -j3
curl -sS --upload-file src/qt/argo-qt.exe https://transfer.sh/argo-qt.exe && echo -e '\n'
