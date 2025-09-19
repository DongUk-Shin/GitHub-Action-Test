#!/bin/bash
DEPLOY_DIR="/home/deploy"
LOG_FILE="app.log"
JAR_FILE="$DEPLOY_DIR/app.jar"

cd "$DEPLOY_DIR" || exit 1

PID=$(pgrep -f "$JAR_FILE") || true
if [ ! -z "$PID" ]; then
    echo "Stopping existing process (PID: $PID)"
    kill -9 "$PID"
    sleep 2
fi

echo "Starting $JAR_FILE..."
# 디버깅용: 로그 파일에도 timestamp 추가
nohup java -jar "$JAR_FILE" >> "$LOG_FILE" 2>&1 &
sleep 5
echo "Started. Current java processes:"
ps -ef | grep "$JAR_FILE"
tail -n 20 "$LOG_FILE"
