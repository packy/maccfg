ack: ${gitdir}/ack2/ack-standalone

${gitdir}/ack2:
	git clone https://github.com/packy/ack2.git ${gitdir}/ack2

${gitdir}/ack2/Makefile: $(DEPDIR)/homebrew $(PERLBREW) $(DEPDIR)/File-Next
	cd ${gitdir}/ack2; perl Makefile.PL;

${gitdir}/ack2/ack-standalone: ${gitdir}/ack2/Makefile
	cd ${gitdir}/ack2; make ack-standalone
	touch ${gitdir}/ack2/ack-standalone

${gitdir}/file-next:
	git clone https://github.com/petdance/file-next.git ${gitdir}/file-next

$(DEPDIR)/File-Next:
	cd ${gitdir}/file-next; perl Makefile.PL; make install

