#!/bin/bash

source config_file.cfg

index_index=-1

for dir in ${DIRS_ARRAY[@]}
do
  index_index=$(($index_index+1))
  if [ -d ~/$dir ]; then
    $SETCOLOR_SUCCESS
    echo -n 'Project directory ('$dir') exist.'"$(tput hpa $(tput cols))$(tput cub 6)[OK]"
    $SETCOLOR_NORMAL
    echo
  else

    mkdir -p ~/$dir

    if [ -d ~/$dir ]; then
      $SETCOLOR_SUCCESS
      echo -n 'Project directory ('~/$dir') did not exist. The directory was created successfully.'."$(tput hpa $(tput cols))$(tput cub 6)[OK]"
      echo
      $SETCOLOR_NORMAL
    else
      $SETCOLOR_FAILURE
      echo -n 'Project directory ('~/$dir') doesn"t exist. Can"t create.'"$(tput hpa $(tput cols))$(tput cub 6)[fail]"
      echo
      $SETCOLOR_NORMAL
      continue
    fi
  fi
  cd ~/$dir

  # TODO: create check that git inited.

  $SETCOLOR_SUCCESS
  echo 'Fetch/rebasing' $dir"$(tput hpa $(tput cols))$(tput cub 6)[OK]"
  $SETCOLOR_NORMAL

  git fetch > ~/"$dir_$GIT_LOG"

  # TODO: сheck that we are don not have stashed commits and if we have, then save them.
  git rebase origin/${BRANCHS_ARRAY[index_index]} >> ~/"$dir_$GIT_LOG"
done

for dir in ${DIRS_ARRAY[@]}
do
	cd ~/$dir/$DIR_CON

	echo -e "${BOLD}${LGREEN}"
	echo Compiling debug console from $dir...
	echo -e "${NORMAL}"
        qmake-qt4
	time tmake $MAKE_FLAG debug > ~/"$dir_$BUILD_CON_LOG"

	echo -e "${BOLD}${LGREEN}"
	echo Compiling release console from $dir...
	echo -e "${NORMAL}"

        qmake-qt4
	time tmake $MAKE_FLAG release >> ~/"$dir_$BUILD_CON_LOG"

	cd ~/$dir/$DIR_GUI

	echo -e "${BOLD}${LGREEN}"
	echo Compiling debug GUI from $dir...
	echo -e "${NORMAL}"
        qmake-qt4
	time tmake $MAKE_FLAG debug > ~/"$dir_$BUILD_GUI_LOG"

	echo -e "${BOLD}${LGREEN}"
	echo Compiling release GUI from $dir...
	echo -e "${NORMAL}"
        qmake-qt4
	time tmake $MAKE_FLAG release >> ~/"$dir_$BUILD_GUI_LOG"
done

