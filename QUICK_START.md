# 🚀 Швидкий старт - Widget Monorepo

## Що було створено

Ваш монорепозиторій тепер повністю підготовлений для деплойменту з Docker! Ось що було додано:

### 📁 Нові файли та структура

```
widget/
├── 🐳 Docker файли
│   ├── Dockerfile.widget          # Production build для frontend
│   ├── Dockerfile.widget.dev      # Development build для frontend
│   ├── docker-compose.yml         # Основна конфігурація
│   ├── docker-compose.dev.yml     # Development середовище
│   ├── docker-compose.prod.yml    # Production середовище
│   └── .dockerignore              # Оптимізація збірки
│
├── 🌐 Nginx конфігурація
│   ├── nginx.conf                 # Базова конфігурація
│   └── nginx/nginx.conf           # Production конфігурація з проксі
│
├── 🐍 Python backend (готово для майбутнього)
│   ├── apps/directory/
│   │   ├── Dockerfile
│   │   └── requirements.txt
│   └── apps/matching/
│       ├── Dockerfile
│       └── requirements.txt
│
├── 📜 Скрипти та конфігурація
│   ├── scripts/
│   │   ├── build.sh               # Скрипт збірки
│   │   ├── deploy.sh              # Скрипт деплойменту
│   │   └── init-db.sql            # Ініціалізація БД
│   ├── Makefile                   # Команди для спрощення роботи
│   ├── env.example                # Приклад змінних середовища
│   └── DOCKER_README.md           # Детальна документація
│
└── 📚 Документація
    ├── DOCKER_README.md           # Повний гід
    └── QUICK_START.md             # Цей файл
```

## ⚡ Швидкий запуск (3 кроки)

### 1️⃣ Підготовка

```bash
# Клонуйте репозиторій (якщо ще не зробили)
cd /Users/artem/Documents/Learn/playground/widget

# Виконайте початкове налаштування
make setup
```

### 2️⃣ Налаштування

Відредагуйте файл `.env` (було створено з `env.example`):

```bash
# Основні налаштування
NODE_ENV=production
REACT_APP_API_URL=http://localhost/api

# База даних (змініть паролі!)
POSTGRES_DB=widget_db
POSTGRES_USER=widget_user
POSTGRES_PASSWORD=your_secure_password_here

# Безпека (змініть ключі!)
JWT_SECRET=your-jwt-secret-key-here
ENCRYPTION_KEY=your-encryption-key-here
```

### 3️⃣ Запуск

```bash
# Development (рекомендується для початку)
make dev

# Або Production
make prod
```

## 🌐 Доступ до сервісів

### Development

- **Frontend**: http://localhost:4200
- **Database**: localhost:5433
- **Redis**: localhost:6380

### Production

- **Frontend**: http://localhost:3000
- **Database**: localhost:5432
- **Redis**: localhost:6379

## 🛠 Корисні команди

```bash
# Основні команди
make help          # Показати всі команди
make dev           # Запуск development
make prod          # Запуск production
make stop          # Зупинити всі сервіси
make logs          # Показати логи
make health        # Перевірити здоров'я сервісів

# Розробка
make test          # Запустити тести
make lint          # Запустити лінтинг
make clean         # Очистити Docker ресурси

# База даних
make db-shell      # Підключитися до БД
make db-backup     # Створити backup
```

## 🐍 Додавання Python Backend сервісів

Коли будете готові додати backend сервіси:

### 1. Розкоментуйте сервіси в docker-compose.yml

```yaml
# У docker-compose.yml знайдіть та розкоментуйте:
directory-service:
  # ... конфігурація вже готова

matching-service:
  # ... конфігурація вже готова
```

### 2. Оновіть Nginx конфігурацію

```bash
# У nginx/nginx.conf розкоментуйте:
upstream directory_api {
    server directory-service:8000;
}

upstream matching_api {
    server matching-service:8000;
}
```

### 3. Додайте ваш Python код

```bash
# Створіть основні файли для кожного сервісу:
apps/directory/main.py      # FastAPI додаток
apps/matching/main.py       # FastAPI додаток
```

## 🔧 Налаштування для Production

### SSL/HTTPS

```bash
# Створіть папку для сертифікатів
mkdir ssl

# Додайте ваші сертифікати
cp your-cert.pem ssl/
cp your-key.pem ssl/
```

### Змінні середовища

```bash
# Для production створіть .env.prod
cp env.example .env.prod

# Відредагуйте з production значеннями
# Використовуйте: docker-compose -f docker-compose.prod.yml --env-file .env.prod up -d
```

## 🚨 Якщо щось не працює

### Перевірте логи

```bash
make logs
```

### Перевірте здоров'я сервісів

```bash
make health
```

### Перезапустіть сервіси

```bash
make stop
make dev  # або make prod
```

### Очистіть все і почніть знову

```bash
make clean
make setup
make dev
```

## 📞 Допомога

- **Детальна документація**: `DOCKER_README.md`
- **Всі команди**: `make help`
- **Структура проекту**: `tree` або `ls -la`

---

**🎉 Готово!** Ваш монорепозиторій тепер повністю підготовлений для деплойменту з Docker. Можете починати розробку або додавати backend сервіси!
