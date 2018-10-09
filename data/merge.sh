#!/bin/bash
# This is a script to merge all txt file which are in this dir and not in `ignore` to a file name `temp`.
# 这个脚本会合并所有该目录下不匹配忽略规则（`ignnore`）的 txt 文件，并输出为 `temp` 文件。

# ignore rules
ignore=("moot tvbox.txt")

# open current dir
cd $(cd "$(dirname "$0")";pwd)

function merge(){
    for file in ` ls $1 `
    do
        if [ -d $1"/"$file ]; then
            merge $1"/"$file
        elif [[ $file == *.txt ]]; then
            # echo "$1/$file"
            append "$1/$file"
        fi
    done
}

function append() {
    for i in $ignore
    do
        # echo $i
        if [[ $1 == *$i* ]]; then
            return
        fi
    done
    echo "merge: "$1
    # append file to the end of temp file
    cat $1 >> ./temp
}

# make temp file
if [[ ! -f './temp' ]]; then
    # make temp file
    touch ./temp
    echo "make temp"
else
    rm -f ./temp && touch ./temp
    echo "make temp"
fi
# merge current dir
merge .