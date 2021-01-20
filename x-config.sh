#!/bin/bash
## 手动修改外接显示器时需要修改的有：
## 1. arandr显示器分辨率扩展方式
## 2. ~/.config/polybar/config下的hdmiscreen
## 3. nitrogen 壁纸设置
screennum = 0
# Terminate already running bar instances
killall -q polybar

echo "---" | tee -a /home/zunpeng/.config/polybar/logs/polybar.log

OLD_IFS="$IFS"
IFS=$'\n'
xinfo=`xrandr`
for linfo in $xinfo
do
    IFS=$' ' iarray=(${linfo})
    if [ ${iarray[1]} = "connected" ]
    then
        ((screennum++))
    fi
done
IFS="$OLD_IFS"

# 在有扩展屏幕时，如果开机后在没有设置扩展显示器的情况下（显示器没有做扩展设置），直接开启两个polybar，会在两个显示器上分别显示两个polybar
# 此处只设置了一个HDMI接口的外接显示器(2560*1440)，其他类型或分辨率的显示器，在需要时重新设置
if [ 2 -eq $screennum ]
then
    # 需要先加载显示器配置
    xrandr --output HDMI1 --primary --mode 2560x1440 --pos 0x0 --rotate normal --output eDP1 --mode 1920x1080 --pos 2560x180 --rotate normal
    # 需要先加载显示器配置
    polybar -c $HOME/.config/polybar/config.ini hdmiscreen >> /home/zunpeng/.config/polybar/logs/polybar.log 2>&1 & disown
    polybar -c $HOME/.config/polybar/config.ini edpscreen>> /home/zunpeng/.config/polybar/logs/polybar.log 2>&1 & disown
    # 在加载完polybar之后加载壁线 0是扩展显示器,1是电脑显示器
    nitrogen --head=0 --set-zoom-fill --random /home/zunpeng/Pictures/wallpapers
    nitrogen --head=1 --set-zoom-fill --random /home/zunpeng/Pictures/wallpapers
else
    xrandr --output eDP1 --primary --mode 1920x1080 --pos 0x0 --rotate normal
    polybar -c $HOME/.config/polybar/config.ini noextends>> /home/zunpeng/.config/polybar/logs/polybar.log 2>&1 & disown
    nitrogen --head=1 --set-zoom-fill --random /home/zunpeng/Pictures/wallpapers
fi
