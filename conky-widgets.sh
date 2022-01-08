#!/bin/bash

if [[ ! -d ~/.conky ]] ; then
    mkdir -p ~/.conky
fi

conkyw:reload() {
    kill -9 "$(pidof conky)" 2> /dev/null
    conky -q -c ~/".conky/${1}" -d &> /dev/null 
}

conkyw:remove() {
    kill -9 "$(pidof conky)" 2> /dev/null
    [[ -d ~/".conky/${1}" ]] && rm -rf ~/".conky/${1}"
}

conkyw:copy() {
    [[ -d ~/".conky/${1}" ]] || cp -r ./"${1}" ~/.conky 
}

case "${1}" in
    [sS][eE][tT][uU][pP]|--[sS][eE][tT][uU][pP]|-[sS])
        case "${2}" in
            [cC][lL][oO][cC][kK])
                conkyw:copy "Clock-Widget"
                conkyw:reload "Clock-Widget/Clock"
            ;;
            [fF][iI][lL][eE])
                conkyw:copy "File-Widget"
                conkyw:reload "File-Widget/File"
            ;;
            [sS][pP][oO][tT][iI][fF][yY])
                conkyw:copy "Spotify-Widget"
                chmod +x ~/".conky/Spotify-Widget/Scripts/"*
                conkyw:reload "Spotify-Widget/Spotify"
            ;;
            [sS][tT][aA][tT][uU][sS])
                conkyw:copy "Status-Widget"
                conkyw:reload "Status-Widget/Status"
            ;;
            [sS][yY][sS][tT][eE][mM])
                conkyw:copy "System-Widget"
                conkyw:reload "System-Widget/System"
            ;;
            *)
                echo "wrong usage there are 5 flags:

$(basename ${BASH_SOURCE[0]}) --setup clock:

$(basename ${BASH_SOURCE[0]}) --setup file:

$(basename ${BASH_SOURCE[0]}) --setup spotify:

$(basename ${BASH_SOURCE[0]}) --setup status:

$(basename ${BASH_SOURCE[0]}) --setup system:
"
            ;;
        esac
    ;;
    [rR][eE][mM][oO][vV][eE]|--[rR][eE][mM][oO][vV][eE]|-[rR])
        case "${2}" in
            [cC][lL][oO][cC][kK])
                conkyw:remove "Clock-Widget"
            ;;
            [fF][iI][lL][eE])
                conkyw:remove "File-Widget"
            ;;
            [sS][pP][oO][tT][iI][fF][yY])
                conkyw:remove "Spotify-Widget"
            ;;
            [sS][tT][aA][tT][uU][sS])
                conkyw:remove "Status-Widget"
            ;;
            [sS][yY][sS][tT][eE][mM])
                conkyw:remove "System-Widget"
            ;;
            *)
                echo "wrong usage there are 5 flags:

$(basename ${BASH_SOURCE[0]}) --remove clock:

$(basename ${BASH_SOURCE[0]}) --remove file:

$(basename ${BASH_SOURCE[0]}) --remove spotify:

$(basename ${BASH_SOURCE[0]}) --remove status:

$(basename ${BASH_SOURCE[0]}) --remove system:
"            ;;
        esac
    ;;
    [aA][lL][lL]|--[aA][lL][lL]|-[aA])
        case "${2}" in
            [sS][eE][tT][uU][pP])
                kill -9 "$(pidof conky)" 2> /dev/null
                conkyw:copy "Clock-Widget"
                conky -q -c ~/".conky/Clock-Widget" -d &> /dev/null
                conkyw:copy "File-Widget"
                conky -q -c ~/".conky/File-Widget" -d &> /dev/null
                conkyw:copy "Spotify-Widget"
                conky -q -c ~/".conky/Spotify-Widget" -d &> /dev/null
                conkyw:copy "Status-Widget"
                conky -q -c ~/".conky/Status-Widget" -d &> /dev/null
                conkyw:copy "System-Widget"
                conky -q -c ~/".conky/System-Widget" -d &> /dev/null
            ;;
            [rR][eE][mM][oO][vV][eE])
                conkyw:remove "Clock-Widget"
                conkyw:remove "File-Widget"
                conkyw:remove "Spotify-Widget"
                conkyw:remove "Status-Widget"
                conkyw:remove "System-Widget"
            ;;
            *)
                echo "wrong usage there are 2 flags:

$(basename ${BASH_SOURCE[0]}) --all setup:

$(basename ${BASH_SOURCE[0]}) --all remove:
"
            ;;
        esac
    ;;
    *)
        echo "wrong usage there are 3 flags:

$(basename ${BASH_SOURCE[0]}) --setup:

$(basename ${BASH_SOURCE[0]}) --remove:

$(basename ${BASH_SOURCE[0]}) --all:
"
        exit 0
    ;;
esac