#!/bin/bash
# /usr/bin/select-screen

intern=eDP-1-1
dock=DP-1-1
hdmi=HDMI-1-1

case "$1" in
	intern)
    		xrandr --output "$hdmi" --off --output "$dock" --off --output "$intern" --auto
		;;
    dock)
    		xrandr --output "$hdmi" --off --output "$intern" --off --output "$dock" --mode 3840x2160
		;;
	hdmi)
    		xrandr --output "$dock" --off --output "$intern" --off --output "$hdmi" --auto
		;;
	*)
		echo "== ! toggle: missing or invalid argument ! =="
		echo "Try again with: intern | dock | hdmi"
		exit 2
esac

exit 0
