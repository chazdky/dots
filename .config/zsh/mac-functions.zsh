###############################
# MAC OSX SPECIFIC FUNCTIONS  #
###############################


# Poor-man's pgrep, for use on OS X where pgrep isn't available
# function poorpgrep() {
#   echo "Warning: using poor-man's pgrep. Consider installing the \"proctools\" package via Homebrew."
#   ps ax | awk "/(^|[^)])$1/ { print \$1 }"
# }


# Poor man's tree, for use on OS X where tree isn't available
# function poortree() {
#   echo "Warning: using poor-man's tree. Consider installing the \"tree\" package via Homebrew."
#   ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'
# }


# On Mac OS X, cd to the path of the front Finder window
# Found at <http://brettterpstra.com/2013/02/09/quick-tip-jumping-to-the-finder-location-in-terminal>
# function cdf() {
#   target=`osascript -e 'tell application "Finder" to if (count of Finder windows) > 0 then get POSIX path of (target of front Finder window as text)'`
#   if [ "$target" != "" ]; then
#     cd "$target"; pwd
#   else
#     echo 'No Finder window found' >&2
#   fi
# }


# On Mac OS X, copies the contents of a text file to the clipboard
# Found at <http://brettterpstra.com/2013/01/15/clip-text-file-a-handy-dumb-service>
# function clip() {
#   type=`file "$1"|grep -c text`
#   if [ $type -gt 0 ]; then
#     cat "$@" | pbcopy
#     echo "Contents of $1 are in the clipboard."
#   else
#     echo "File \"$1\" is not plain text."
#   fi
# }



# On Mac OS X, SSH to another Mac by hostname via Back To My Mac (iCloud)
# The client and target machines must both have Back To My Mac enabled
# Adapted from code found at <http://onethingwell.org/post/27835796928/remote-ssh-bact-to-my-mac>
# function sshicloud() {
#   if [[ $# -eq 0 || $# -gt 2 ]]; then
#     echo "Usage: $0 hostname [username]"
#   elif ! command_exists scutil; then
#     echo "$0 only works on Mac OS X! Aborting."
#   else
#     local _icloud_addr=`echo show Setup:/Network/BackToMyMac | scutil | sed -n 's/.* : *\(.*\).$/\1/p'`
#     local _username=`whoami`
#     if [[ $# -eq 2 ]]; then
#       _username=$2
#     fi
#     ssh $_username@$1.$_icloud_addr
#   fi
# }
