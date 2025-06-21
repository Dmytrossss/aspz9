#!/bin/bash
echo "Завдання 9.3: Експерименти з правами власності"

# Створення тестового файлу
test_file="testfile.txt"
echo "Початковий вміст" > "$test_file"
echo "Файл створено: $(ls -l $test_file)"

# Копіювання через sudo
sudo cp "$test_file" "/root/copied_file.txt"
sudo cp "/root/copied_file.txt" "$HOME/copied_file.txt"
sudo chown root:root "$HOME/copied_file.txt"

echo "Файл скопійовано: $(ls -l $HOME/copied_file.txt)"

# Спроба зміни файлу
echo "Спроба зміни файлу:"
echo "Новий вміст" >> "$HOME/copied_file.txt" 2>&1
echo "Результат: $?"

# Спроба видалення
echo "Спроба видалення:"
rm -f "$HOME/copied_file.txt" 2>/dev/null
echo "Результат: $?"

# Очищення
sudo rm -f "/root/copied_file.txt" "$HOME/copied_file.txt"
rm -f "$test_file"

echo "Виконання завдання 9.3 завершено"
