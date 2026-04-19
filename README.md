# Civil Registry System — Tamil Nadu

A Flask + MySQL web application for Birth and Death Registration with PDF certificate generation, email notifications, and admin approval workflow.

## 🚀 Deploy on Railway (Recommended)

### Step 1: Push to GitHub
```bash
git init
git add .
git commit -m "initial commit"
git branch -M main
git remote add origin https://github.com/YOUR_USERNAME/BirthDeathProject.git
git push -u origin main
```

### Step 2: Deploy on Railway
1. Go to https://railway.app → Sign up with GitHub
2. Click **New Project → Deploy from GitHub repo**
3. Select **BirthDeathProject**
4. Click **Add Service → Database → MySQL**
5. Set the environment variables below in Railway's **Variables** tab
6. Railway auto-deploys → gives you a live URL ✅

### Step 3: Set Environment Variables in Railway

| Variable | Value |
|----------|-------|
| `SECRET_KEY` | Any random 32-char string |
| `MYSQL_HOST` | (Auto-set by Railway MySQL plugin) |
| `MYSQL_USER` | (Auto-set by Railway MySQL plugin) |
| `MYSQL_PASSWORD` | (Auto-set by Railway MySQL plugin) |
| `MYSQL_DB` | `civil_registry` |
| `MAIL_USERNAME` | Your Gmail address |
| `MAIL_PASSWORD` | Your Gmail App Password |
| `ADMIN_EMAIL` | Your Gmail address |
| `BASE_URL` | Your Railway app URL (e.g. https://yourapp.railway.app) |

### Step 4: Import Database Schema
In Railway dashboard → MySQL service → **Query tab**, paste and run `schema.sql`.

## 📁 Project Structure
```
BirthDeathProject/
├── app.py              # Main Flask application
├── requirements.txt    # Python dependencies
├── Procfile            # Railway/Render start command
├── runtime.txt         # Python version
├── schema.sql          # Database schema
├── .env.example        # Environment variable template
├── static/css/         # Stylesheets
├── templates/          # HTML templates
└── uploads/            # Uploaded proof documents (auto-created)
```

## 🔑 Default Admin Account
Create an admin user by inserting directly into MySQL:
```sql
INSERT INTO users (name, email, phone, password, role)
VALUES ('Admin', 'admin@email.com', '9999999999',
  '$2b$12$...', 'admin');
```
Or register normally and update the role to `admin` via SQL.
