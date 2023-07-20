#/usr/bin/sh

METAEDITOR="$HOME/.wine/drive_c/Program Files (x86)/OANDA - MetaTrader/metaeditor.exe"

if [[ $# -ne 1 ]]; then
        echo "Error: Must provide one argument to specify which mq4 file to compile."
        exit
fi

if ! [[ -e $1 ]]; then
        echo "Error: File/Directory '$1' does not exist."
        exit
fi

INCLUDE_DIR="$(echo $METAEDITOR | rev | sed 's/[^\/]*//' | sed 's/\///' | rev)/MQL4/Include"
SRC_DIR=$(echo $1 | rev | sed 's/[^\/]*//' | sed 's/\///' | rev)
SRC=$(echo $1 | rev | sed 's/\/.*//' | rev)

cd "$SRC_DIR"
wine "$METAEDITOR" /compile:"$SRC" /log:mq4compile.log &> /dev/null
cat mq4compile.log
rm -f mq4compile.log
