echo "Opening: $1"
command="send nudes"
chrome_scale="--force-device-scale-factor=0.9"
browser="chromium"

case $1 in
# system
    "sdown")
        shutdown -h now
        exit
        ;;
    "rboot")
        reboot
        exit
        ;;
    "sleep")
        systemctl suspend
        exit
        ;;
    "lgout")
        kill -9 -1
        ;;
    "aConf")
        sudo /mnt/Data/_linux/Script_pack/autostartConfig.sh
        exit
        ;;
    "aSoft")
        /mnt/Data/_linux/Script_pack/autostartSoftware.sh
        exit
        ;;
    "clean")
        /mnt/Data/_linux/Script_pack/sysClean.sh
        exit
        ;;
    "vpn")
        str=$(warp-cli status)
        sub="Connected"

        if [[ "${str}" == *"${sub}"* ]]; then
            echo "Connected, now disconnect"
            command="warp-cli disconnect"
        else
            echo "Not connected, now connect"
            command="warp-cli connect"
        fi
        ;;
    "kde")
        killall plasmashell && sleep 5 && kstart5 plasmashell
        ;;

# Chrome base
	"calen")
        command="$browser $chrome_scale --new-window https://calendar.google.com/"
        ;;
    "chr")
        command="$browser $chrome_scale"
        ;;
    "trelo")
        command="$browser $chrome_scale --new-window https://trello.com/"
        ;;
    "note")
        command="$browser $chrome_scale --new-window https://www.notion.so/"
        ;;
    "team")
        command="$browser $chrome_scale --new-window https://teams.microsoft.com/"
        ;;
    "dis")
        command="$browser $chrome_scale --new-window https://discord.com/channels/@me"
        ;;
    "spot")
        command="$browser $chrome_scale --new-window https://open.spotify.com/"
        ;;

# code
    "idea")
        command="/mnt/Data/_linux/Programs/idea-IC-231.9161.38/bin/idea.sh"
        ;;
    "code")
        command="code"
        ;;
    "mongo")
        sudo mongod --config /mnt/Data/_linux/Programs/mongodb/mongodb.conf
        exit
        ;;
    "maria")
        sudo systemctl start mariadb.service
        exit
        ;;
    "dbeav")
        command="dbeaver"
        ;;

# editor
    "menu")
        code /mnt/Data/_linux/Script_pack/openProgram.sh
        exit
        ;;
    "vim")
        command="gtk-launch nvim"
        ;;
    "bashrc")
        sudo nano ~/.bashrc
        exit
        ;;
    "todo")
        code /home/joun/Desktop/todo.txt
        exit
        ;;
    "obsi")
        command="obsidian"
        ;;
    "andr")
        command="/mnt/Data/_linux/Programs/android-studio/bin/studio.sh"
        ;;

# other 
    "xdm")
        command="xdman"
        ;;
    "ibus")
        command="ibus-daemon"
        ;;
    *)
        echo "Invalid Input?"
        exit
        ;;


esac

$command > /dev/null 2>&1 &
