# Makefile for 'church' type checker for System F_omega
# Authors: Andreas Abel, Klaus Aehlig

lhsmodules=Error.lhs ParseMonad.lhs Datastructure.lhs KindChecking.lhs Lexer.lhs AlgorithmicEquality.lhs TypeChecking.lhs 

hsfiles=$(lhsmodules) Parser.hs Main.lhs

all : church


# compiling with GHC

%.hs : %.ly
	happy $< ;

church : $(hsfiles)
	ghc $^ -o $@


# testing 

.PHONY : test clean

test  : church
	./church ext.church


# cleaning up

clean :
	rm -f *.hi *.o *~ fomega church a.out core Parser.hs ship church.tgz


# packing and shipping the source

destdir=~/public_html/church

shipfiles=Makefile $(lhsmodules) Parser.ly Parser.hs Main.lhs ext.church towersOfTwo.church

church.tgz : $(shipfiles)
	tar czf $@ $^

ship  : church.tgz towersOfTwo.church
	cp -p $^ $(destdir)/ ;
	touch $@ ;

