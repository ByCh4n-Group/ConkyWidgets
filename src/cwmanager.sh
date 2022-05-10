#!/bin/bash

#    Start rice today with conky :) - ConkyWidgetsManager
#    Copyright (C) 2022  Mhykol, lazypwny751
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <https://www.gnu.org/licenses/>.

export version="2.0.0" quit_cleanly="yes" cwmhome="/usr/share/cwmanager" cwd="${PWD}"
export widgets=("clock|Clock-Widget/Clock.lua" "file|File-Widget/File.lua" "spotify|Spotify-Widget/Spotify.lua" "status|Status-Widget/Status.lua" "system|System-Widget/System.lua")

__fatal() {
    [[ -v "${2}" ]] && local exit_status="${2}" || local exit_status="1"
    
    echo -e "\033[0;31mfatal\033[0m: ${1}\033[0m"
    exit "${exit_status}"
}

check() {

    local i="" quit_cleanly="yes"

    command &> /dev/null || __fatal "command 'command' not found!" "1" # there is a paradox here 
    for i in $@ ; do
        if ! command -v "${i}" &> /dev/null ; then
            echo -e "\033[0;31m${i} not found\033[0m!"
            quit_cleanly="no"
        fi
    done
    
    if [[ "${quit_cleanly}" = "no" ]] ; then
        __fatal "some dependencies not found!" "2"
    fi
}

parsewidgets() {

    local i=""
    export dirname="" basename="" realname=""

    if [[ -n "${widgets[@]}" ]] && [[ "${#}" -ge "1" ]] ; then
        check awk tr dirname basename
        for i in ${widgets[@]} ; do
            if [[ "$(echo "${i}" | tr "|" " " | awk '{print $1}')" = "${1}" ]] ; then
                export dirname="$(dirname "$(echo "${i}" | tr "|" " " | awk '{print $2}')")" basename="$(basename "$(echo "${i}" | tr "|" " " | awk '{print $2}')")" realname="$(echo "${i}" | tr "|" " " | awk '{print $2}')"
            fi
        done

        if [[ ! -n "${realname}" ]] ; then
            echo "${1} not found!"
            return 1
        fi
    else
        echo "insufficient arguments or the variablle '\$widgets' not found!"
        return 1
    fi
}

loadconf() {
    check mkdir xargs conky tr

    killall conky &> /dev/null

    [[ -d "${HOME}/.conky" ]] || mkdir -p "${HOME}/.conky"

    local i="" IFS="," quit_cleanly="yes"

    if [[ -f "${1}" ]] ; then
        local reorder="$(cat "${1}" | xargs | tr -d " ")"
        for i in ${reorder} ; do
            parsewidgets "${i}"
            if [[ -f "${HOME}/.conky/${realname}" ]] ; then
                if [[ -f "${HOME}/.conky/${dirname}/conf.sh" ]] ; then
                    bash "${HOME}/.conky/${dirname}/conf.sh" || return 1
                fi
                ( conky -c "${HOME}/.conky/${realname}" &> /dev/null ) &
                echo "'${i}' started.."
            else
                echo "The widget '${i}' not found!"
                quit_cleanly="no"
            fi
        done
    else
        echo "configuration file not found!, please run 'cwmanager --reload widget..'"
        return 1
    fi

    # we haven't quit manager function :(
    if [[ "${quit_cleanly}" = "yes" ]] ; then
        exit 0
    else
        return 1
    fi
}

case "${1}" in
    [sS][eE][tT][uU][pP]|--[sS][eE][tT][uU][pP]|-[sS][eE][tT])

        check cp mkdir conky

        killall conky &> /dev/null

        [[ -d "${HOME}/.conky" ]] || mkdir -p "${HOME}/.conky"

        for i in ${@:2} ; do
            parsewidgets "${i}" &> /dev/null
            if [[ -n "${realname}" ]] ; then
                if [[ -d "${cwmhome}/widgets/${dirname}" ]] ; then
                    [[ -d "${HOME}/.conky/${dirname}" ]] && rm -rf "${HOME}/.conky/${dirname}" 
                    cp -r "${cwmhome}/widgets/${dirname}" "${HOME}/.conky" && echo "'${i}' successfully copied."
                else
                    echo "The directory '${cwmhome}/widgets/${dirname}' not found!"
                    quit_cleanly="no"
                fi
            else
                echo "The widget '${i}' not found!"
                quit_cleanly="no"
            fi
        done

        loadconf "${HOME}/.conky/load.conf"

        # we haven't quit manager function :( x2
        if [[ "${quit_cleanly}" = "yes" ]] ; then
            exit 0
        else
            exit 1
        fi
    ;;
    [rR][eE][mM][oO][vV][eE]|--[rR][eE][mM][oO][vV][eE]|-[rR][eE][mM])

        killall conky &> /dev/null

        check rm mkdir conky

        [[ -d "${HOME}/.conky" ]] || mkdir -p "${HOME}/.conky"

        for i in ${@:2} ; do
            parsewidgets "${i}" &> /dev/null
            if [[ -n "${realname}" ]] ; then
                if [[ -d "${HOME}/.conky/${dirname}" ]] ; then
                    rm -rf "${HOME}/.conky/${dirname}" && echo "'${i}' removed successfully."
                else
                    echo "'${i}' doesn't exist."
                    quit_cleanly="no"
                fi
            else
                echo "The widget '${i}' not found!"
                quit_cleanly="no"
            fi
        done

        loadconf "${HOME}/.conky/load.conf"

        # we haven't quit manager function :( x3 (so bloat)
        if [[ "${quit_cleanly}" = "yes" ]] ; then
            exit 0
        else
            exit 1
        fi
    ;;
    [rR][eE][lL][oO][aA][dD]|--[rR][eE][lL][oO][aA][dD]|-[rR][eE][lL])
        
        check mkdir conky

        killall conky &> /dev/null

        [[ -d "${HOME}/.conky" ]] || mkdir -p "${HOME}/.conky"
        echo "" > "${HOME}/.conky/load.conf"

        for i in ${@:2} ; do
            parsewidgets "${i}" &> /dev/null
            if [[ -n "${realname}" ]] ; then
                if [[ -f "${HOME}/.conky/${realname}" ]] ; then
                    echo "${i}," >> "${HOME}/.conky/load.conf"
                else
                    echo "'${i}' doesn't exist."
                    quit_cleanly="no"
                fi
            else
                echo "The widget '${i}' not found!"
                quit_cleanly="no"
            fi
        done

        loadconf "${HOME}/.conky/load.conf"

        # we haven't quit manager function :( x4
        if [[ "${quit_cleanly}" = "yes" ]] ; then
            exit 0
        else
            exit 1
        fi
    ;;
    [vV][eE][rR][sS][iI][oO][nN]|--[vV][eE][rR][sS][iI][oO][nN]|-[vV][eE][rR])
        case "${2}" in
            [pP][aA][rR][sS][eE]|--[pP][aA][rR][sS][eE])
                echo "$(( ( $(echo "${version}" | tr "." " " | awk '{print $1}') * 100 ) + ( $(echo "${version}" | tr "." " " | awk '{print $2}') * 10 ) + ( $(echo "${version}" | tr "." " " | awk '{print $3}') * 1 ) ))"
            ;;
            *)
                echo "${version} by mhykol & lazypwny751"
            ;;
        esac
        
        exit 0
    ;;
    [lL][iI][sS][tT]|--[lL][iI][sS][tT]|-[lL][iI][sS])
        check tr wc awk mkdir

        [[ -d "${HOME}/.conky" ]] || mkdir -p "${HOME}/.conky"

        case "${2}" in
            [aA][vV][aA][iI][lL][aA][bB][lL][eE]|--[aA][vV][aA][iI][lL][aA][bB][lL][eE]|-[aA][vV][aA])
                ls -1 -d "${HOME}"/.conky/*/ 2> /dev/null | tr "\n" "\0" 2> /dev/null | xargs -0 -n 1 basename 2> /dev/null
                echo -e "\nTotal: $(ls -1 -d "${HOME}"/.conky/*/ 2> /dev/null | tr "\n" "\0" 2> /dev/null | xargs -0 -n 1 basename 2> /dev/null | wc -l) widget(s)"
            ;;
            *)
                for i in ${widgets[@]} ; do
                    echo -n "${i}" | tr "|" " " | awk '{print $1}' 
                done
                echo -e "\nTotal: ${#widgets[@]} widget(s)"
            ;;
        esac

        exit 0
    ;;
    [sS][tT][aA][rR][tT][uU][pP]|--[sS][tT][aA][rR][tT][uU][pP]|-[sS][tT][aA])
        write:startup() {
            echo -e "if [[ -f "${HOME}/.conky/${dirname}/conf.sh" ]] ; then\n\tbash "${HOME}/.conky/${dirname}/conf.sh" || return 1\nfi\n\nconky -c ${HOME}/.conky/${realname} &" >> "${HOME}/.conky/startup.sh" && echo "'${i}' added to startup.sh"
            if [[ -d "${HOME}/.config/autostart" ]] ; then
                echo "[Desktop Entry]
Exec=${HOME}/.conky/autostart.sh
Icon=/usr/share/cwmanager/cwmanager.png
Name=cwmanager autostart
Terminal=false
" > "${HOME}/.config/autostart/cwmautostart.desktop"
            fi
        }
        
        killall conky &> /dev/null

        check mkdir conky

        [[ -d "${HOME}/.conky" ]] || mkdir -p "${HOME}/.conky"
        echo -e "#!/bin/bash\n\nset -e\n" > "${HOME}/.conky/startup.sh" 

        for i in ${@:2} ; do
            parsewidgets "${i}" &> /dev/null
            if [[ -n "${realname}" ]] ; then
                if [[ -f "${HOME}/.conky/${realname}" ]] ; then
                    write:startup
                elif [[ ! -f "${HOME}/.conky/${realname}" ]] && [[ -f "${cwmhome}/widgets/${realname}" ]] ; then
                    echo -n "Copying '${i}' files.."
                    cp -r "${cwmhome}/widgets/${dirname}" "${HOME}/.conky" &> /dev/null && { echo "[OK]" ; write:startup ; } || { echo "[FAIL]" ; quit_cleanly="no" ; }
                else
                    echo "The widget '${i}' doesn't exist."
                    quit_cleanly="no"
                fi
            else
                echo "The widget '${i}' not found!"
                quit_cleanly="no"
            fi
        done

        loadconf "${HOME}/.conky/load.conf"

        # we haven't quit manager function :( x5
        if [[ "${quit_cleanly}" = "yes" ]] ; then
            exit 0
        else
            exit 1
        fi
    ;;
    [uU][pP][dD][aA][tT][eE]|--[uU][pP][dD][aA][tT][eE]|-[uU][pP][dD])
        # Self update.
        check ping mktemp curl git basename

        export tempdir="$(mktemp -d)"

        cd "${tempdir}"

        if ping -c 2 raw.githubusercontent.com &> /dev/null ; then
            curl -s https://raw.githubusercontent.com/ByCh4n-Group/Conky-Widgets/main/src/cwmanager.sh > cwmtmp.sh 2> /dev/null
            if [[ "$(bash cwmtmp.sh --version parse 2> /dev/null)" -gt "$(cwmanager --version parse 2> /dev/null)" ]] ; then
                if [[ -f "${cwmhome}/Makefile" ]] ; then
                    [[ "${UID}" -eq "0" ]] || __fatal "please run with root privalages." "1"
                    cp "${cwmhome}/Makefile" .
                    make uninstall
                    git clone "https://github.com/ByCh4n-Group/Conky-Widgets.git" # <= active repo
                    cd Conky-Widgets # project directory
                    bash ./configure.sh
                    make install || echo "Could not installing in this time please install manually 'https://github.com/ByCh4n-Group/Conky-Widgets'"
                    cd "${cwd}"
                    rm -rf "${tempdir}"
                else
                    cd "${cwd}"
                    rm -rf "${tempdir}"
                    __fatal "Cannot find 'Makefile' file of current version" "1"
                fi
            elif [[ "$(bash cwmtmp.sh --version parse 2> /dev/null)" -eq "$(cwmanager --version parse 2> /dev/null)" ]] ; then
                cd "${cwd}"
                rm -rf "${tempdir}"
                echo "up to date."
            else
                cd "${cwd}"
                rm -rf "${tempdir}"
                __fatal "could not updating automatically, please try this manually." "1"
            fi
        else
            cd "${cwd}"
            rm -rf "${tempdir}"
            __fatal "internet connection required!" "1"
        fi 
    ;;
    *)
        echo -e "There are 8 flags; --setup, --remove, --reload, --version, --list, --startup, --update, --help
setup:

\tWith the 'setup' argument, you can reload the available widgets by
\tcopying them to the configuration directory or add them to startup.
\tusage: ${BASH_SOURCE[0]##*/} --setup file clock status system..

remove:
\tWith the 'remove' argument, you can remove copied widgets.
\tusage: ${BASH_SOURCE[0]##*/} --remove clock system..

reload:
\tWith the 'reload' argument, you can reload (run) the copied widgets
\tit runs the called widgets, but there may be resolution and conflict problems,
\tso we recommend that do not open all widgets at the same time.
\tusage: ${BASH_SOURCE[0]##*/} --reload file status..

version:
\tIn plain use it shows the current version and the producer name,
\twhen used with the --parse parameter, it converts 
\tthe current version to mathematical data for the updater.
\tusage: ${BASH_SOURCE[0]##*/} --version (--parse)

list:
\tDisplays the names of the widgets that can be used in plain use.
\tWhen used with the --available parameter,
\tit displays the copied and ready to use widgets
\tusage: ${BASH_SOURCE[0]##*/} --list (--available)

startup:
\tused to save available widgets as startup script in the configuration directory
\tusage: ${BASH_SOURCE[0]##*/} --startup status file system.. > ${HOME}/.conky/startup.sh 

update:
\tThe self update feature is used to install the current version of the program in an automated way.
\tbut there is no guarantee that can be install the script correctly, there is
\talso the possibility of deleting the script, in this case you may need to install it manually.
\tOur recommendation is to install the appropriate package for your system. Also root privalages needed.
\tusage: ${BASH_SOURCE[0]##*/} --update

help:
\tShow's this text.
\tusage: ${BASH_SOURCE[0]##*/} *
"
        exit 0
    ;;
esac
