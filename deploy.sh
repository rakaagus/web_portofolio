#!/bin/bash
echo "🔨 Building Flutter Web..."
flutter build web --release

echo "🚀 Uploading to VPS..."
scp -r build/web/* afydev@157.10.253.61:/var/www/artforyou.my.id/html/

echo "✅ Deployment Done!"