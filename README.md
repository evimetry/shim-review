This repo is for review of requests for signing shim.  To create a request for review:

- clone this repo
- edit the template below
- add the shim.efi to be signed
- add build logs
- commit all of that
- tag it with a tag of the form "myorg-shim-arch-YYYYMMDD"
- push that to github
- file an issue at https://github.com/rhboot/shim-review/issues with a link to your branch

Note that we really only have experience with using grub2 on Linux, so asking
us to endorse anything else for signing is going to require some convincing on
your part.

Here's the template:

-------------------------------------------------------------------------------
What organization or people are asking to have this signed:
-------------------------------------------------------------------------------
Schatz Forensic Pty. Ltd. 
[https://schatzforensic.com/](https://schatzforensic.com/)

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Evimetry Deadboot v3.2.4.1 
[https://evimetry.com/evimetry-imager/](https://evimetry.com/evimetry-imager/)

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
Our Linux-based forensic OS is used for forensics on bare-metal 
laptops, servers, and virtual computers. This includes both x64 and ia32 based 
secure boot, in addition to earlier BIOS/CSM and non-secureboot UEFI. 

Our kernel includes out of mainline patches supporting write blocking (preventing writes). 

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Bradley Schatz
- Position: Director
- Email address: bradley@schatzforensic.com
- PGP key, signed by the other security contact: https://github.com/evimetry/shim-review/blob/master/keys/blschatz.pub

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Darran Kartaschew
- Position: Development Lead
- Email address: darran@schatzforensic.com
- PGP key, signed by the other security contacts: https://github.com/evimetry/shim-review/blob/master/keys/dkartaschew.pub

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
15 + commits up to a4a1fbe with added patches

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/evimetry/shim

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
Add exact same patches as Ubuntu Shim https://github.com/rhboot/shim-review/issues/82 :

-d/p/Fix-OBJ_create-to-tolerate-a-NULL-sn-and-ln.patch: Fix NULL pointer dereference when calling OBJ_create() that leads to an exception error on arm64. (LP: #1811901)
-debian/patches/MokManager-avoid-unaligned.patch: Fix compilation with GCC9: avoid -Werror=address-of-packed-member errors in MokManager.
-debian/patches/tpm-correctness-1.patch, debian/patches/tpm-correctness-2.patch: fix issues in TPM calls to ensure the measurements are consistent with what is entered in the TPM event log.
-debian/patches/tpm-correctness-3.patch: Don't log duplicate identical TPM events.
-debian/patches/MokManager-hidpi-support.patch: Do a little bit more to try to get a more usable screen resolution for MokManager when running on HiDPI screens; by trying to detect such cases and switching to mode 0.

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
It can be built on the Debian Buster docker image (buster-20191014-slim). A Dockerfile has been supplied at https://github.com/evimetry/shim-review/blob/master/Dockerfile . It can be used to reproduce the entire build. Use like so:

`docker build -f Dockerfile -t evimetry-3.2.4.1-shim-review .`

This was built on Debian Buster (x64) as of 17 Nov 2019.

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
https://github.com/evimetry/shim-review/blob/master/build.log


