#!/usr/bin/env bash


installimagemagic() {
  apt install imagemagick
  clear
  checkimagemagic
}

checkimagemagic() {

  isinstalled=$(convert -version | grep -oP 'Version(?=)')
  
  if [[ $isinstalled = 'Version' ]]; then
    version=$(convert -version | grep -oP 'Version.*' | grep -oP 'ImageMagic.+' | grep -oP ' .*?(?= )' | head -1)
    message "  ✔ ImageMagic Version:$version is installed" 2 3
  else
    clear
    message "   ATTENTION ImageMagic is not installed  " 1 3
    echo ""
    echo "1) install it and go on"
    echo "2) exit"
    echo ""
    echo -e "Please choose an option: \c "
    read option
    case $option in
        1) installimagemagic;;
        2) exit;;
    esac
  fi
  return 1
  
}