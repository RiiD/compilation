#!/bin/bash
FILES="$(find examples/* ! -name '*_out.txt')"
TEST_CASES="and for if not or while nestedWhile do_while readwrite
            switch switch_no_break switch_error nestedWhile_with_break
            nestedWhile_with_error_break"
for TEST_CASE in ${TEST_CASES}; do
  file=examples/${TEST_CASE}.txt
  outFile=examples/${TEST_CASE}_out.txt

  if [ -e ${outFile} ]
  then
    printf "Testing %s...\t\t" "$TEST_CASE"
    res=$(./build/myprog.exe ${file} | diff ${outFile} -)
    if [[ -z "${res// }" ]]
    then
      printf "OK\n\n"
    else
      printf "FAIL\n\n"
      exit
    fi
  fi

done
