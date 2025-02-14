# Rest Client Demo

🚀 **Rest Client** - это демонстрационный проект для работы с REST API, реализованный на Dart с
использованием Dio для запросов и обработки ошибок.

## Content

- 🌐 Реализация REST-клиента с поддержкой разных HTTP-методов (GET, POST, PUT, DELETE и др.).
- 🛠 Обработка ошибок с кастомными исключениями для различных статусов HTTP.
- 🖥 Интеграция с UI для уведомлений о статусе запросов.
- 📦 Параметризуемые заголовки, тело запросов и типы контента.

## Installation

1. Склонируйте репозиторий:
   ```bash
   git clone https://github.com/your-repo/rest-client-demo.git
   ```

2. Установите зависимости:
   ```bash
   dart pub get
   ```

3. Пример использования:
   ```dart
   final RestClient restClient = RestClientImpl(...);
   final response = await restClient.get(path: 'some-api-endpoint');
   ```
   
