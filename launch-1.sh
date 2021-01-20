#!/usr/bin/env bash

# Terminate already running bar instances
killall -q polybar
# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Launch bar1 and bar2
echo "---" | tee -a /home/zunpeng/.config/polybar/logs/polybar.log
polybar hdmiscreen >> /home/zunpeng/.config/polybar/logs/polybar.log 2>&1 & disown
polybar edpscreen>> /home/zunpeng/.config/polybar/logs/polybar.log 2>&1 & disown

echo "Bars launched..."
