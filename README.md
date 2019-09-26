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
Schatz Forensic Pty. Ltd. https://schatzforensic.com/

-------------------------------------------------------------------------------
What product or service is this for:
-------------------------------------------------------------------------------
Evimetry Deadboot v3.2.4.1 https://evimetry.com/

-------------------------------------------------------------------------------
What's the justification that this really does need to be signed for the whole world to be able to boot it:
-------------------------------------------------------------------------------
Our linux-based forensic OS is used by forensic practitioners for forensics on bare metal 
laptops, servers, and cloud based virtual computers. This includes both x64 and ia32 based 
secure boot. Our kernel includes out of mainline patches supporting write blocking (preventing writes).

-------------------------------------------------------------------------------
Who is the primary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Bradley Schatz
- Position: Director
- Email address: bradley@schatzforensic.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community:

-------------------------------------------------------------------------------
Who is the secondary contact for security updates, etc.
-------------------------------------------------------------------------------
- Name: Darran Kartaschew
- Position: Development Lead
- Email address: darran@schatzforensic.com
- PGP key, signed by the other security contacts, and preferably also with signatures that are reasonably well known in the linux community:

-------------------------------------------------------------------------------
What upstream shim tag is this starting from:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/releases/tag/15

-------------------------------------------------------------------------------
URL for a repo that contains the exact code which was built to get this binary:
-------------------------------------------------------------------------------
https://github.com/rhboot/shim/releases/tag/15

-------------------------------------------------------------------------------
What patches are being applied and why:
-------------------------------------------------------------------------------
None

-------------------------------------------------------------------------------
What OS and toolchain must we use to reproduce this build?  Include where to find it, etc.  We're going to try to reproduce your build as close as possible to verify that it's really a build of the source tree you tell us it is, so these need to be fairly thorough. At the very least include the specific versions of gcc, binutils, and gnu-efi which were used, and where to find those binaries.
-------------------------------------------------------------------------------
It can be built on the Debian bionic docker image. A Dockerfile has been supplied at XXX. It can be used to reproduce the entire build using the release tarball from github. Use like so:

sudo docker build -f Dockerfile -t evimetry-3.2.4.1-shim-review .

-------------------------------------------------------------------------------
Which files in this repo are the logs for your build?   This should include logs for creating the buildroots, applying patches, doing the build, creating the archives, etc.
-------------------------------------------------------------------------------
https://github.com/evimetry/shim-review/build.log


