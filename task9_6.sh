#!/bin/bash
echo "Завдання 9.6: Аналіз прав доступу"
echo "Домашній каталог:"
ls -ld ~
touch ~/test_file && echo "Успішно" || echo "Не вдалось"
echo "Каталог /usr/bin:"
ls -ld /usr/bin
echo "Спроба зміни /usr/bin/ls:"
echo "test" >> /usr/bin/ls 2>/dev/null && echo "Успішно" || echo "Не вдалось"
echo "Каталог /etc:"
ls -ld /etc
echo "Спроба зміни /etc/passwd:"
echo "test" >> /etc/passwd 2>/dev/null && echo "Успішно" || echo "Не вдалось"
rm -f ~/test_file
echo "Виконання завдання 9.6 завершено"
