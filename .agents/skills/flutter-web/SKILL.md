# Flutter Web — Konfigurasi & Best Practices

## 🎯 Tujuan
Panduan khusus untuk pengembangan **Flutter Web** di project ini, karena memiliki perbedaan signifikan dengan Flutter Mobile.

## 🌐 Perbedaan Flutter Web vs Mobile

| Aspek | Flutter Web | Flutter Mobile |
|-------|-------------|----------------|
| Database | Drift + SQLite WebAssembly | Drift + SQLite native |
| URL | Path strategy (`/experience`) | Deeplink / named route |
| Navigasi | Browser back/forward | System back button |
| Assets | Loaded via HTTP | Bundled native |
| Permissions | Web APIs | Android/iOS permissions |
| Rendering | CanvasKit / HTML | Native/Skia |

## 📁 File Web Penting

```
web/
├── index.html          # Entry HTML — meta tags, title, favicon
├── manifest.json       # PWA manifest — installable app
├── icons/              # PWA icons (192, 512, maskable)
├── drift_worker.js     # Web worker untuk Drift database
├── sqlite3.wasm        # SQLite WebAssembly binary
└── favicon.png         # Favicon
```

## 🏗️ Setup Web (dari Flutter project)

### 1. Tambahkan Web Support
Project sudah punya folder `web/`, tapi untuk project baru:
```bash
flutter create --platforms=web .
```

### 2. Drift untuk Web
File: `lib/data/local/drift/database/databases.dart`

```dart
static QueryExecutor _openConnection() {
  return driftDatabase(
    name: 'web_portofolio.db',
    web: DriftWebOptions(
      sqlite3Wasm: Uri.parse('sqlite3.wasm'),
      driftWorker: Uri.parse('drift_worker.dart.js'),
    ),
  );
}
```

**Catatan**: File `drift_worker.dart.js` akan digenerate dari `drift_worker.dart` saat build. Pastikan file `drift_worker.dart` ada di folder `web/`.

### 3. URL Path Strategy
File: `lib/main.dart`

```dart
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();  // URL tanpa '#'
  runApp(MyPortoApp());
}
```

## 🖥️ PWA (Progressive Web App)

### Manifest
File: `web/manifest.json`
```json
{
  "name": "Web Portofolio",
  "short_name": "Portofolio",
  "start_url": "/",
  "display": "standalone",
  "background_color": "#ffffff",
  "theme_color": "#000000",
  "icons": [
    {
      "src": "icons/Icon-192.png",
      "sizes": "192x192",
      "type": "image/png"
    },
    {
      "src": "icons/Icon-512.png",
      "sizes": "512x512",
      "type": "image/png"
    }
  ]
}
```

### Meta Tags (SEO)
File: `web/index.html`
```html
<meta name="description" content="Portofolio Raka Agus - Mobile Engineer">
<meta name="theme-color" content="#000000">
<meta property="og:title" content="Raka Agus - Mobile Dev">
```

## 🚀 Build & Deploy

### Build Production
```bash
flutter build web --release
```
Output di folder `build/web/`

### Deploy ke Server
**Penting**: Konfigurasi `fallback` ke `index.html` untuk SPA routing.

**GitHub Pages**:
- Copy `build/web/*` ke branch `gh-pages` atau folder `/docs`

**Firebase Hosting**:
```json
// firebase.json
{
  "hosting": {
    "public": "build/web",
    "rewrites": [
      { "source": "**", "destination": "/index.html" }
    ]
  }
}
```

## 🧠 Best Practices Flutter Web

### 1. Assets Loading
```dart
// Web: AssetImage jalan normal
Image.asset('assets/images/profile_image.jpeg')

// Gunakan precache untuk performa
await precacheImage(const AssetImage('...'), context);
```

### 2. Responsive Font & Layout
```dart
// Jangan pakai fontSize statis untuk judul besar
style: Theme.of(context).textTheme.displayLarge?.copyWith(
  fontSize: MediaQuery.of(context).size.width < 650 ? 40 : 56,
)
```

### 3. URL & Deep Linking
```dart
// Buka link eksternal
Future<void> _launchURL(String urlString) async {
  final Uri url = Uri.parse(urlString);
  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }
}
```

### 4. Web-Specific Considerations

#### CanvasKit vs HTML Renderer
```bash
# CanvasKit (default — konsisten di semua browser)
flutter build web --release

# HTML renderer (lebiih kecil tapi kurang konsisten)
flutter build web --web-renderer html
```

#### Scrolling & Layout
- Gunakan `ListView` / `SingleChildScrollView` — web tidak punya native scroll
- Hindari `Overflow` — selalu test di berbagai ukuran layar

#### Back/Forward Browser
- `PageRouteBuilder` tetap bekerja
- Browser back/forward menavigasi history

#### Web Rendering
- Gunakan `CanvasKit` untuk rendering konsisten
- `lottie` dan `shimmer` berjalan normal

## 🚨 Aturan Flutter Web
1. **SELALU gunakan `usePathUrlStrategy()`** untuk URL bersih
2. **Pastikan server fallback** ke `index.html` saat deploy
3. **Test responsif** di mobile, tablet, dan desktop browser
4. **JANGAN gunakan plugin mobile-only** tanpa web support
5. **Precache assets penting** untuk performa
6. **Sesuaikan ukuran font** dengan breakpoint (bukan statis)
7. **Jalankan di browser**: `flutter run -d chrome`

## 🧪 Testing Web
```bash
# Jalankan di Chrome
flutter run -d chrome

# Build untuk production
flutter build web --release

# Test di berbagai ukuran layar (devtools)
# Responsive: 375px (mobile), 768px (tablet), 1440px (desktop)