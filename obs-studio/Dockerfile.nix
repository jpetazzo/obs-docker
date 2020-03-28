FROM nixery.dev/shell/cacert/cmake/gcc/git/gnumake/obs-studio/pkgconfig/qt5.qtbase/qt5.qttools/gnugrep
ENV SSL_CERT_FILE=/etc/ssl/certs/ca-bundle.crt
WORKDIR /src
RUN git clone --recursive https://github.com/obsproject/obs-studio.git

RUN git clone https://github.com/CatxFish/obs-v4l2sink.git
WORKDIR obs-v4l2sink
WORKDIR build
RUN cmake -DLIBOBS_INCLUDE_DIR="../../obs-studio/libobs" -DCMAKE_INSTALL_PREFIX=/usr ..
RUN make -j4
RUN make install
WORKDIR /src

# That build doesn't work yet. Can't find some Qt5-related file.

RUN git clone --recursive https://github.com/Palakis/obs-websocket.git
WORKDIR obs-websocket
WORKDIR build
RUN cmake -DLIBOBS_INCLUDE_DIR="../../obs-studio/libobs" -DCMAKE_INSTALL_PREFIX=/usr ..
RUN make -j4
RUN make install
WORKDIR /src
