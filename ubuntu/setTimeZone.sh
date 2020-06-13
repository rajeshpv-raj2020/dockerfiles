#!/usr/bin/env bash
if [[ -f "/usr/share/zoneinfo/${TZ_FILENAME}" ]]; then
    mv /etc/localtime /etc/localtime.backup
    ln -s /usr/share/zoneinfo/${TZ_FILENAME} /etc/localtime
fi
