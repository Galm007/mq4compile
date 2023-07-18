#/usr/bin/sh

# CHANGE THIS
METAEDITOR="$HOME/.wine/drive_c/Program Files (x86)/OANDA - MetaTrader/metaeditor.exe"

if [[ $# -ne 1 ]]; then
        echo "Error: Must provide one argument to specify which mq4 file to compile."
        exit
fi

if [[ -d $1 ]]; then
        echo "Error: Argument must be a file but '$1' is a directory."
        exit
fi

if ! [[ -f $1 ]]; then
        echo "Error: File '$1' does not exist."
        exit
fi

SRC_DIR=$(echo $1 | rev | sed 's/[^\/]*\///' | rev)
SRC=$(echo $1 | rev | sed 's/\/.*//' | rev)

cd "$SRC_DIR"
wine "$METAEDITOR" /compile:"$SRC" /log:mq4compile.log &> /dev/null
cat mq4compile.log
rm -f mq4compile.log
