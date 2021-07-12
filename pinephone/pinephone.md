# PinePhone

## [Discord](https://discord.com/channels/463237927984693259/543382344782970881)

- Battery charging:
    Hello everyone,

    I've just received my pinephone beta and I wonder if I can use a power adapter I got from my previous phone, a xiaomi redmi, to recharge my pinephone.

    It's written on the quick start guide that the PinePhone should be charged using a 15W (5V 3A) power adapter. My power adapter output I got with my previous phone, a xiaomi redmi, is 5V 2A.

    I did a quick search but I can't find a straightforward answer of these questions:

    - Do you think I can use my power adapter with my PinePhone or should I look for another power adapter?
    - Can I use my computer USB port to recharge my PinePhone?

    [M] <DaKnig> you can
    [M] <DaKnig> as long as the [V]olts are right...
    [M] <DaKnig> you can use your computer yes
    [M] <DaKnig> but it wont charge as fast
    [M] <DaKnig> you could think of the A number as "how quickly does it charge"
    [I] <gnarface> well if you have usb3 with "pd" (power delivery) enabled it might charge fine
    [I] <gnarface> if you have usb2 or usb3 without "PD" it will trickle-charge slightly faster than the cpu gobbles it up
    [M] <DaKnig> it doesnt need pd or usb3 to charge the pp
    [I] <DusXMT> it does need pd to negotiate a fast charging rate though
    [M] <DaKnig> nope
    [M] <DaKnig> they asked about charging at all
    [M] <DaKnig> which I answered
    [T] <derlafff> anything higher than 5V requires negotiation, so it should generally be safe to just plug and see if it charges (re @p64protocolbot: [M] <@DaKnig> as long as the [V]olts are right...)

- PinePhone locks itself:

    Hello everyone,

    I'm stuck: my pinephone locks itself as soon as I touch any icon, even the chevron used to display applications.

    Do you know how to fix this?

    Earlier today I tried to fix the screen brightness which tends to go very low after a short time by editing this file: ~/.config/powermanagementprofilesrc so maybe I made a mistake editing it.

    But know I can't use the terminal from my phone anymore, it locks itself as soon as I click the terminal icon.

    Could it be possible to interact with my phone from another computer?

    Update: I plugged the phone on my computer and now it does not locks itself for now.

    Update: I was on the terminal, when I unplugged the usb-c cable, then the virtual keyboard went black and the phone locks itself again.

    I plugged the cable again, the phone stopped locking itself.

    So now I can only use my phone when it is plugged to a computer.

    Could somebody give me a default ~/.config/powermanagementprofilesrc file content to see what I did wrong?

    [I] <dsimic> Conifere: you can use SSH to connect to your phone and debug the issue
    [I] <dsimic> Conifere: try deleting that file
    [I] <dsimic> that way you can quickly restore the functionality, if the modifications you made are the culprit

## [Installation](https://wiki.pine64.org/wiki/PinePhone_Installation_Instructions)

Installation to the eMMC
**Using JumpDrive**
Jumpdrive running on the PinePhone

The internal eMMC flash storage can be flashed using the Jumpdrive utility by Danct12 and Martijn from postmarketOS. This utility boots from micro SD and exposes the internal eMMC flash storage when the PinePhone is connected to a computer. The process of flashing an OS to the exposed and mounted eMMC is identical to that of any other storage medium - e.g. a SD card. You can use the dd command or a utility such as Etcher or Gnome Disks, etc.

Latest Jumpdrive can be found here.

1. Download and extract the Jumpdrive image
1. Flash the Jumpdrive image to a micro SD card
1. Boot the PinePhone from the Jumpdrive micro SD card
1. Connect the PinePhone to your computer using USB-A -> USB-C cable
1. Flash the exposed PinePhone drive (e.g. /dev/mm..., check for the right device in dmesg, GNOME disks, or similar, and make sure it's unmounted) with your chosenOS image
1. Once the flashing process is complete, disconnect the PinePhone from your PC, power it down and remove the Jumpdrive SD card
1. The process is now finished, and you can boot from eMMC

The Jumpdrive image is smaller than 50MB. You can keep an SD card specifically for using Jumpdrive, and there are 64MB micro SD cards sold cheaply that will suffice. Jumpdrive also acts as a rescue image in case if you messed up your installation. To do so, you can telnet to 172.16.42.1, mount rootfs and fix it!
From the booted microSD OS

1. Flash an OS to the SD card (and optionally resize the partition, see below)
1. Insert SD card and boot the phone
1. Download the desired OS' image on the booted OS or transfer it to the SD card
1. Extract the image file if it is archived
1. Flash the image file to eMMC using dd if=new-pinephone-image.img of=/dev/mmcblkX bs=1M status=progress conv=fsync where X is the number label of the eMMC (of the disk, not the partition!). Use the command lsblk to check your devices: typically with the current kernel the SD card is /dev/mmcblk0 and the eMMC is /dev/mmcblk2 but as always with dd be extremely cautious to get the devices correct.
1. Turn off phone, remove SD card and then turn on the phone.