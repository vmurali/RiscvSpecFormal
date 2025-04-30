#!/bin/bash

# $1 = ./Kami/Tutorial/ExtractEx.v or ./ProcKami/Cheriot/Clut.v
# $2 = incrMod or coq_FullClut

# HaskellGen is created by fixHaskell.sh. fixHaskell.sh is in ./Kami directory and can only execute from that directory.
# Every time a new target is added, Haskell/Target.hs must be updated appropriately (new module should be added, and imports from that module must be modified)

set -x
echo $1 $2
touch $1 ./Kami/Simulator/CoqSim/HaskellTypes.v ./ProcKami/Instance.v ./Kami/Compiler/Test.v
make -j
cd Kami && ./fixHaskell.sh ../HaskellGen .. && cd ..
cp Haskell/*.hs HaskellGen

echo "rtlMod = separateModRemove $2" >> HaskellGen/Target.hs

GHCFLAGS=-XNoPolyKinds
ghc $GHCFLAGS -j -O2 --make -iHaskellGen -iKami -iKami/Compiler Kami/Compiler/CompAction.hs

mkdir -p models/$2; time Kami/Compiler/CompAction > models/$2/System.sv
