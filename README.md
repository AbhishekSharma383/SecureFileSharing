# File Management System

A robust and user-friendly file management web application built with Ruby on Rails and Bootstrap 5. This system allows users to upload, manage, and share files with a clean and responsive interface.

## Features

- 📤 File Upload: Easy-to-use file upload interface
- 📋 File Management: View, download, and delete files
- 🔗 Sharing Capabilities: Generate and revoke sharing links for files
- 📱 Responsive Design: Works seamlessly across desktop and mobile devices
- 📊 File Information: Display file size, type, upload date, and description
- 🎨 Modern UI: Clean interface with Bootstrap 5 styling

## Technical Stack

- Ruby on Rails
- Bootstrap 5
- Font Awesome Icons
- Active Storage for file handling
- PostgreSQL (recommended for database)



# File Management System - Quick Start Guide 🚀

## One-Time Setup Steps

1. **Clone & Install**
   ```bash
   # Clone repository
   git clone [repository-url]
   cd file-management-system

   # Install dependencies
   bundle install
   yarn install   # or npm install

   # Setup database and storage
   rails db:create db:migrate
   rails active_storage:install
   ```

2. **Environment Setup**
   ```bash
   # Copy and configure environment files
   cp config/database.yml.example config/database.yml
   cp .env.example .env

   # Update .env with your values:
   DATABASE_USERNAME=your_postgres_username
   DATABASE_PASSWORD=your_postgres_password
   RAILS_MASTER_KEY=your_master_key
   ```

3. **Start Server**
   ```bash
   # Start Rails server
   rails server

   # Visit in browser
   open http://localhost:3000
   ```

## Quick Verification Checklist ✅

1. Homepage loads (`http://localhost:3000`)
2. "Upload New File" button visible
3. Can upload a test file
4. File appears in list
5. Download works
6. Share link generates
7. Delete function works

