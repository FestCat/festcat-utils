bin_SCRIPTS = audiollibre divcapitols festcat festcat_llegeix \
              readclipboard text2audio

CLEANFILES = $(bin_SCRIPTS)
EXTRA_DIST = audiollibre.in divcapitols.in festcat.in festcat_llegeix.in \
             readclipboard.in text2audio.in
     
do_subst = sed -e 's|__BINDIR__|$(bindir)|g' \
            -e 's|__SYSCONFDIR__|$(sysconfdir)/@PACKAGE@|g' \
            -e 's|__SOX__|@SOX@|g' \
            -e 's|__PERL__|@PERL@|g' \
            -e 's|__ICONV__|@ICONV@|g' \
            -e 's|__FILE__|@FILE@|g' \
            -e 's|__CSPLIT__|@CSPLIT@|g' \
            -e 's|__DATADIR__|$(pkgdatadir)|g' \
            -e 's|__XCLIP__|@XCLIP@|g' \
            -e 's|__WLPASTE__|@WLPASTE@|g' \
            -e 's|__GREP__|@GREP@|g' \
            -e 's|__CAT__|@CAT@|g' \
            -e 's|__TR__|@TR@|g' \
            -e 's|__MKDIR__|@MKDIR@|g' \
            -e 's|__RM__|@RM@|g' \
            -e 's|__KILL__|@KILL@|g' \
            -e 's|__FESTIVAL__|@FESTIVAL@|g' \
            -e 's|__TEXT2WAVE__|@TEXT2WAVE@|g' \
            -e 's|__ECHO__|@ECHO@|g' \
            -e 's|__ID3__|@ID3@|g' \
            -e 's|__VORBISCOMMENT__|@VORBISCOMMENT@|g' \
            -e 's|__DATE__|@DATE@|g' \
            -e 's|__ZENITY__|@ZENITY@|g' 

     
%: %.in
	$(do_subst) < $< > $@
	chmod +x $@

