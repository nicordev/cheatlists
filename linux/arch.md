# arch linux

- [installation guide](https://wiki.archlinux.org/title/Installation_guide)

set keyboard layout

```sh
ls /usr/share/kbd/keymaps/someDirectoryHere/layoutNameHere.map.gz
loadkeys layoutNameHere
```

list disks

```sh
fdisk -l
```

## troubleshooting

- ["Probing edd" hangs](https://unix.stackexchange.com/questions/272701/liveusb-stuck-after-probing-edd-during-boot)

    I had to add 

    ```
    intel_pstate=no_hwp
    ``` 
    
    to the kernel parameters. I did it by pressing [Tab] in the bootloader.