</$objtype/mkfile

BIN=/$objtype/bin/git9
TARG=\
	conf\
	fetch\
	fs\
	query\
	save\
	send\
	walk

RC=\
	add\
	branch\
	clone\
	commit\
	diff\
	export\
	import\
	init\
	log\
	merge\
	pull\
	push\
	revert

OFILES=\
	objset.$O\
	ols.$O\
	pack.$O\
	proto.$O\
	util.$O\
	ref.$O

HFILES=git.h

</sys/src/cmd/mkmany

# Override install target to install rc.
install:V:
	mkdir -p $BIN
	mkdir -p /sys/lib/git
	for (i in $TARG)
		mk $MKFLAGS $i.install
	for (i in $RC)
		mk $MKFLAGS $i.rcinstall
	cp git9.1 /sys/man/1/git9
	cp gitfs.4 /sys/man/4/gitfs
	cp common.rc /sys/lib/git/common.rc
	mk $MKFLAGS /sys/lib/git/template

uninstall:V:
	rm -rf $BIN /sys/lib/git

%.c %.h: %.y
	$YACC $YFLAGS -D1 -d -s $stem $prereq
	mv $stem.tab.c $stem.c
	mv $stem.tab.h $stem.h

%.c %.h: %.y
	$YACC $YFLAGS -D1 -d -s $stem $prereq
	mv $stem.tab.c $stem.c
	mv $stem.tab.h $stem.h

%.rcinstall:V:
	cp $stem $BIN/$stem
	chmod +x $BIN/$stem

/sys/lib/git/template: template
	mkdir -p /sys/lib/git/template
	dircp template /sys/lib/git/template
