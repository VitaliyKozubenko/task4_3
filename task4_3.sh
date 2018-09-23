#!bin/bash


if [ "$#" != 2 ];
then
echo "Введено некоректное число аргументов, нужно 2"
exit 1
fi

if [ -d "$1" ];
then
echo "Файл или директория не существует"
exit 2
fi
re='^[0-9]*$'
if ! [[ $2 =~ $re ]]
#if ! [[ "$2" =~ "^[0-9]+$" ]]
then
   echo "Вы ввели не число"
exit 3
fi

if ! [ -d /tmp/backups ]
then
mkdir /tmp/backups
fi

dir=`echo "$1" | sed -r 's/[/]+/-/g' | sed 's/^-//' `

tar -czvf "/tmp/backups/$dir"\_$(date +%Y-%m-%d_%H:%M:%S).tar.gz "$1"

find /tmp/backups/ -name "$dir*" | sort -n | head -n -"$2" | sed 's/\ /\\\ /g' |xargs rm -f

exit 0
