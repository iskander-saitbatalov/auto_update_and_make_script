#!/bin/bash

DIR_CON=./build-con
DIR_GUI=./build

MAKE_FLAG=-j8

GIT_LOG=git.log
BUILD_CON_LOG=build-con.log
BUILD_GUI_LOG=build-gui.log

# Color
BOLD='\033[1m'       #  ${BOLD}      # жирный шрифт (интенсивный цвет)
DBOLD='\033[2m'      #  ${DBOLD}    # полу яркий цвет (тёмно-серый, независимо от цвета)
NBOLD='\033[22m'      #  ${NBOLD}    # установить нормальную интенсивность
UNDERLINE='\033[4m'     #  ${UNDERLINE}  # подчеркивание
NUNDERLINE='\033[4m'     #  ${NUNDERLINE}  # отменить подчеркивание
BLINK='\033[5m'       #  ${BLINK}    # мигающий
NBLINK='\033[5m'       #  ${NBLINK}    # отменить мигание
INVERSE='\033[7m'     #  ${INVERSE}    # реверсия (знаки приобретают цвет фона, а фон -- цвет знаков)
NINVERSE='\033[7m'     #  ${NINVERSE}    # отменить реверсию
BREAK='\033[m'       #  ${BREAK}    # все атрибуты по умолчанию
NORMAL='\033[0m'      #  ${NORMAL}    # все атрибуты по умолчанию

# Цвет текста:
BLACK='\033[0;30m'     #  ${BLACK}    # чёрный цвет знаков
RED='\033[0;31m'       #  ${RED}      # красный цвет знаков
GREEN='\033[0;32m'     #  ${GREEN}    # зелёный цвет знаков
YELLOW='\033[0;33m'     #  ${YELLOW}    # желтый цвет знаков
BLUE='\033[0;34m'       #  ${BLUE}      # синий цвет знаков
MAGENTA='\033[0;35m'     #  ${MAGENTA}    # фиолетовый цвет знаков
CYAN='\033[0;36m'       #  ${CYAN}      # цвет морской волны знаков
GRAY='\033[0;37m'       #  ${GRAY}      # серый цвет знаков

# Цветом текста (жирным) (bold) :
DEF='\033[0;39m'       #  ${DEF}
DGRAY='\033[1;30m'     #  ${DGRAY}
LRED='\033[1;31m'       #  ${LRED}
LGREEN='\033[1;32m'     #  ${LGREEN}
LYELLOW='\033[1;33m'     #  ${LYELLOW}
LBLUE='\033[1;34m'     #  ${LBLUE}
LMAGENTA='\033[1;35m'   #  ${LMAGENTA}
LCYAN='\033[1;36m'     #  ${LCYAN}
WHITE='\033[1;37m'     #  ${WHITE}

# Цвет фона
BGBLACK='\033[40m'     #  ${BGBLACK}
BGRED='\033[41m'       #  ${BGRED}
BGGREEN='\033[42m'     #  ${BGGREEN}
BGBROWN='\033[43m'     #  ${BGBROWN}
BGBLUE='\033[44m'     #  ${BGBLUE}
BGMAGENTA='\033[45m'     #  ${BGMAGENTA}
BGCYAN='\033[46m'     #  ${BGCYAN}
BGGRAY='\033[47m'     #  ${BGGRAY}
BGDEF='\033[49m'      #  ${BGDEF}


for dir in tNavigator tNavigator2 tNavigator_old
do
	cd ~/$dir

	echo -e "${BOLD}${LGREEN}"
	echo Fetch/rebasing $dir
	echo -e "${NORMAL}"

	git fetch > ~/"$dir_$GIT_LOG"
	git rebase origin/master >> ~/"$dir_$GIT_LOG"
done


for dir in tNavigator tNavigator2 tNavigator_old
do
	cd ~/$dir/$DIR_CON

	echo -e "${BOLD}${LGREEN}"
	echo Compiling debug console from $dir...
	echo -e "${NORMAL}"
	time tmake $MAKE_FLAG debug > ~/"$dir_$BUILD_CON_LOG"

	echo -e "${BOLD}${LGREEN}"
	echo Compiling release console from $dir...
	echo -e "${NORMAL}"
	time tmake $MAKE_FLAG release >> ~/"$dir_$BUILD_CON_LOG"

	cd ~/$dir/$DIR_GUI

	echo -e "${BOLD}${LGREEN}"
	echo Compiling debug GUI from $dir...
	echo -e "${NORMAL}"
	time tmake $MAKE_FLAG debug > ~/"$dir_$BUILD_GUI_LOG"

	echo -e "${BOLD}${LGREEN}"
	echo Compiling release GUI from $dir...
	echo -e "${NORMAL}"
	time tmake $MAKE_FLAG release >> ~/"$dir_$BUILD_GUI_LOG"
done

