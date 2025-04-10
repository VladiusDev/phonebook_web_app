# Phone book app

Телефонный справочник сотрудников

## Конфиг

Добавить в папку assets файл config.yaml и прописать ip и port API шлюза - [Phone book gateway](https://github.com/VladiusDev/phonebook_gateway) а так же URL и ключ сервиса авторизации supabase

```yaml
employee_api:
  baseUrl: "http://0.0.0.0"
  port: 8080
```

```yaml
supabase:
  url: 'your url'
  anonKey: 'your key'
```