#!/usr/bin/env bash

# === === ### lib to install symfony framework ### === === #

# Author Jochen Schultz <jschultz@php.net>

# usage: symfony

symfony_checkrequirements() {
  message "   checking requirements!  " 3 0
  checkgit
  checkcomposer
  read -n 1 -s -r -p "Press any key to continue"
}

symfony_create_vhost_apache_entry() {
    projectdirectory=${1}
    projectname=${2}
    cat > ${projectdirectory}/${projectname}/conf/apache2.conf <<EOL
    <VirtualHost *:80>
        ServerName ${projectname}.dev
        ServerAdmin jschultz@php.net
        DocumentRoot ${projectdirectory}/${projectname}/application/web/
        ErrorLog ${projectdirectory}/${projectname}/log/error.log
        CustomLog ${projectdirectory}/${projectname}/log/access.log combined
    </VirtualHost>
EOL
    ln -s ${projectdirectory}/${projectname}/conf/apache2.conf /etc/apache2/sites-available/${projectname}.conf
    a2ensite ${projectname}
    service apache2 reload

}

symfony_create_vhost_directory_structure() {

    local projectdirectory
    projectdirectory=${1}
    projectname=${2}
    sudouser=$(getsudouser)
    apacherunuser=$(getapacherunuser)
    apacherungroup=$(getapacherungroup)
    # root creates a directory
    mkdir -p ${projectdirectory}/${projectname}/{conf,log,application}
    # sudo user takes it over application folder
    chown -R ${sudouser}:${sudouser} ${projectdirectory}/${projectname}/application
    apppath=${projectdirectory}/${projectname}/application
    cd ${apppath}
    # sudouser creates project
    sudo -u${sudouser} composer create-project symfony/framework-standard-edition ./
    # apacheuser becomes new owner of applicationfolder
    chown -R ${apacherunuser}:${apacherungroup} ${projectdirectory}/${projectname}/application
    symfony_create_vhost_apache_entry "${projectdirectory}" "${projectname}"
    message "  ✔ Symfony project created" 2 0
    read -n 1 -s -r -p "Press any key to continue"
    main

}

symfony() {

    local projectdirectory dirs
    projectdirectory=${1}
    symfony_checkrequirements
    clear
    message "   create a Symfony project!  " 3 0
    echo ""
    echo -e "Projectname (leave empty to cancel): \c"
    read pname
    if [[ ${pname} = "" ]]; then
        main
    else
        if [ -d ${projectdirectory}/${pname} ]; then
            message "  ❌ this project already exist!" 1 0
            read -n 1 -s -r -p "Press any key to continue"
            symfony "${projectdirectory}"
            exit
        else
            symfony_create_vhost_directory_structure "${projectdirectory}" "${pname}"
        fi
    fi

}
