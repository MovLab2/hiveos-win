Z-ENEMY VER 1.10 (PUBLIC)

For Windows (Cuda 9.1)
zealot/enemy-1.10 (z-enemy)  From: Dk & Enemy

- Fixed compatibility issues that resulted in performance degradation with some non-yiimp pools. Now you'll see the expected hashrate on them (suprnova).

- Kernels speed improvements : +1-2% total (all algos) and +1-2% for x16r &x16s.

- Support & impove new algo : Tribus (-a tribus) , recommended intensity for Tribus 20-21. +5% speed vs 1.09b ( Service release)

https://mega.nz/#!tHZ0zJBL!la-zehh3Khsz2EoN5Ayr0vAZIBpmHIpgwokfTssu414


This release is reported to be more stable when it comes to higher PL or overclocking, feel free to experiment with it.
______________________________________
First time or troubleshooting x16:
-   First time users - ver. 1.10 works on Cuda 9.1 and it is recommended to make sure you've updated your NVIDIA drivers. You can find drivers here: http://www.nvidia.com/Download/index.aspx ver., 390+++
-   Next important thing is intensity. We recommend intensity -19 at first, however if your PC has 8GB or more, fast SSD, and big swap file on it you may use -20/21.
-   X16r algo is very wild and eratic.  *Very important*  Make sure to have enough power reserve on PSU. Please be sure you have a minimum 20% headroom on your PSU or set your PL on 70-80% usage.
-   Using +core and +mem is useful but, use no OC at first until you verify stability. 


Performance and fine tuning x16: 
-   This release z-enemy 1.08 is reported to be more stable when it using higher PL (90-110%) and +core and +memory overclocking, feel free to experiment with it.
-   Updating drivers can provide more gains
-   Recommended intensity is 20, set 21 only if you know what you are doing. ( 16GB RAM or/and good SWAP file on SSD) Use caution
-   Recommended memory   0 or + 200
-   Recommended core +50+150 ( 1800-1900MHz 1080 Ti)
-   Overclock slowly and allow plenty of time to verify stability (12-24hrs) before making anymore adjustments. x16r is a very chaotic algorithm so just because it works for 1 hr doesn't mean you can't crash over longer time. Sometimes hash order can lead to 2000+mhz and crash system. Keep in mind – overclocking is always at your own risk!
-   Yiimp pools recommend  manual diff (-p d=16) - for  small farms or  (-p d=48 ) - for good farms like 5-6 1080 Ti   If you need to name your rigs as well as set diff you may try -p rigname,d=16
