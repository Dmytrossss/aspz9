#!/bin/bash
echo "Завдання 9.1: Звичайні користувачі (UID >= 1000)"

# Отримуємо поточного користувача
current_user=$(whoami)

echo "Список звичайних користувачів (крім $current_user):"
getent passwd | awk -F: -v user="$current_user" '
{
  if ($3 >= 1000 && $1 != user && $1 != "nobody") {
    print "Користувач:", $1, "UID:", $3
  }
}'

echo "Виконання завдання 9.1 завершено"
