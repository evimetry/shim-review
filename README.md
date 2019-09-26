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
Our linux-based forensic OS is used for forensics on bare-metal 
laptops, servers, and virtual computers. This includes both x64 and ia32 based 
secure boot, in addition to earlier BIOS/CSM and non-secureboot UEFI. 

Our kernel includes out of mainline patches supporting write blocking (preventing writes). 

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Bradley Schatz
- Position: Director
- Email address: bradley@schatzforensic.com
- PGP key, signed by the other security contact: https://github.com/evimetry/shim-review/keys/blschatz.pub

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Darran Kartaschew
- Position: Development Lead
- Email address: darran@schatzforensic.com
- PGP key, signed by the other security contacts: https://github.com/evimetry/shim-review/keys/dkartaschew.pub

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/tree/15 + commits up to 
https://github.com/rhboot/shim/commit/3beb971b10659cf78144ddc5eeea83501384440c

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/evimetry/shim/tree/shim-review

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
Single patch added from shim-16 for broad compatibility with non-secureboot UEFI implementations.
* https://github.com/rhboot/shim/commit/741c61abba7d5c74166f8d0c1b9ee8001ebcd186
	- Make EFI variable copying fatal only on secureboot enabled systems



-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
It can be built on the Debian Bionic docker image. A Dockerfile has been supplied at https://github.com/evimetry/shim-review/Dockerfile . It can be used to reproduce the entire build. Use like so:

`docker build -f Dockerfile -t evimetry-3.2.4.1-shim-review .`

This was built on Debian Bionic (x64) as of 26 Sept 2019.

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
https://github.com/evimetry/shim-review/build.log


