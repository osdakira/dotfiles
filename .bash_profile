source ~/.bashrc

##
# Your previous /Users/osada/.bash_profile file was backed up as /Users/osada/.bash_profile.macports-saved_2013-10-22_at_11:43:15
##

# MacPorts Installer addition on 2013-10-22_at_11:43:15: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

#THIS MUST BE AT THE END OF THE FILE FOR GVM TO WORK!!!
[[ -s "/Users/osada/.gvm/bin/gvm-init.sh" ]] && source "/Users/osada/.gvm/bin/gvm-init.sh"


c_cyan=`tput setaf 6`
c_red=`tput setaf 1`
c_green=`tput setaf 2`
c_sgr0=`tput sgr0`
