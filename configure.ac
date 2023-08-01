#                                               -*- Autoconf -*-
# Process this file with autoconf to produce a configure script.

AC_PREREQ([2.67])
AC_INIT([festcat-utils],[1.6],[sergioller@gmail.com])
AC_COPYRIGHT(Copyright 2009-2023 Sergio Oller)
AC_COPYRIGHT(Copyright 2009-2011 Paco Rivière)
AC_COPYRIGHT(Copyright 2009-2011 Antonio Bonafonte)
AC_CONFIG_SRCDIR([scripts/audiollibre.in])
AM_INIT_AUTOMAKE

# perl
AC_PATH_PROG([PERL], [perl], [/usr/bin], [$PATH:/usr/bin])
if test ! -f "$PERL"; then
	AC_MSG_ERROR(Can't find perl)
fi
AC_SUBST(PERL)

# sox
AC_PATH_PROG([SOX], [sox], [/usr/bin], [$PATH])
if test ! -f "$SOX"; then
	AC_MSG_ERROR(Can't find sox)
fi
AC_SUBST(SOX)

AC_PATH_PROG([ICONV], [iconv], [/usr/bin], [$PATH])
if test ! -f "$ICONV"; then
	AC_MSG_ERROR(Can't find iconv)
fi
AC_SUBST(ICONV)

AC_PATH_PROG([FILE], [file], [/usr/bin], [$PATH])
if test ! -f "$FILE"; then
	AC_MSG_ERROR(Can't find file)
fi
AC_SUBST(FILE)

AC_PATH_PROG([CSPLIT], [csplit], [/usr/bin], [$PATH])
if test ! -f "$CSPLIT"; then
	AC_MSG_ERROR(Can't find CSPLIT)
fi
AC_SUBST(CSPLIT)

AC_PATH_PROG([WLPASTE], [wl-paste], [/usr/bin], [$PATH])
if test ! -f "$WLPASTE"; then
	AC_MSG_ERROR(Can't find WLPASTE)
fi
AC_SUBST(WLPASTE)


AC_PATH_PROG([XCLIP], [xclip], [/usr/bin], [$PATH])
if test ! -f "$XCLIP"; then
	AC_MSG_ERROR(Can't find XCLIP)
fi
AC_SUBST(XCLIP)

AC_PATH_PROG([CAT], [cat], [/bin], [$PATH])
if test ! -f "$CAT"; then
	AC_MSG_ERROR(Can't find CAT)
fi
AC_SUBST(CAT)

AC_PATH_PROG([TR], [tr], [/usr/bin], [$PATH])
if test ! -f "$TR"; then
	AC_MSG_ERROR(Can't find TR)
fi
AC_SUBST(TR)

AC_PATH_PROG([MKDIR], [mkdir], [/bin], [$PATH])
if test ! -f "$MKDIR"; then
	AC_MSG_ERROR(Can't find MKDIR)
fi
AC_SUBST(MKDIR)

AC_PATH_PROG([RM], [rm], [/bin], [$PATH])
if test ! -f "$RM"; then
	AC_MSG_ERROR(Can't find RM)
fi
AC_SUBST(RM)

AC_PATH_PROG([GREP], [grep], [/bin], [$PATH])
if test ! -f "$GREP"; then
	AC_MSG_ERROR(Can't find GREP)
fi
AC_SUBST(GREP)

AC_PATH_PROG([KILL], [kill], [/bin], [$PATH])
if test ! -f "$KILL"; then
	AC_MSG_ERROR(Can't find KILL)
fi
AC_SUBST(KILL)

AC_PATH_PROG([FESTIVAL], [festival], [/usr/bin], [$PATH])
if test ! -f "$FESTIVAL"; then
	AC_MSG_ERROR(Can't find FESTIVAL)
fi
AC_SUBST(FESTIVAL)

AC_PATH_PROG([TEXT2WAVE], [text2wave], [/usr/bin], [$PATH])
if test ! -f "$TEXT2WAVE"; then
	AC_MSG_ERROR(Can't find TEXT2WAVE)
fi
AC_SUBST(TEXT2WAVE)


AC_PATH_PROG([ZENITY], [zenity], [/usr/bin], [$PATH])
if test ! -f "$ZENITY"; then
	AC_MSG_ERROR(Can't find ZENITY)
fi
AC_SUBST(ZENITY)

AC_PATH_PROG([ECHO], [echo], [/usr/bin], [$PATH])
if test ! -f "$ECHO"; then
	AC_MSG_ERROR(Can't find ECHO)
fi
AC_SUBST(ECHO)

AC_PATH_PROG([ID3], [id3], [/usr/bin], [$PATH])
if test ! -f "$ID3"; then
	AC_MSG_ERROR(Can't find ID3)
fi
AC_SUBST(ID3)

AC_PATH_PROG([VORBISCOMMENT], [vorbiscomment], [/usr/bin], [$PATH])
if test ! -f "$VORBISCOMMENT"; then
	AC_MSG_ERROR(Can't find VORBISCOMMENT, try installing vorbis-tools or a similar package.)
fi
AC_SUBST(VORBISCOMMENT)

AC_PATH_PROG([DATE], [date], [/bin], [$PATH])
if test ! -f "$DATE"; then
	AC_MSG_ERROR(Can't find DATE)
fi
AC_SUBST(DATE)

# Checks for library functions.

AC_CONFIG_FILES([Makefile
                 doc/Makefile
                 doc/man/Makefile
                 etc/Makefile
                 scripts/Makefile
                 share/Makefile])
AC_OUTPUT
