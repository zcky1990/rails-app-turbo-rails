# 🚀 Rails Web App with Docker Compose

This is a Rails application packaged using Docker Compose. It includes essential services like **MongoDB**, **Redis**, and **Sidekiq**.

## 📦 Services

| Service   | Description                                      |
|-----------|--------------------------------------------------|
| `app`     | The main Rails application                       |
| `db`      | MongoDB for data storage                         |
| `redis`   | Redis for pub/sub and background job queues      |
| `sidekiq` | Sidekiq worker for processing background jobs    |

## 🐳 Getting Started

### 1. Make sure you have installed:
- [Docker](https://www.docker.com/)
- [Docker Compose](https://docs.docker.com/compose/)

### 2. Run the following command

```bash
docker-compose up --build
```

📌 This will:
- Build the Rails image and start the server at `http://localhost:3000`
- Remove `tmp/pids/server.pid` to avoid PID conflicts on restart
- Automatically run TailwindCSS in background during development
- Start Sidekiq to process background jobs

### 3. Access the App

- Rails Web App: [http://localhost:3000](http://localhost:3000)
- MongoDB: `localhost:27017`
- Redis: `localhost:6379`

## 🎨 TailwindCSS

This app uses [tailwindcss-rails](https://github.com/rails/tailwindcss-rails) to manage styling.

> ⚠️ **If you add a new theme or make changes to `app/assets/stylesheets/tailwind/application.css`, you need to re-run the following command inside the container:**

```bash
bin/rails tailwindcss:install
```

This ensures that TailwindCSS is properly re-initialized and your new theme is recognized in the development environment.

## 🧠 Docker Compose Structure

```yaml
version: '3.9'

services:
  app:
    build: .
    container_name: rails_web_app
    depends_on:
      - db
      - redis
      - sidekiq
    tty: true
    environment:
      RAILS_ENV: development
    volumes:
      - .:/rails
    ports:
      - "3000:3000"
    command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails server -b 0.0.0.0"

  db:
    image: mongo
    container_name: mongo_db
    restart: always
    ports:
      - "27017:27017"
    volumes:
      - mongo_data:/data/db

  redis:
    image: redis:7
    container_name: redis_server
    ports:
      - "6379:6379"
    volumes:
      - redis_data:/data

  sidekiq:
    build: .
    container_name: sidekiq_worker
    depends_on:
      - db
      - redis
    environment:
      RAILS_ENV: development
    volumes:
      - .:/rails
    command: bundle exec sidekiq

volumes:
  mongo_data:
  redis_data:
```

## 📁 Persistent Volumes

- `mongo_data`: Stores MongoDB data
- `redis_data`: Stores Redis data

## 🛠️ Notes

- **TailwindCSS** runs in the background only in development mode.
- If you get an error like `A server is already running`, the server PID file will be removed automatically before startup.
- To enter the running Rails container:
  ```bash
  docker-compose exec app bash
  ```

---
