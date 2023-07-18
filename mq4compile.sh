#/usr/bin/sh

METAEDITOR="$HOME/.wine/drive_c/Program Files (x86)/OANDA - MetaTrader/metaeditor.exe"
LOG_FILE=mq4compile.log

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
wine "$METAEDITOR" /compile:"$SRC" /log:"$LOG_FILE" &> /dev/null
cat "$LOG_FILE"
rm -f "$LOG_FILE"
