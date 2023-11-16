#!/bin/bash

set -x
touch ./Kami/Tutorial/ExtractEx.v ./Kami/Simulator/CoqSim/HaskellTypes.v ./Kami/Compiler/Test.v ./ProcKami/Instance.v
make
cd Kami && ./fixHaskell.sh ../HaskellGen .. && cd ..
cp Haskell/*.hs HaskellGen

echo "rtlMod = separateModRemove incrMod" >> HaskellGen/Target.hs

GHCFLAGS=-XNoPolyKinds
ghc $GHCFLAGS -j -O2 --make -iHaskellGen -iKami -iKami/Compiler Kami/Compiler/CompAction.hs

mkdir -p models/incrMod; time Kami/Compiler/CompAction > models/incrMod/System.sv
