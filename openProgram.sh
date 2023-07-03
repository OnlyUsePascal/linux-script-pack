echo "Opening: $1"
command="send nudes"
chrome_scale="--force-device-scale-factor=0.84"
browser="chromium"
case $1 in
    "auto")
        /mnt/Data/_linux/Script_pack/autostartSoftware.sh
#         sudo /mnt/Data/_linux/Script_pack/autostartConfig.sh
        exit
        ;;
    "chr")
        command="$browser $chrome_scale"
        ;;
    "todo")
        command="$browser $chrome_scale --new-window https://trello.com/"
        ;;
    "note")
        command="$browser $chrome_scale --new-window https://www.notion.so/"
        ;;
    "team")
	command="$browser $chrome_scale --new-window https://teams.microsoft.com/"
	;;
    "dis")
        command="$browser $chrome_scale --new-window https://www.discord.com/login"
        ;;
    "idea")
        command="/mnt/Data/_linux/Programs/idea-IC-231.9011.34/bin/idea.sh"
        ;;
    "code")
        command="code"
        ;;
    "mongo")
        sudo mongod --config /mnt/Data/_linux/Programs/mongodb/mongodb.conf
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
    "menu")
        nano /mnt/Data/_linux/Script_pack/openProgram.sh
        exit
        ;;
    "vim")
	command="gtk-launch nvim"
	;;
    "bashrc")
	sudo nano ~/.bashrc
	exit
	;;
    *)
        echo "Invalid Input?"
        exit
        ;;
esac

$command > /dev/null 2>&1 &
