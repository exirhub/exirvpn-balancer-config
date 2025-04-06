#!/bin/bash

# === CONFIG ===
APP_DIR="file-upload-api"
TARGET_DIR="/etc/x-ui"     # Where uploaded files will be saved
PORT=3000

# === SETUP ===
echo "📦 Checking Node.js..."
if ! command -v node &> /dev/null; then
  echo "🚀 Installing Node.js..."
  curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
  sudo apt-get install -y nodejs
fi

echo "📁 Creating project in $APP_DIR..."
mkdir -p $APP_DIR && cd $APP_DIR

echo "📦 Installing dependencies..."
sudo npm install
sudo npm install -g pm2
sudo npm install express
sudo npm install multer

echo "📝 Writing server.js..."
mkdir -p "$TARGET_DIR"
cat <<EOF > server.js
const express = require('express');
const multer = require('multer');
const fs = require('fs');
const path = require('path');

const app = express();
const upload = multer({ dest: 'uploads/' });
const TARGET_PATH = '$TARGET_DIR';

app.post('/upload', upload.single('file'), (req, res) => {
  if (!req.file) return res.status(400).send('No file uploaded');

  const tempPath = req.file.path;
  const targetPath = path.join(TARGET_PATH, req.file.originalname);

  fs.rename(tempPath, targetPath, err => {
    if (err) return res.status(500).send('Failed to move file');
    res.send('✅ File uploaded and moved!');
  });
});

app.listen($PORT, () => {
  console.log('🚀 File API running at http://localhost:$PORT/upload');
});
EOF
echo "🚀 Starting server with PM2..."
sudo pm2 start server.js

# === Save PM2 process list & enable on boot ===
sudo pm2 save
