# add_path_if_exist $HOME/projects/adt-bundle-mac-x86_64-20130514/sdk/platform-tools
# add_path_if_exist $HOME/projects/adt-bundle-mac-x86_64-20130514/sdk/tools
# export ANDROID_HOME=/Users/osada/.homebrew/Cellar/android-sdk/23.0.2
# export ANDROID_HOME=/Users/osada/.homebrew/opt/android-sdk
export ANDROID_HOME=$HOME/Library/Android/sdk
add_path $HOME/Library/Android/sdk/platform-tools

alias android="adb forward tcp:9222 localabstract:chrome_devtools_remote"

android_logcat(){
  cd ~/projects/adt-bundle-mac-x86_64-20130514/sdk/platform-tools
  ./adb logcat
}

if [ -d /usr/local/java ]; then
    export JAVA_HOME=/usr/local/java
    export PATH=$JAVA_HOME/bin:$PATH
fi
