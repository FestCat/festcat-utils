man1_MANS = audiollibre.1 divcapitols.1 festcat.1 festcat_llegeix.1 \
            readclipboard.1 text2audio.1

CLEANFILES = $(man1_MANS)
EXTRA_DIST = audiollibre.1.in divcapitols.1.in festcat.1.in festcat_llegeix.1.in \
             readclipboard.1.in text2audio.1.in

do_subst = sed \
            -e 's|__PACKAGE_VERSION|@PACKAGE_VERSION@|g' \
            -e 's|__PACKAGE_NAME|@PACKAGE_NAME@|g' 
    
%: %.in
	$(do_subst) < $< > $@


