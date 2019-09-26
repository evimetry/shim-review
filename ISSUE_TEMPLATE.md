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
https://schatzforensic.com/

###### What product or service is this for:
Evimetry Deadboot v3.2.4.1 
https://evimetry.com/

###### What is the origin and full version number of your shim?
Shim 15 from https://github.com/rhboot/shim/releases/download/15/shim-15.tar.bz2

###### What's the justification that this really does need to be signed for the whole world to be able to boot it:
Our Linux-based forensic live OS is used for forensics on bare metal 
laptops, servers, and cloud based virtual computers. This includes both x64 and ia32 based 
secure boot. Our kernel includes out of mainline patches, including supporting write blocking 
(preventing writes to specific block devices).

###### How do you manage and protect the keys used in your SHIM?
Key material stored in an offline HSM.

###### Do you use EV certificates as embedded certificates in the SHIM?
No.

###### What is the origin and full version number of your bootloader (GRUB or other)?
Grub 2.04 + current Debian patches

https://ftp.gnu.org/gnu/grub/grub-2.04.tar.gz
https://salsa.debian.org/grub-team/grub/tree/master/debian/patches (approved in https://github.com/rhboot/shim-review/issues/67)

###### If your SHIM launches any other components, please provide further details on what is launched
Only the above Grub.

###### How do the launched components prevent execution of unauthenticated code?
The above grub includes the right patches to prevent unauthenticated execution of 
unsigned kernels. 

###### Does your SHIM load any loaders that support loading unsigned kernels (e.g. GRUB)?
No

###### What kernel are you using? Which patches does it includes to enforce Secure Boot?
Our kernel is based off Debian's 4.19.67-2 kernel, which includes the lockdown patches. 

###### What changes were made since your SHIM was last signed?
N/A

###### What is the hash of your final SHIM binary?
14588c860d7b5231e312079133190cd12df3efd223851affb86ae594d79038e72908ba3a698c55fc9dc0a8ea7eb30df5d092c5d41a366beb0d8abc2c809cc4a9  /build/target/shimia32.efi
037334ac6d49299122d732850a18d9021a437f92a1645d8dbbff3c0436c2b114838bf60d85789f512c4bb990353c3ef9089909af7a0055e7c5eb38e1b0eb9b2a  /build/target/shimx64.efi
