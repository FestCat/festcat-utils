docdir = $(datadir)/doc/@PACKAGE@
dist_doc_DATA = readclipboard.ca.txt

EXTRA_DIST = festcat-utils.desktop.in festcat-utils.xcf

debianicondir = $(datadir)/pixmaps
dist_debianicon_DATA = festcat-utils.xpm 

xdgicondir= $(datadir)/icons/hicolor/48x48/apps
dist_xdgicon_DATA = festcat-utils.png 

desktopmenudir= $(datadir)/applications
desktopmenu_DATA = festcat-utils.desktop

CLEANFILES = $(desktopmenu_DATA) *~

festcat-utils.desktop:
	cp festcat-utils.desktop.in festcat-utils.desktop
	chmod +x festcat-utils.desktop
