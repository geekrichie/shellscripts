#!/bin/bash

# for input
# do
#     while read line; do
#         echo $line
#     done < $input
# done

usage() {
echo "Usage: bash getopts.sh 
      [ -a alpha ] [ -b beta ]
      [ -c ] "
exit 2
}
upload=false

while getopts "a:b:c" opt; do
   case $opt in
       a)
          echo $OPTARG
          alpha=$OPTARG;;
       b)
          beta=$OPTARG;;
       c)
          upload=true ;;
       *)
          echo "wrong parameters" 
          usage;;
   esac
done


echo " the parameter num is $# "
echo " the parameters is $@ "
shift 
echo " the parameter num is $# "
echo " the parameters is $@ "
echo " the alpha is: " $alpha
echo " the beta is: " $beta
echo " the upload is " $upload
