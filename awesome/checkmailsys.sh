#!/bin/bash
pid=`pidof /usr/bin/python /usr/bin/offlineimap`
if [ -z "$pid" ]; then
  echo "offlineimap is not running";
  echo "started offlineimap"
  cd
  #offlineimap &
fi

sed 's/mailboxes "//; s/"$//; s:+:.IMAP/:g; s/" "/\n/g;' Mutt/mailboxes > .mailcheckrc
mailcheck -cb | sed 's:.IMAP/\(.*\)/INBOX:\1:; s:new message(s)$::'
