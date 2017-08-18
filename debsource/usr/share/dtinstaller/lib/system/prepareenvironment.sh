#!/usr/bin/env bash

prepareenvironment() {

    mkdir $apacheroot/$projectroot
    apacherunuser=$(getapacherunuser)
    apacherungroup=$(getapacherungroup)
    chown $apacherunuser:$apacherungroup $apacheroot/$projectroot
    chmod 755 $apacheroot/$projectroot
    main
    
}