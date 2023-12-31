VS:=$(shell find . -type f -name '*.v')

.PHONY: coq clean force

coq: Makefile.coq.all $(VS)
	$(MAKE) -f Makefile.coq.all

Makefile.coq.all: force
	$(COQBIN)coq_makefile -f _CoqProject $(VS) -o Makefile.coq.all

force:

clean:: Makefile.coq.all
	find . -type f -name '*.v.d' -exec rm {} \;
	find . -type f -name '*.glob' -exec rm {} \;
	find . -type f -name '*.vo' -exec rm {} \;
	find . -type f -name '*.vos' -exec rm {} \;
	find . -type f -name '*.vok' -exec rm {} \;
	find . -type f -name '*.~' -exec rm {} \;
	find . -type f -name '*.hi' -exec rm {} \;
	find . -type f -name '*.o' -exec rm {} \;
	find . -type f -name '*.aux' -exec rm {} \;
	rm -rf HaskellGen
	rm -f Makefile.coq.all Makefile.coq.all.conf .Makefile.coq.all.d
	rm -rf obj_dir
	rm -rf simpleTestResults
