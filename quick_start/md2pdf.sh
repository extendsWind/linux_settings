#!/bin/bash

# echo $0
echo $1
echo $2

# pandoc -f markdown -t latex -o test.pdf $1
mkdir pandoc_out
htmlName=pandoc_out/"$1".html

if [ "$1" == "--all" ];then
  htmlName=pandoc_out/tmp.html
  pandoc *.md -V CJKmainfont=宋体 --mathjax -s -o "$htmlName"
else
  pandoc "$1" -V CJKmainfont=宋体 --mathjax -s -o "$htmlName"
fi

echo "--------- generate html done! ---------"
  pandoc "$htmlName" -V CJKmainfont=宋体 --mathjax --pdf-engine=xelatex  -s -o "$2"
echo "--------- generate pdf done! ---------"

# rm -r pandoc_out






# IFS=$(echo -en "\n\b")
# 
# inputFilename="$(echo $1 | sed 's/ /\\ /g')"
# echo $inputFilename
# 
# cd "$(dirname "$0")"
# 
# # current=$(cd "$(dirname "$0")";pwd)
# 
# # echo pandoc "$inputFilename"
# # -V CJKmainfont=宋体 --pdf-engine=xelatex  -o "$2"
# 
# 
# echo test2.....
# #echo pandoc \"$1\"
# # pandoc -f markdown -t latex -o test.pdf $inputFilename 
# 
# #-V CJKmainfont=宋体 --pdf-engine=xelatex  -o "$2"
# 
# # --template=eisvogel.tex
# 
