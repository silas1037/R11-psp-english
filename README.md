---
title: 如何破解最果てのイマ
date: 2019-10-15 19:09:14
tags:
---

# how to extract / depack / unpack text of Saihate no Ima?



I had read [couldnot unpack](<https://blog.ztjal.info/acg/acg-data/galgame-can-not-unpack-record> )

As a Tanaka Romeo's fake fans, I want to crack it anyway.

It was even taken over by Famille chs group, however they discard it.

It must be unpacked.

It must be unpacked.

It must be unpacked.

record on VN STATs :

| Game title     | Developer | Game engine | [VNDB                                                        | Unique kanji | Line count | MB size | Writer       |
| -------------- | --------- | ----------- | ------------------------------------------------------------ | ------------ | ---------- | ------- | ------------ |
| Saihate no Ima | Xuse      |             | [vndb](https://web.archive.org/web/20170708071728/http://vndb.org/v1278) | 2578         |            | 1.84    | Tanaka Romeo |



way to unpack

My aim is to get text. I use PSP to crack rather than PC.

script files are in `"Q:\PSP_GAME\USRDIR\mac.afs"`, use crass：

```
a_boot.BIP
a_cmn_00.BIP
a_epl_00.BIP
a_epl_01.BIP
a_epl_02.BIP
a_epl_03.BIP
a_prl_01.BIP
a_prl_02.BIP
...
```

Or AFSExplorer or exafs.exe or https://github.com/dreambottle/R11-psp-english/blob/master/unpack-afs.sh> 

For *.bip, Google`PSP "afs" "t2p"`：

<https://github.com/dreambottle/R11-psp-english/blob/master/src/decompressbip.c> 

Otherwise https://github.com/uyjulian/e17p#formats-and-parsers-remember11> 

Ubuntu14.04，`gcc -o exbip decompressbip.c lzss.c`

generate exbip

create `run.sh`:

```shell
for line in `cat file.txt`
do
echo $line
exbip bip/$line $line.txt
done
```

create file.txt:

```
a_boot.BIP
a_cmn_00.BIP
a_epl_00.BIP
a_epl_01.BIP
a_epl_02.BIP
a_epl_03.BIP
a_prl_01.BIP
a_prl_02.BIP
...
```

put all *.bip into bip/，chmod 777，execute run.sh

get *.txt：

```d
Offset      0  1  2  3  4  5  6  7   8  9  A  B  C  D  E  F

000022A0   01 00 00 00 FF FF FF 23  FF FF FF FF 01 00 00 00       #    
000022B0   FF 7F 00 00 FF 7F 00 00  00 00 00 00 00 00 00 18                 
000022C0   00 00 00 00 1E 00 00 00  00 00 00 00 00 00 00 00                   
000022D0   6E 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00   n               
000022E0   FF FF FF FF FF FF FF FF  FF FF FF FF FF FF FF FF   
000022F0   82 BB 82 B5 82 C4 94 45  82 CD 81 41 91 90 8C B4   そして忍は A?原
00002300   82 C9 98 C8 82 F1 82 C5  82 A2 82 BD 81 42 25 4B   に佇んでいた B%K
00002310   25 50 00 89 F9 82 A9 82  B5 82 A2 8F EA 8F 8A 82   %P 懐かしい ?鰍
00002320   BE 81 42 25 4E 82 A2 82  AD 82 C2 82 A9 82 CC 8E   ?B%Nいくつかの?
00002330   76 82 A2 8F 6F 82 AA 82  A0 82 E9 81 42 25 4B 25   vい oがある B%K%
00002340   50 00 82 BD 82 C6 82 A6  82 CE 95 97 82 F0 8E E8   P たとえば風を手
00002350   8C 4A 82 E9 8F 70 82 F0  8A 6F 82 A6 82 BD 82 CC   繰る pを覚えたの

```

extract text out:

loop read 8 byte as`b'\xff\xff\xff\xff\xff\xff\xff\xff' and b'\xff\xff\xff\xff\xff\xff\xff\xff'`then get jp text, remove '\x00'`, replace`b"\x25\x4B\x25\x50"  as %K%P and b"\x25\x4E" as %N to b"\x0D\x0A" as \n`。

Python:

```python
srcdir = "M:/PSP/run/text-TST/1.bip.txt"
outfile = os.path.split(src)[0] + "-Out/" + os.path.split(src)[1]
totalsize = os.path.getsize(src)
fp = open(outfile, "wb") #, encoding="utf-8")
size = 0
flag = 0
with open(src, "rb") as f:
    while size < totalsize:
        a = f.read(8)
        size += 8
        if a == b'\xff\xff\xff\xff\xff\xff\xff\xff':
            a = f.read(8)
            size += 8
            if a == b'\xff\xff\xff\xff\xff\xff\xff\xff':
                flag = 1
        if flag == 1:
            a = f.read(totalsize - size)
            size = totalsize
            a = a.replace(b"\x00", b"").replace(b"\x25\x4B\x25\x50", b"\x0D\x0A").replace(b"\x25\x4E", b"\x0D\x0A")
            fp.write(a)
fp.close()
```

remaining text to solve alone

```
CHAPTER00.BIP.txt
CHAPTER01.BIP.txt
CHAPTER02.BIP.txt
CHAPTER03.BIP.txt
CHAPTER04.BIP.txt
CHAPTER05.BIP.txt
CHAPTER06.BIP.txt
CHAPTER07.BIP.txt
CHAPTER08.BIP.txt
SHORTCUT.BIP.txt
```



get text

```
そして忍は、草原に佇んでいた。
懐かしい場所だ。
いくつかの思い出がある。
……
```

finish

---

