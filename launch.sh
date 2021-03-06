#!/bin/bash
# Terminate already running bar instances
killall -q polybar
# lines = `polybar -m|cut -d ":" -f 1`

echo "---" | tee -a /home/zunpeng/.config/polybar/logs/polybar.log
lnum=`polybar -m|cut -d ':' -f 1|wc -l`
# 在有扩展屏幕时，如果开机后在没有设置扩展显示器的情况下（显示器没有做扩展设置），直接开启两个polybar，会在两个显示器上分别显示两个polybar
if [ 2 -eq $lnum ]
then
    polybar -c $HOME/.config/polybar/config.ini hdmiscreen >> /home/zunpeng/.config/polybar/logs/polybar.log 2>&1 & disown
    polybar -c $HOME/.config/polybar/config.ini edpscreen>> /home/zunpeng/.config/polybar/logs/polybar.log 2>&1 & disown
    # 在加载完polybar之后加载壁线 0是扩展显示器,1是电脑显示器
    nitrogen --head=0 --set-zoom-fill --random /home/zunpeng/Pictures/wallpapers
    nitrogen --head=1 --set-zoom-fill --random /home/zunpeng/Pictures/wallpapers
else
    polybar -c $HOME/.config/polybar/config.ini noextends>> /home/zunpeng/.config/polybar/logs/polybar.log 2>&1 & disown
    nitrogen --head=1 --set-zoom-fill --random /home/zunpeng/Pictures/wallpapers
fi
echo "Bars launched..."
