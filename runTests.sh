# !/bin/bash
# This script accepts a path to the rv32ui test directory included
# in the RISC-V Test Suite and runs a subset of the tests contained
# therein.

source common.sh

options=$(getopt --options="hv" --longoptions="help,verbose,version" -- "$@")
[ $? == 0 ] || error "Invalid command line. The command line includes one or more invalid command line parameters."

eval set -- "$options"
while true
do
  case "$1" in
    -h | --help)
      cat <<- EOF
Usage: ./runTests.sh [OPTIONS] PATH

This script accepts a path, PATH, to the rv32ui test directory
included in the RISC-V Test Suite https://github.com/riscv/
riscv-tools) and runs a subset of these tests contained therein.

If all of these selected tests complete successfully, this
script returns 0.

Options:

  -h|--help
  Displays this message.

  -v|--verbose
  Enables verbose output.

  --version
  Displays the current version of this program.

Example

./runTests.sh --verbose riscv-tests/build/isa/rv32ui-p-simple

Generates the RISC-V processor simulator.

Authors

1. Murali Vijayaraghavan
2. Larry Lee
EOF
      exit 0;;
    -v|--verbose)
      verbose=1
      shift;;
    --version)
      echo "version: 1.0.0"
      exit 0;;
    --)
      shift
      break;;
  esac
done
shift $((OPTIND - 1))

files="
rv32ui-p-add
rv32ui-p-addi
rv32ui-p-and
rv32ui-p-andi
rv32ui-p-auipc
rv32ui-p-beq
rv32ui-p-bgeu
rv32ui-p-blt
rv32ui-p-bltu
rv32ui-p-bne
rv32ui-p-jal
rv32ui-p-jalr
rv32ui-p-lb
rv32ui-p-lbu
rv32ui-p-lh
rv32ui-p-lhu
rv32ui-p-lui
rv32ui-p-lw
rv32ui-p-or
rv32ui-p-ori
rv32ui-p-sb
rv32ui-p-sh
"

[[ $# < 1 ]] && error "Invalid command line. The PATH argument is missing."
path=$1

notice "Running tests in $path."
for file in $files
do
  notice "Running test $file."
  ./runTest.sh "$path/$file"
  if [[ $? != 0 ]]
  then
    error "The test suite failed."
    exit 1
  fi
done
notice "All tests passed."