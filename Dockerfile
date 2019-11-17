FROM debian:buster-20191014

RUN apt-get -y -qq update
RUN apt-get -y -qq install build-essential git gnu-efi libpopt-dev libefivar-dev uuid-dev
WORKDIR /build
RUN git clone https://github.com/rhboot/shim.git
WORKDIR /build/shim
RUN git checkout 3beb971b10659cf78144ddc5eeea83501384440c
COPY sf-secureboot-signing.der /build/shim
COPY 0001-MokListRT-Fatal.patch /build/
RUN cat /build/0001-MokListRT-Fatal.patch | patch -p1
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