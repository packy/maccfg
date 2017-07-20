ack: ${gitdir}/ack2/ack-standalone

${gitdir}/ack2:
	git clone git@github.com:packy/ack2.git ${gitdir}/ack2

${gitdir}/ack2/Makefile: $(DEPDIR)/homebrew $(PERLBREW) $(DEPDIR)/File-Next ${gitdir}/ack2
	cd ${gitdir}/ack2; perl Makefile.PL;

${gitdir}/ack2/ack-standalone: ${gitdir}/ack2/Makefile
	cd ${gitdir}/ack2; make ack-standalone
	touch ${gitdir}/ack2/ack-standalone

${gitdir}/file-next:
	git clone https://github.com/petdance/file-next.git ${gitdir}/file-next

$(DEPDIR)/File-Next: ${gitdir}/file-next
	cd ${gitdir}/file-next; perl Makefile.PL; make install

.PHONY: install
install:
	ln -s $(HOME)/bin/ack ${gitdir}/ack2/ack-standalone
