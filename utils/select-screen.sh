#!/bin/bash
# /usr/bin/select-screen

intern=eDP1
dock=DP1
hdmi=HDMI1

case "$1" in
	intern)
    		xrandr --output "$hdmi" --off --output "$dock" --off --output "$intern" --auto
		;;
    dock)
    		xrandr --output "$hdmi" --off --output "$intern" --off --output "$dock" --auto
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
