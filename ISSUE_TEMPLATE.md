Make sure you have provided the following information:

 - [ ] link to your code branch cloned from rhboot/shim-review in the form user/repo@tag
 - [ ] completed README.md file with the necessary information
 - [ ] shim.efi to be signed
 - [ ] public portion of your certificate embedded in shim (the file passed to VENDOR_CERT_FILE)
 - [ ] any extra patches to shim via your own git tree or as files
 - [ ] any extra patches to grub via your own git tree or as files
 - [ ] build logs


###### What organization or people are asking to have this signed:
Schatz Forensic Pty. Ltd. 
https://schatzforensic.com


###### What product or service is this for:
Evimetry Deadboot v3.2.4.1 
https://evimetry.com/evimetry-imager/

###### What is the origin and full version number of your shim?
https://github.com/rhboot/shim/tree/15 + commits up to 
https://github.com/rhboot/shim/commit/3beb971b10659cf78144ddc5eeea83501384440c

* Single patch added from shim-16 https://github.com/rhboot/shim/commit/741c61abba7d5c74166f8d0c1b9ee8001ebcd186
	- Make EFI variable copying fatal only on secureboot enabled systems


###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
Our linux-based forensic OS is used for forensics on bare-metal 
laptops, servers, and virtual computers. This includes both x64 and ia32 based 
secure boot, in addition to earlier BIOS/CSM and non-secureboot UEFI. 

Our kernel includes out of mainline patches supporting write blocking (preventing writes). 

###### How do you manage and protect the keys used in your SHIM?
Key material stored in an offline HSM.

###### Do you use EV certificates as embedded certificates in the SHIM?
No.

###### What is the origin and full version number of your bootloader (GRUB or other)?
Grub 2.04 https://ftp.gnu.org/gnu/grub/grub-2.04.tar.gz + 
current Debian patches https://salsa.debian.org/grub-team/grub/tree/master/debian/patches

The patches are identical to those approved in https://github.com/rhboot/shim-review/issues/67

###### If your SHIM launches any other components, please provide further details on what is launched
Only the above Grub is launched. 

###### How do the launched components prevent execution of unauthenticated code?
The above Grub includes the right patches to prevent unauthenticated execution of 
unsigned kernels. 

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No.

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
Our kernel is based off Debian's 4.19.67-2 kernel, which includes the Lockdown patches. 

###### What changes were made since your SHIM was last signed?
First time signing.

###### What is the hash of your final SHIM binary?
7dfbdbcc1736aab5e477762135825f27fc64c5a8644d35b1b7a9b5db74c848d0  /build/target/shimia32.efi
ee862a43d716c7dcc6854ed35ee1e1b069279e236571f31b7a644fe8f9f68529  /build/target/shimx64.efi
