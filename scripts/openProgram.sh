echo "Opening: $1"
command="send nudes"
chrome_scale="--force-device-scale-factor=0.9 --restore"
browser="thorium-browser"

case $1 in
# system
    "sdown")
        shutdown -h now
        exit
        ;;
    "rboot")
        killall chromium
        reboot
        exit
        ;;
    "sleep")
        systemctl suspend
        exit
        ;;
    "lgout")''
        killall chromium
        kill -9 -1
        ;;
    "aconf")
        sudo /mnt/Data/_linux/Script_pack/autostartConfig.sh
        exit
        ;;
    "asoft")
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
        killall plasmashell && sleep 3 && kstart5 plasmashell & disown
        ;;
    "bar")
        bash /mnt/Data/_linux/Script_pack/topBar.sh
        ;;
    "conk")
        bash /mnt/Data/_linux/Script_pack/conky.sh
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
    "note")
        command="python /mnt/Data/_linux/Script_pack/vscode.py '/mnt/Data/Project/obsidian/TheVault/00_Generic/JustQuickDailyNote.md'"
        ;;
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
        python /mnt/Data/_linux/Script_pack/vscode.py /mnt/Data/_linux/Script_pack/openProgram.sh
        exit
        ;;
    "vim")
        command="gtk-launch nvim"
        ;;
    "zrc")
        kate ~/.zshrc
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
