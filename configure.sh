#!/bin/bash

#    Start rice with conky today :) - ConkyWidgetsManager
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

cwd="${PWD}"

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

check mkdir install cp make conky

tabs 8
t="$(printf '\t')"

cat - > Makefile <<EOF
PRE = /usr/bin
CWHOME = /usr/share/cwmanager
 
install:
${t}mkdir -p \$(CWHOME)
${t}cp ./Makefile \$(CWHOME)
${t}cp -r ./src/gui \$(CWHOME)
${t}cp -r ./src/widgets \$(CWHOME)
${t}install -m 755 ./src/cwmanager.sh \$(PRE)/cwmanager
${t}@bash ./genmanpage.sh
${t}pip3 install -r requirements.txt

uninstall:
${t}rm -rf \$(CWHOME) \$(PRE)/cwmanager /usr/share/man/man1/cwmanager.1.gz /usr/share/man/tr/man1/cwmanager.1.gz
EOF
echo "Now you can type the magic word!: 'sudo make install' :)."
