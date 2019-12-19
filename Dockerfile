FROM debian:buster-20191014-slim

RUN apt-get -y -qq update
RUN apt-get -y -qq install build-essential git gnu-efi libpopt-dev libefivar-dev uuid-dev
WORKDIR /build
RUN git clone https://github.com/rhboot/shim.git
WORKDIR /build/shim
RUN git checkout a4a1fbe728c9545fc5647129df0cf1593b953bec 
COPY sf-secureboot-signing.der /build/shim
COPY patches/Fix-OBJ_create-to-tolerate-a-NULL-sn-and-ln.patch /build/
COPY patches/MokManager-hidpi-support.patch /build/
COPY patches/MokManager-avoid-unaligned.patch /build/
COPY patches/tpm-correctness-1.patch /build/
COPY patches/tpm-correctness-2.patch /build/
COPY patches/tpm-correctness-3.patch /build/
RUN cat /build/Fix-OBJ_create-to-tolerate-a-NULL-sn-and-ln.patch | patch -p1
RUN cat /build/MokManager-hidpi-support.patch | patch -p1
RUN cat /build/MokManager-avoid-unaligned.patch | patch -p1
RUN cat /build/tpm-correctness-1.patch | patch -p1
RUN cat /build/tpm-correctness-2.patch | patch -p1
RUN cat /build/tpm-correctness-3.patch | patch -p1
RUN mkdir /build/target/
RUN mkdir /usr/lib/gnuefi/
RUN mkdir -p /usr/lib32/gnuefi/
RUN ln -s /usr/lib/crt0-efi-x86_64.o /usr/lib/gnuefi/crt0-efi-x86_64.o
RUN ln -s /usr/lib32/crt0-efi-ia32.o /usr/lib32/gnuefi/crt0-efi-ia32.o
RUN make VENDOR_CERT_FILE=sf-secureboot-signing.der LIBDIR=/usr/lib
RUN mv shimx64.efi /build/target/
RUN make clean ; exit 0
WORKDIR /build/shim/Cryptlib/OpenSSL/
RUN make clean ; exit 0
WORKDIR /build/shim
COPY sf-secureboot-signing.der /build/shim
RUN setarch linux32 make ARCH=ia32 VENDOR_CERT_FILE=sf-secureboot-signing.der LIBDIR=/usr/lib32 
RUN mv shimia32.efi /build/target/
RUN sha256sum /build/target/*