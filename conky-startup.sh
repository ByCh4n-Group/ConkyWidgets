sleep 0s
killall conky
cd "/home/$USER/.conky/Clock-Widget"
conky -c "/home/$USER/.conky/Clock-Widget/Clock" &

cd "/home/$USER/.conky/File-Widget"
conky -c "/home/$USER/.conky/File-Widget/File" &

cd "/home/$USER/.conky/System-Widget"
conky -c "/home/$USER/.conky/System-Widget/System" &

cd "/home/$USER/.conky/Spotify-Widget"
conky -c "/home/$USER/.conky/Spotify-Widget/Spotify" &

cd "/home/$USER/.conky/Status-Widget"
conky -c "/home/$USER/.conky/Status-Widget/Status" &
