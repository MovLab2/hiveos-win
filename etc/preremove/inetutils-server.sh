if [ -f /etc/ftpusers ] && cmp -s /etc/defaults/etc/ftpusers /etc/ftpusers
then
    rm /etc/ftpusers
fi

if [ -f /etc/ftpwelcome ] && cmp -s /etc/defaults/etc/ftpwelcome /etc/ftpwelcome
then
    rm /etc/ftpwelcome
fi

if [ -f /etc/inetd.conf ] && cmp -s /etc/defaults/etc/inetd.conf /etc/inetd.conf
then
    rm /etc/inetd.conf
fi

if [ -f /etc/shells ] && cmp -s /etc/defaults/etc/shells /etc/shells
then
    rm /etc/shells
fi

if [ -f /etc/motd ] && cmp -s /etc/defaults/etc/motd /etc/motd
then
    rm /etc/motd
fi

if [ -f /etc/syslog.conf ] && cmp -s /etc/defaults/etc/syslog.conf /etc/syslog.conf
then
    rm /etc/syslog.conf
fi

if [ -f /etc/xinetd.d/ftpd ] && cmp -s /etc/defaults/etc/xinetd.d/ftpd /etc/xinetd.d/ftpd
then
    rm /etc/xinetd.d/ftpd
fi

if [ -f /etc/xinetd.d/talk ] && cmp -s /etc/defaults/etc/xinetd.d/talk /etc/xinetd.d/talk
then
    rm /etc/xinetd.d/talk
fi

if [ -f /etc/xinetd.d/telnet ] && cmp -s /etc/defaults/etc/xinetd.d/telnet /etc/xinetd.d/telnet
then
    rm /etc/xinetd.d/telnet
fi

if [ -f /etc/xinetd.d/uucp ] && cmp -s /etc/defaults/etc/xinetd.d/uucp /etc/xinetd.d/uucp
then
    rm /etc/xinetd.d/uucp
fi

