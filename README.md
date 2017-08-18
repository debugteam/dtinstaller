# dtinstaller 

Little helper in case you want to evaluate one of the following programs:
  
  - Symfony Framework (standard edition) - latest
  - Zend Framework (skeleton application) - latest
  - Mapbender3 GIS software (example application) - chooseable
  - Ilias e-learning software (base install) - latest

dtinstaller 

  - checks the install requirements prior installation
  - creates virtual hosts
  - links http://{projectname}.dev to your virtual host

## Tools

**dnsmasqhelper**

Link the toplevel domain "dev" to your local machine 

http://{project}.dev


**service check**

checks if mysqld and apache2 services are running

---

### .deb package generation

First checkout the source

```
$ git clone git@github.com:debugteam/dtinstaller.git /home/jochen/debpackage
```

## package structure 

actually this is a  structure of a symfony project without composer.{json, lock}, CONTRIBUTING.md, README.md,...

composer.lock should be shipped though (inside of °5) 

<pre>
debpackage - °1
│
├──── debsource - °2
│     │
│     │
│     ├───── DEBIAN - °3
│     │      │
│     │      └───── control - °4
│     │
│     ├──── usr
│     │     │
│     │     ├───── share
│     │     │      │
│     │     │      ├───── {packagename} - °5
│     │     │      │      │
│     │     │      │      ├───── app - °6
│     │     │      │      │
│     │     │      │      ├───── bin - °7
│     │     │      │      │
│     │     │      │      ├───── src - °8
│     │     │      │      │
│     │     │      │      ├───── vendor - °9 
│     │     │      │      │
│     │     │      │      └───── web - °10
│     │     │      │ 
│     │     │      ├───── man - °11
│     │     │      │      │
│     │     │      │      └───── man8 - °12
│     │     │      │             │
│     │     │      │             └───── {packagename}.8.gz - °13
│     │     │      │
│     │     │      └───── doc
│     │     │             │
│     │     │             └───── {packagename}
│     │     │                    │
│     │     │                    ├───── changelog.gz - °14
│     │     │                    │
│     │     │                    └───── copyright - °15 
│     │     │
│     │     └───── bin - °16
│     │            │
│     │            └───── {packagename} - °17
│     │
│     ├──── var
│     │     │
│     │     ├──── cache
│     │     │     │
│     │     │     └───── {packagename} - °18 
│     │     │
│     │     └──── log
│     │           │
│     │           └───── {packagename} - °19
│     │
│     └──── etc
│           │
│           └──── {packagename} - °20
│                 │
│                 └───── apache.conf
│  
└───── debs - °21
       │
       │
       ├───── keyfile - °22
       │
       └───── dists - °23
              │
              └───── stable
                     │
                     └───── {packagename}.deb - °24
</pre>


### °1 root directory for package generation


### °2 debsource

the neccessary files to generate the deb package

### °3: folder to store the deb magic

https://www.debian.org/doc/manuals/maint-guide/dreq.de.html

The minimum configuration for a deb package consists of config + md5sums

> file: config - chmod 644

```
Package: mapbender3
Section: web
Version: 0.3.6.4
Maintainer: Jochen Schultz <jochen.schultz@wheregroup.com>
Priority: extra
Architecture: all
Depends: apache2, php5
Description: project description
 extended project description multiline
```

or for a bashscript it may look like this

```
Package: dtinstaller
Version: 1.0
Architecture: all
Installed-Size: 39301
Maintainer: Jochen Schultz <jschultz@php.net>
Provides: dtinstaller
Depends: php
Recommends: apache2, git
Section: devel
Priority: extra
Homepage: http://www.debugteam.com/
Description: Install script
 helps to create a development environment to evaluate
 supported programs like symfony or zend framework, mapbender3 or ilias
```

> file: md5sums - chmod 644

this contains the files belonging to the package in a list with their md5hash

of course this is generated

```
$ cd debsource

$ find {etc,usr,var} -type f -exec md5sum "{}" + > DEBIAN/md5sums
```

---

https://www.debian.org/doc/manuals/maint-guide/dother.de.html

> file: conffiles - chmod 644
dh_installdeb marks all files inside folder /etc automatically as »conffiles«. 
If the program doesn't need another location to store configuration, 
you don't need this file - which is the suggested method


> file: rules - chmod 644

https://www.commandlinux.com/man-page/man1/dh.1.html

```
#!/usr/bin/make -f
%:
  dh $@
```

> file: preinst - chmod 644

This script is run prior extraction of the deb package - it may stop services if neccessary 
which may be restarted by the "postinst" script after the files have been deployed

> file: postinst - chmod 644

A script that configures the system after the files are transfered to their locations. 
Often it asks the user for additional config parameters like usernames. it may as well 
(re)start services or executes a reboot if neccessary. 

> file: prerm - chmod 644

This script stops all services that are linked with the packet 
- executed prior deletion of packet files

> file:postrm

Typically this script removes changes made by the installation process including 
changes in files and deletion of files

compat
This file defines the debhelper compatibility level. Currently you should use version v9
echo 9 > DEBIAN/compat

## °5: 

The project files are stored and therefor will be deployed in /usr/share/{projectname}

## °6: symfony 

...stores logs, cache and config here

this must be changed.
 
- cache belongs into °18 and can be symlinked from there into °6
- logs belongs into °19 and can be symlinked from there into °6
- config belongs into °19 and can be symlinked from there into °6

## °7: binaries 

- config belongs into °19 and can be symlinked from there into °6

## °8: src

- sources of symfony packages may be put here

## °9: vendor

this is a package, and we may ship the vendors as well...
BUT! sometimes package owners tend to put different binaries into their packages

we actually don't want to have .exe and .x86 binaries mixed in our deb package

## °10: document root

yep the doc root - in case we got a web application

### °11

A pure webapplication without a binary doesn't need a manpage

### °12

If we have a binary package we need a manpage that fits the section

### °13

If you want to make changes to the manpage of the dtinstaller: 

https://www.debian.org/doc/manuals/maint-guide/dother.de.html#manpage

```
$ gunzip /home/jochen/debpackage/debsource/usr/share/man/man8/dtinstaller.8.gz

$ vi /home/jochen/debpackage/debsource/usr/share/man/man8/dtinstaller.8

$ gzip -n -9 /home/jochen/debpackage/debsource/usr/share/man/man8/dtinstaller.8
```

### °14 Changelog file

https://www.debian.org/doc/manuals/debian-faq/ch-pkg_basics.de.html

```
$ dch -i --create --changelog=changelog 
```

- After it is generated or extened it must be gziped

```
$ gzip -n -9 changelog
```
- and owner/group and mode must be set like this:

```
$ chown jochen:jochen changelog.gz
$ chmod 644 changelog.gz
```
 
- to extend it you can run "gunzip changelog.gz" to create changelog 
- and edit changelog in a texteditor

### °15 Copyright File

NEEDS DOCUMENTATION 


### °16 Binaries

according to Filesystem Hierarchie Standard wie must put our binaries in here - symlinks do help alot

### °17 tipp for shell/bash scripts

if you create a shell/bash script do not use a file extension (e.g. ".sh")


### °18 cache

according to Filesystem Hierarchie Standard wie must put our cache in here - symlinks do help alot


### °19 logs

according to Filesystem Hierarchie Standard wie must put our logs in here - symlinks do help alot


### °20 configuration

**OPTIONAL - in case we have a webapplication**

- define the documentroot/alias in apache2.config file in here
- put parameters.yml here


### °21 debs

repository for the debfiles

### °22 keyfile

https://help.ubuntu.com/community/CreateAuthenticatedRepository

### °23 packagename

{packagename}_{version}-{revision}_{architecture}.deb

> e.g. dtinstaller_0.6-4_amd64.deb

## create a .deb package from debsource

```
$ fakeroot dpkg -b debsource debs/dists/stable/dtinstaller.deb
```

## linting a deb package

```
$ lintian -i debs/dists/stable/dtinstaller.deb
```

## gpg - signing - some basics

- create a key

```
$ gpg --gen-key

# choose 4096 bit
# never let it become invalid
# choose a good password
```


- list your keys
```
$ gpg --list-keys
```
<pre>
/home/jochen/.gnupg/pubring.gpg
-------------------------------
pub   4096R/A28A3C35 2017-08-18
uid                  Jochen Schultz <jschultz@php.net>
</pre>

- use a key hash to sign the deb package

```
$ sudo dpkg-sig --sign -k A28A3C35 dtinstaller.deb
```

## set up a repository

> File: Packages

```
$ apt-ftparchive packages . > Packages
```

> File: Packages.gz

```
$ gzip -c Packages > Packages.gz
```

> File: InRelease

```
$ apt-ftparchive release . > Release
```

> File: Release

```
$ gpg --clearsign --default-key A28A3C35 -o InRelease Release
```

> File: Release.gpg

```
$  gpg --default-key A28A3C35 -abs -o Release.gpg Release
```

## find your ip

```
$ ifconfig
```

## how to install the deb package on consumers machine 

```
$ sudo su
$ wget -O - http://172.16.2.167/keyfile | apt-key add -
$ echo "deb http://172.16.2.167/dists/stable /" >> /etc/apt/sources.list
$ apt update
$ apt install dtinstaller
$ exit
```
