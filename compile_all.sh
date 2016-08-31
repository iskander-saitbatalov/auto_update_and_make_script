#!/bin/bash

source config_file.cfg

for dir in $DIRS_ARRAY
do
	cd ~/$dir

	echo -e "${BOLD}${LGREEN}"
	echo Fetch/rebasing $dir
	echo -e "${NORMAL}"

	git fetch > ~/"$dir_$GIT_LOG"
	git rebase origin/master >> ~/"$dir_$GIT_LOG"
done


for dir in $DIRS_ARRAY
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

