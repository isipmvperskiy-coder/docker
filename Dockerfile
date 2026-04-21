# ========== СТАДИЯ 1: СБОРКА =========
FROM node:alpine AS builder

WORKDIR /app

# Копируем package.json из папки my-app
COPY my-app/package*.json ./

# Устанавливаем зависимости
RUN npm install

# Копируем весь код из папки my-app
COPY my-app/ ./

# Собираем приложение
RUN npm run build

# ========== СТАДИЯ 2: ПРОДАКШЕН =========
FROM nginx:alpine

# Копируем собранные файлы
COPY --from=builder /app/build /usr/share/nginx/html

# Открываем порт
EXPOSE 80

# Запускаем nginx
CMD ["nginx", "-g", "daemon off;"]