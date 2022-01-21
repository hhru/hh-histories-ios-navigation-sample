# Репозиторий с демо проектами

В данном репозитории находится код демонстрирующий работу навигации с разными  вспомогательными фреймворками. [Подробнее рассказали в нашем выпуске](https://www.youtube.com/watch?v=FjAwpocB6rA).

## Ветки

- [main](https://github.com/hhru/hh-histories-ios-navigation-sample) – базовое приложение с чистым использованием UIKit
- [nivelir](https://github.com/hhru/hh-histories-ios-navigation-sample/tree/nivelir) – приложение с использованием библиотеки [Nivelir](https://github.com/hhru/Nivelir)
- [badoo](https://github.com/hhru/hh-histories-ios-navigation-sample/tree/badoo) – приложение с использованием подхода к навигации от [Badoo](https://habr.com/ru/company/badoo/blog/483830/)
- [router-composer](https://github.com/hhru/hh-histories-ios-navigation-sample/tree/route-composer) – приложение с использованием библиотеки [route-composer](https://github.com/ekazaev/route-composer)

## Сборка проекта

Чтобы собрать демо приложение, небходимо:

1. Выполнить команду в папке с проектом

   ```bash
   pod install
   ```

2. Открыть `RoutingDemo.xcworkspace` и собрать проект

##  Тестирование push-уведомлений

В папке `Tools` находятся три тестовых push-уведомления с разными `roomID` и `chatID`. Для отправки push-уведомлния на симулятор нужно перетенуть его в окно симулятора и нажать на появившееся уведомление для совершения навигации к чату (не работает в ветке `main`).
