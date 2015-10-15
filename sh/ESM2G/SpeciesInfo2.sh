#!/bin/sh

while IFS=, read -r species p50 deltaH
do
    echo ${p50} + ${deltaH} | bc
done