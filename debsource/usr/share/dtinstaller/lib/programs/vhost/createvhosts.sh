#!/usr/bin/env bash

# === === ### function to create a new empy virtual host under apache2 ### === === #

# Author Jochen Schultz <jschultz@php.net>

# usage:  createvhost /var/www/projects

create_vhost_apache_entry() {
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


create_vhost_directory_structure() {

    local projectdirectory
    projectdirectory=${1}
    projectname=${2}

    mkdir -p ${projectdirectory}/${projectname}/{conf,log,application/web}
    apacherunuser=$(getapacherunuser)
    apacherungroup=$(getapacherungroup)
    chown -R ${apacherunuser}:${apacherungroup} ${projectdirectory}/${projectname}

    create_vhost_apache_entry "${projectdirectory}" "${pname}"

    cd ${projectdirectory}/${projectname}
    message "  ✔ Project created" 2 0
    read -n 1 -s -r -p "Press any key to continue"
    main
}

createvhost() {

    local projectdirectory dirs
    projectdirectory=${1}
    clear
    message "   create a project!  " 3 0
    echo ""
    echo -e "Projectname (leave empty to cancel): \c"
    read pname
    if [[ ${pname} = "" ]]; then
        main
    else
        if [ -d ${projectdirectory}/${pname} ]; then
            message "  ❌ this project already exist!" 1 0
            read -n 1 -s -r -p "Press any key to continue"
            createvhost "${projectdirectory}"
            exit
        else
            create_vhost_directory_structure "${projectdirectory}" "${pname}"
        fi
    fi

}
