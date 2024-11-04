echo "Opening: $1"
command="send nudes"
chrome_scale="--force-device-scale-factor=0.9 --restore"
browser="thorium-browser"
browser2="thorium"
SCRIPTS_PATH="/mnt/data/Project/script_test/linux-script-pack/scripts"

case $1 in
# POWER
    "sdown")
        shutdown -h now
        exit
        ;;
    "rboot")
        killall $browser2
        reboot
        exit
        ;;
    "sleep")
        systemctl suspend
        exit
        ;;
    "lgout")''
        killall $browser2
        kill -9 -1
        ;;

# PRE CONFIG
    "aconf")
        sudo $SCRIPTS_PATH/autostartConfig.sh
        exit
        ;;
    # "asoft")
    #     $SCRIPTS_PATH/autostartSoftware.sh
    #     exit
    #     ;;
    "clean")
        $SCRIPTS_PATH/sysClean.sh
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
    # "kde")
    #     killall plasmashell && sleep 3 && kstart5 plasmashell & disown
    #     ;;
    "bar")
        bash $SCRIPTS_PATH/topBar.sh
        ;;
    # "conk")
    #     bash $SCRIPTS_PATH/conky.sh
    #     ;;
    
# Chrome base
	"calen")
        command="$browser $chrome_scale --new-window https://calendar.google.com/calendar/u/0/r/week"
        ;;
    # "chr")
    #     command="$browser $chrome_scale"
    #     ;;
    # "trelo")
    #     command="$browser $chrome_scale --new-window https://trello.com/"
    #     ;;
    # "team")
    #     command="$browser $chrome_scale --new-window https://teams.microsoft.com/"
    #     ;;
    # "dis")
    #     command="$browser $chrome_scale --new-window https://discord.com/channels/@me"
    #     ;;
    # "spot")
    #     command="$browser $chrome_scale --new-window https://open.spotify.com/"
    #     ;;
    # "notion")
    #     command="$browser $chrome_scale --new-window https://notion.so/"
    #     ;;

# code
    # "note")
    #     python $SCRIPTS_PATH/vscode.py /mnt/data/Project/obsidian/TheVault/00_Generic/JustQuickDailyNote.md && sleep 0.5 && python $SCRIPTS_PATH/vscode.py /mnt/data/Project/obsidian/TheVault/00_Generic/JustQuickTodo.md
    #     ;;
    # "idea")
    #     command="/mnt/data/Programs/idea-IC-231.9161.38/bin/idea.sh"
    #     ;;
    # "code")
    #     command="code"
    #     ;;
    # "mongo")
    #     sudo mongod --config /mnt/data/Programs/mongodb/mongodb.conf
    #     exit
    #     ;;
    # "maria")
    #     sudo systemctl start mariadb.service
    #     exit
    #     ;;
    # "dbeav")
    #     command="dbeaver"
    #     ;;

# editor
    # "menu")
    #     python $SCRIPTS_PATH/vscode.py $SCRIPTS_PATH/openProgram.sh
    #     exit
    #     ;;
    # "vim")
    #     command="gtk-launch nvim"
    #     ;;
    # "zrc")
    #     kate ~/.zshrc
    #     exit
    #     ;;
    # "todo")
    #     code /home/joun/Desktop/todo.txt
    #     exit
    #     ;;
    # "obsi")
    #     command="obsidian"
    #     ;;
    # "andr")
    #     command="/mnt/data/Programs/android-studio/bin/studio.sh"
    #     ;;

# other 
    # "xdm")
    #     command="xdman"
    #     ;;
    # "ibus")
    #     command="ibus-daemon"
    #     ;;
    
    *)
        echo "Invalid Input?"
        exit
        ;;


esac

$command > /dev/null 2>&1 &
