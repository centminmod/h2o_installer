#!/bin/bash
#################################################################
# nghttp2 installer for CentOS 6.x based on CentminMod.com LEMP
# web stack environment by George Liu (eva2000) vbtechsupport.com
#################################################################
# nghttp2 https://github.com/tatsuhiro-t/nghttp2
# spdylay https://github.com/tatsuhiro-t/spdylay
# https://github.com/centminmod/h2o_installer/blob/master/nghttp2/nghttp2_info.md
#################################################################
BASEINSTALL_DIR=/svr-setup

#################################################################
# functions
if [ -f /proc/user_beancounters ]; then
    CPUS=`cat "/proc/cpuinfo" | grep "processor"|wc -l`
    CPUS=$(echo $CPUS+1 | bc)
    MAKETHREADS=" -j$CPUS"
else
    # speed up make
    CPUS=`cat "/proc/cpuinfo" | grep "processor"|wc -l`
    CPUS=$(echo $CPUS+1 | bc)
    MAKETHREADS=" -j$CPUS"
fi

if [ ! -f /usr/local/bin/python2.7 ]; then
	echo
	echo "Python 2.7 not found"
	echo "Install Python 2.7.9 via Centmin Mod Addon at"
	echo "addons/python27_install.sh"
	echo
	echo "chmod 0700 python27_install.sh"
	echo "./python27_install.sh install"
	echo
	echo "then re-run nghttp2_install.sh"
	exit
fi
#################################################################
# yum packages required
echo
echo "yum packages"
yum -y remove boost boost-devel boost-system boost-filesystem boost-thread
yum -y install jemalloc jemalloc-devel jansson jansson-devel libxml2 libxml2-devel libxml2-static redhat-lsb-core libev libev-devel CUnit CUnit-devel clang clang-devel

#################################################################
echo
echo "---------------------------------------------------"
echo "update to gcc 4.8.4 + boost 1.5.7 etc"
echo "---------------------------------------------------"
echo "can take hours to compile"
mkdir -p /opt/
mkdir -p /opt/gcc484
cd /opt/gcc484
git clone https://github.com/centminmod/gcc-4.8.4-boost-1.57.git 4.8.4
cd 4.8.4
time make${MAKETHREADS}

echo
echo "clean up gcc / boost build files"
rm -rf /opt/gcc484/4.8.4/bld
rm -rf /opt/gcc484/4.8.4/src
rm -rf /opt/gcc484/4.8.4/logs
rm -rf /opt/gcc484/4.8.4/archives

MY_GXX_HOME="/opt/gcc484/4.8.4/rtf"
export PATH="${MY_GXX_HOME}/bin:${PATH}"
export LD_LIBRARY_PATH="${MY_GXX_HOME}/lib:${MY_GXX_HOME}/lib64:${LD_LIBRARY_PATH}"
export LD_RUN_PATH="${MY_GXX_HOME}/lib:${MY_GXX_HOME}/lib64:${LD_LIBRARY_PATH}"

#################################################################
echo
echo "---------------------------------------------------"
echo "install autoconf 2.69"
echo "---------------------------------------------------"
cd ${BASEINSTALL_DIR}
wget -cnv http://ftp.gnu.org/gnu/autoconf/autoconf-2.69.tar.gz

echo "update autoconf 2.69"
cd ${BASEINSTALL_DIR}
tar xzf autoconf-2.69.tar.gz
cd autoconf-2.69
make clean
./configure
make
make install
/usr/local/bin/autoconf -V

#################################################################
echo
echo "---------------------------------------------------"
echo "install openssl 1.0.2"
echo "---------------------------------------------------"
mkdir ${BASEINSTALL_DIR}/nghttp2_openssl
cd ${BASEINSTALL_DIR}/nghttp2_openssl
wget --no-check-certificate https://www.openssl.org/source/openssl-1.0.2.tar.gz
tar xzf openssl-1.0.2.tar.gz
cd openssl-1.0.2
./config shared enable-ec_nistp_64_gcc_128 --prefix=/usr/local/http2-15
make${MAKETHREADS}
make install

#################################################################
echo
echo "---------------------------------------------------"
echo "install libevent 2.0.21"
echo "---------------------------------------------------"
# libevent 2.0.21
mkdir ${BASEINSTALL_DIR}/nghttp2_libevent21
cd ${BASEINSTALL_DIR}/nghttp2_libevent21
wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz
tar xzf libevent-2.0.21-stable.tar.gz
cd libevent-2.0.21-stable
CFLAGS=-I/usr/local/http2-15/include CXXFLAGS=-I/usr/local/http2-15/include LDFLAGS=-L/usr/local/http2-15/lib ./configure --prefix=/usr/local/http2-15
make${MAKETHREADS}
make install

#################################################################
echo
echo "---------------------------------------------------"
echo "install libev 4.19"
echo "---------------------------------------------------"
mkdir ${BASEINSTALL_DIR}/nghttp2_libev
cd ${BASEINSTALL_DIR}/nghttp2_libev
wget http://dist.schmorp.de/libev/libev-4.19.tar.gz
tar xzf libev-4.19.tar.gz
cd libev-4.19
CFLAGS=-I/usr/local/http2-15/include CXXFLAGS=-I/usr/local/http2-15/include LDFLAGS=-L/usr/local/http2-15/lib ./configure --prefix=/usr/local/http2-15
make${MAKETHREADS}
make install

#################################################################
echo
echo "---------------------------------------------------"
echo "install newer zlib version"
echo "---------------------------------------------------"
mkdir ${BASEINSTALL_DIR}/nghttp2_zlib
cd ${BASEINSTALL_DIR}/nghttp2_zlib
wget http://zlib.net/zlib-1.2.8.tar.gz
tar xzf zlib-1.2.8.tar.gz
cd zlib-1.2.8
./configure --prefix=/usr/local/http2-15
make${MAKETHREADS}
make install

#################################################################
echo
echo "---------------------------------------------------"
echo "install libxml2 newer version"
echo "---------------------------------------------------"
mkdir ${BASEINSTALL_DIR}/nghttp2_libxml2
cd ${BASEINSTALL_DIR}/nghttp2_libxml2
wget http://xmlsoft.org/sources/libxml2-2.9.2.tar.gz
tar xzf libxml2-2.9.2.tar.gz
cd libxml2-2.9.2
./configure --prefix=/usr/local/http2-15
make${MAKETHREADS}
make install

#################################################################
echo
echo "---------------------------------------------------"
echo "install cython newer version"
echo "---------------------------------------------------"
mkdir ${BASEINSTALL_DIR}/nghttp2_cython
cd ${BASEINSTALL_DIR}/nghttp2_cython
wget http://cython.org/release/Cython-0.22.tar.gz
tar xzf Cython-0.22.tar.gz
cd Cython-0.22
python setup.py install

#################################################################
echo
echo "---------------------------------------------------"
echo "install spdylay via git"
echo "---------------------------------------------------"
mkdir ${BASEINSTALL_DIR}/nghttp2_spdylay
cd ${BASEINSTALL_DIR}/nghttp2_spdylay
git clone https://github.com/tatsuhiro-t/spdylay.git
cd spdylay
(cd m4 && wget http://keithr.org/eric/src/whoisserver-nightly/m4/am_path_xml2.m4)
/usr/local/bin/autoreconf -i --force
PKG_CONFIG_PATH=/usr/local/http2-15/lib/pkgconfig ./configure --prefix=/usr/local/http-15
make${MAKETHREADS}
make install

#################################################################
echo
echo "---------------------------------------------------"
echo "install nghttp2 via git"
echo "---------------------------------------------------"
mkdir ${BASEINSTALL_DIR}/nghttp2_git
cd ${BASEINSTALL_DIR}/nghttp2_git
git clone https://github.com/tatsuhiro-t/nghttp2.git
cd ${BASEINSTALL_DIR}/nghttp2_git/nghttp2
make clean
(cd m4 && wget http://keithr.org/eric/src/whoisserver-nightly/m4/am_path_xml2.m4)
/usr/local/bin/autoreconf -i --force
PKG_CONFIG_PATH=/usr/local/http2-15/lib/pkgconfig ./configure --prefix=/usr/local/http2-15 --enable-app --with-xml-prefix=/usr/local/http2-15 LIBSPDYLAY_CFLAGS="-I/usr/local/http-15/include" LIBSPDYLAY_LIBS="-L/usr/local/http-15/lib -lspdylay" ZLIB_CFLAGS="-I/usr/local/http2-15/include" ZLIB_LIBS="-L/usr/local/http-15/lib" CFLAGS="-I/usr/local/http2-15/include" CXXFLAGS="-I/usr/local/http2-15/include" LDFLAGS="-L/usr/local/http2-15/lib" PYTHON_VERSION=2.7 PYTHON_CPPFLAGS="-I/usr/local/include/python2.7" PYTHON_LDFLAGS="-L/usr/local/lib -lpython2.7"
make${MAKETHREADS}
make check
make install

echo
echo "---------------------------------------------------"
echo "/usr/local/http2-15/bin/nghttp -h
/usr/local/http2-15/bin/nghttpd -h
/usr/local/http2-15/bin/nghttpx -h
/usr/local/http2-15/bin/h2load -h"

echo
echo "---------------------------------------------------"
echo "All binaries located at /usr/local/http2-15/bin/"
ls -lhrt /usr/local/http2-15/bin/

echo
echo "---------------------------------------------------"
echo "installation completed"
echo "---------------------------------------------------"

exit