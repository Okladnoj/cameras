#!/bin/bash

# Очистка проекта Flutter
flutter clean

# Удаление папки .pub-cache из домашней директории пользователя
rm -rf ~/Library/Caches/.pub-cache

# Удаление папки .pub-cache из директории Flutter
rm -rf /Users/okji/development/flutter/.pub-cache

# Удаление папки cache из директории Flutter
rm -rf /Users/okji/development/flutter/bin/cache

# Запуск flutter doctor для диагностики
flutter doctor -v

# Получение зависимостей Flutter
flutter pub get
