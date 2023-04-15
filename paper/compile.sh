#!/bin/bash

BASE="main"

# dir of script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )";
SOURCE_DIRECTORY="$DIR/src"
BUILD_DIRECTORY="$DIR/out"

echo "Source Dir: $SOURCE_DIRECTORY"
echo "Build Dir: $BUILD_DIRECTORY"

rm -Rf "$BUILD_DIRECTORY"
mkdir -p "$BUILD_DIRECTORY"
cp -a "$SOURCE_DIRECTORY/"* "$BUILD_DIRECTORY/"

cd "$BUILD_DIRECTORY"

 echo "--- FIRST PASS ----- " > compile.log
/usr/bin/pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf $BASE.tex >> compile.log

#if [ $? -ne 0 ]; then
#    echo "Compilation error. Check log."
#    exit 1
#fi


echo "--- SECOND PASS ----- " >> compile.log
#/usr/bin/bibtex $BASE.aux  >> compile.log
/usr/bin/biber  $BASE.bcf  >> compile.log

echo "--- THIRD PASS ----- " >> compile.log
/usr/bin/pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf $BASE.tex  >> compile.log

echo "--- FOURTH PASS ----- " >> compile.log
/usr/bin/pdflatex -file-line-error -interaction=nonstopmode -synctex=1 -output-format=pdf $BASE.tex  >> compile.log

/usr/bin/evince $BASE.pdf
exit 0
