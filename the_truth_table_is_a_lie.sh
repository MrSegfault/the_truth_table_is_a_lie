#!/usr/bin/env bash

trap 'clear;tput cnorm;exit 0' SIGINT SIGTERM SIGTSTP

main () {
	local tiempo potencias potencia impr ctr linea zero one cols
	tiempo=$1

	if [ -z "$1" ] ;then
		tiempo=0
	fi

	cols=`tput cols`
	cols=$(($cols/2-1))
	ctr=0

	one="\e[31m░\e[39m"
	zero="\e[32m▓\e[39m"

	tput civis

	for i in $(seq 0 $cols);do		
		linea[$i]=0
		potencias[$i]=$((2**$i))
		potencia=$((potencias[$i]))
		if [ $potencia -lt 1 ];then
			potencias[$i]=$((potencias[$i-1]))
		fi
	done
	while true;do
		impr=''
		for i in $(seq 0 $cols);do		
			potencia=$((potencias[$i]))
			if ! (($ctr%$potencia));then
				if ! ((linea[$i]));then
					linea[$i]=1
				else
					linea[$i]=0
				fi
			fi
			if ((linea[$i])) ;then
				impr=$one$impr$one
			else
				impr=$zero$impr$zero
			fi
		done
		ctr=$(($ctr+1))
		echo -e $impr
		sleep $tiempo
	done
}
main "$@"
