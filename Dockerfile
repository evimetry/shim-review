FROM debian:buster

RUN apt-get -y -qq update
RUN apt-get -y -qq install build-essential git sbsigntool gnu-efi libnss3-tools libpopt-dev libnss3-dev libefivar-dev uuid-dev pesign bison flex libdevmapper-dev wget
WORKDIR /build
RUN wget https://github.com/rhboot/shim/releases/download/15/shim-15.tar.bz2
RUN bzip2 -dc shim-15.tar.bz2 | tar xvf -
WORKDIR /build/shim-15
COPY sf-secureboot-signing.der /build/shim-15
COPY 01-shim-debian-paths.patch /build/
RUN cat /build/01-shim-debian-paths.patch | patch -p1 
RUN mkdir /build/target/
RUN mkdir /usr/lib/gnuefi/
RUN mkdir -p /usr/lib32/gnuefi/
RUN mkdir -p /usr/lib64/gnuefi/
RUN ln -s /usr/lib/crt0-efi-x86_64.o /usr/lib/gnuefi/crt0-efi-x86_64.o
RUN ln -s /usr/lib32/crt0-efi-ia32.o /usr/lib32/gnuefi/crt0-efi-ia32.o
RUN ln -s /usr/lib/crt0-efi-x86_64.o /usr/lib64/gnuefi/crt0-efi-x86_64.o
RUN make VENDOR_CERT_FILE=sf-secureboot-signing.der 
RUN mv shimx64.efi /build/target/
RUN make clean ; exit 0
WORKDIR /build/shim-15/Cryptlib/OpenSSL/
RUN make clean ; exit 0
WORKDIR /build/shim-15
RUN setarch linux32 make ARCH=ia32 VENDOR_CERT_FILE=sf-secureboot-signing.der
RUN mv shimia32.efi /build/target/
RUN sha256sum /build/target/*