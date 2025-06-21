### Детальний звіт з виконання роботи  
 

**Система: Linux Mint 22.1 'Xia' MATE Edition (VirtualBox)**  

**Виконавець: Гнилицький Дмитро** 

**Група ТВ-33**

---

### **Завдання 9.1:
**Код скрипта (`task9_1.sh`):**  
```bash
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
```

**Команда запуску:**  
```bash
./task9_1.sh
```

**Вивід:**  

![image](https://github.com/user-attachments/assets/42c9687f-df24-449e-983e-0cd7a7780fb4)


```
dima@dima-VirtualBox:~/aspz9$ ./task9_1.sh
Завдання 9.1: Звичайні користувачі (UID >= 1000)
Список звичайних користувачів (крім dima):
Виконання завдання 9.1 завершено

```

**Висновок:**  
Скрипт коректно відфільтрував користувачів з UID ≥ 1000. Інших користувачів, крім поточного (dima), не знайдено, бо їх просто немає.

---

### **Завдання 9.2:
**Код скрипта (`task9_2.sh`):**  
```bash
#!/bin/bash
echo "Завдання 9.2: Читання /etc/shadow через sudo"
sudo head -n 5 /etc/shadow
echo "Виконання завдання 9.2 завершено"
```

**Команда запуску:**  
```bash
./task9_2.sh
```

**Вивід:**  

![image](https://github.com/user-attachments/assets/be924d35-e543-4e8b-9345-9df70cfc0711)


```
dima@dima-VirtualBox:~/aspz9$ ./task9_2.sh
Завдання 9.2: Читання /etc/shadow через sudo
Перші 5 рядків /etc/shadow:
[sudo] пароль до dima:               
root:!:20259:0:99999:7:::
daemon:*:20098:0:99999:7:::
bin:*:20098:0:99999:7:::
sys:*:20098:0:99999:7:::
sync:*:20098:0:99999:7:::
Виконання завдання 9.2 завершено

```

**Висновок:**  
Скрипт успішно прочитав захищений файл `/etc/shadow` через `sudo`, що підтверджує можливість отримання адміністративних прав для звичайного користувача.

---

### **Завдання 9.3:
**Код скрипта (`task9_3.sh`):**  
```bash
#!/bin/bash
echo "Завдання 9.3: Експерименти з правами власності"
test_file="testfile.txt"
echo "Початковий вміст" > "$test_file"
sudo cp "$test_file" "/root/copied_file.txt"
sudo cp "/root/copied_file.txt" "$HOME/copied_file.txt"
sudo chown root:root "$HOME/copied_file.txt"
echo "Спроба зміни файлу:"
echo "Новий вміст" >> "$HOME/copied_file.txt"
echo "Спроба видалення:"
rm -f "$HOME/copied_file.txt"
sudo rm -f "/root/copied_file.txt" "$test_file"
echo "Виконання завдання 9.3 завершено"
```

**Команда запуску:**  
```bash
./task9_3.sh
```

**Вивід:**  

![image](https://github.com/user-attachments/assets/77b080e8-3c9d-4fb3-a03d-1ff29ef7ecbd)


```
dima@dima-VirtualBox:~/aspz9$ ./task9_3.sh
Завдання 9.3: Експерименти з правами власності
Файл створено: -rw-rw-r-- 1 dima dima 32 чер 22 00:14 testfile.txt
Файл скопійовано: -rw-r--r-- 1 root root 32 чер 22 00:14 /home/dima/copied_file.txt
Спроба зміни файлу:
./task9_3.sh: рядок 18: /home/dima/copied_file.txt: Відмовлено у доступі
Результат: 1
Спроба видалення:
rm: вилучити захищений від запису звичайний файл '/home/dima/copied_file.txt'? y
Результат: 0
Виконання завдання 9.3 завершено

```

**Висновок:**  
- Зміна файлу з власником `root` неможлива для звичайного користувача (відмовлено у доступі).  
- Видалення файлу **успішне** через права на каталог (`rwx` для власника каталогу).  

---

### **Завдання 9.4: 
**Код скрипта (`task9_4.sh`):**  
```bash
#!/bin/bash
echo "Завдання 9.4: Інформація про користувача"
whoami
id
groups
echo "Виконання завдання 9.4 завершено"
```

**Команда запуску:**  
```bash
./task9_4.sh
```

**Вивід:**  

![image](https://github.com/user-attachments/assets/6957b091-b9a3-4d6b-a845-c8770217ec9b)


```
dima@dima-VirtualBox:~/aspz9$ ./task9_4.sh
Завдання 9.4: Інформація про користувача
Команда whoami:
dima
Команда id:
uid=1000(dima) gid=1000(dima) групи=1000(dima),4(adm),24(cdrom),27(sudo),30(dip),46(plugdev),100(users),105(lpadmin),124(sambashare)
Групи користувача:
dima adm cdrom sudo dip plugdev users lpadmin sambashare
Виконання завдання 9.4 завершено
```

**Висновок:**  
Скрипт коректно ідентифікував користувача та його групи, зокрема привілейовані групи (`sudo`, `adm`).

---

### **Завдання 9.5:  
**Код скрипта (`task9_5.sh`):**  
```bash
#!/bin/bash
echo "Завдання 9.5: Експерименти з правами доступу"
temp_file="tempfile.txt"
echo "Тестовий вміст" > "$temp_file"
sudo chown root:root "$temp_file"
sudo chmod 000 "$temp_file"
echo "Спроба читання:"
cat "$temp_file"
echo "Результат: $?"
sudo rm -f "$temp_file"
echo "Виконання завдання 9.5 завершено"
```

**Команда запуску:**  
```bash
./task9_5.sh
```

**Вивід:**  
```
dima@dima-VirtualBox:~/aspz9$ ./task9_5.sh
Завдання 9.5: Експерименти з правами доступу
Початковий стан: -rw-rw-r-- 1 dima dima 28 чер 22 00:19 tempfile.txt
Після chown: -rw-rw-r-- 1 root root 28 чер 22 00:19 tempfile.txt
Спроба читання:
Тестовий вміст
Результат: 0
Спроба запису:
./task9_5.sh: рядок 18: tempfile.txt: Відмовлено у доступі
Результат: 1
Після chmod 000: ---------- 1 root root 28 чер 22 00:19 tempfile.txt
Спроба читання (після chmod 000):
cat: tempfile.txt: Відмовлено у доступі
Результат: 1
Виконання завдання 9.5 завершено
```

**Висновок:**  
- Файл з правами `000` та власником `root` неможливо прочитати звичайним користувачем.  
- Код помилки `1` підтверджує відмову в доступі.  

---

### **Завдання 9.6:
**Код скрипта (`task9_6.sh`):**  
```bash
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
```

**Команда запуску:**  
```bash
./task9_6.sh
```

**Вивід:**  

![image](https://github.com/user-attachments/assets/15f523fb-b3c2-4bcc-bf41-53a8db3b8925)


```
dima@dima-VirtualBox:~/aspz9$ ./task9_6.sh
Завдання 9.6: Аналіз прав доступу
Домашній каталог:
drwxr-x--- 20 dima dima 4096 чер 22 00:14 /home/dima
Спроба створення файлу:
Успішно

Каталог /usr/bin:
drwxr-xr-x 2 root root 69632 чер 21 02:14 /usr/bin
Спроба читання /usr/bin/ls:
Успішно
Спроба зміни /usr/bin/ls:
./task9_6.sh: рядок 17: /usr/bin/ls: Відмовлено у доступі
Не вдалось

Каталог /etc:
drwxr-xr-x 146 root root 12288 чер 21 01:18 /etc
Спроба читання /etc/passwd:
Успішно
Спроба зміни /etc/passwd:
./task9_6.sh: рядок 25: /etc/passwd: Відмовлено у доступі
Не вдалось
Виконання завдання 9.6 завершено
```

**Висновок:**  
- У домашньому каталозі користувач має повні права.  
- Зміна файлів у `/usr/bin` та `/etc` неможлива через відсутність прав запису.  

---

### **Варіант #3: Читання файлу з нульовими правами**  
**Код скрипта (`task_var3.sh`):**  
```bash
#!/bin/bash
echo "Варіант #3: Читання файлу з нульовими правами"
test_file="zero_access.txt"
echo "Секретний вміст" > "$test_file"
chmod 000 "$test_file"
echo "Спроба читання звичайним користувачем:"
cat "$test_file"
echo "Результат: $?"
echo "Спроба читання через sudo:"
sudo cat "$test_file"
echo "Результат: $?"
chmod 644 "$test_file"
rm -f "$test_file"
echo "Висновок: Звичайний користувач не може читати файл з правами 000, але root може."
```

**Команда запуску:**  
```bash
./task_var3.sh
```

**Вивід:**  

![image](https://github.com/user-attachments/assets/12bd39b5-4f2e-4cc5-bdf1-2ea4730d3919)


```
ima@dima-VirtualBox:~/aspz9$ ./task_var3.sh
Варіант #3: Читання файлу з нульовими правами доступу
Файл створено: -rw-rw-r-- 1 dima dima 88 чер 22 00:24 zero_access.txt
Файл з нульовими правами: ---------- 1 dima dima 88 чер 22 00:24 zero_access.txt

Спроба читання звичайним користувачем:
cat: zero_access.txt: Відмовлено у доступі
Результат: 1 (0=успіх, 1=помилка)

Спроба читання через sudo:
Секретний вміст, який намагатимемося прочитати
Результат: 0 (0=успіх, 1=помилка)

Висновок:
1. Звичайний користувач НЕ може читати файл з правами 000
2. Root КОРИСТУВАЧ МОЖЕ читати файл з правами 000
Виконання завдання варіанту #3 завершено

```

**Висновок:**  
- Права доступу `000` повністю блокують доступ для звичайних користувачів.  
- Користувач `root` обходить обмеження прав доступу.  
