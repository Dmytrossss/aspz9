#!/bin/bash
echo "Завдання 9.1: Звичайні користувачі (UID >= 1000)"
current_user=$(whoami)
getent passwd | awk -F: -v user="$current_user" '
{
  if ($3 >= 1000 && $1 != user && $1 != "nobody") {
    print "Користувач:", $1, "UID:", $3
  }
}'
echo "Виконання завдання 9.1 завершено"
