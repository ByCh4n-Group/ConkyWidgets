#!/bin/bash

IFS=":"

if command -v manpath &> /dev/null && command -v gzip &> /dev/null ; then
    MANPATH="$(manpath)"
    for i in ${MANPATH} ; do
        if [[ "${i}" = "/usr/share/man" ]] ; then
            (
                cd ./man
                gzip -cvf cwmanager.en > /usr/share/man/man1/cwmanager.1.gz
                gzip -cvf cwmanager.tr > /usr/share/man/tr/man1/cwmanager.1.gz
            )
        fi
    done
fi

exit 0