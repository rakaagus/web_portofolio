# PRD — Product Requirements Document

## 🎯 Tujuan
Dokumen ini mendefinisikan persyaratan produk untuk **Web Portofolio** — portofolio online personal yang menampilkan profil, pengalaman, proyek, dan blog.

## 👤 Persona
- **Target User**: Rekruter, klien potensial, sesama developer
- **User Goals**: Melihat portofolio, memahami skill, menghubungi pemilik

## 📋 Fitur & Persyaratan

### P1 — Must Have (MVP)

#### 1. Halaman Home
- **Hero Section**: Nama, tagline, social links, CTA
- **About Section**: Profil, bio, pendidikan, tech stack
- **Experience Section**: Timeline pengalaman kerja
- **Projects Section**: Grid proyek dengan tech stack
- **Testimonials Section**: Testimoni (jika ada)
- **Contact Section**: Form kontak
- **Footer**: Links, copyright

#### 2. Halaman Experience
- Timeline detail pengalaman kerja
- Informasi: role, perusahaan, periode, deskripsi

#### 3. Halaman Projects
- Grid proyek dengan filter kategori (All, Mobile, Web, Desktop)
- Pagination
- Detail proyek: tech stack, demo link

#### 4. Halaman Blog
- Daftar artikel blog
- **Status**: Empty state (belum ada data)

#### 5. Navigasi
- Sidebar (desktop) — liquid glass, expand on hover
- Bottom bar (mobile) — glass bottom bar
- URL path strategy (`/experience`, `/projects`, dll.)

#### 6. Tema
- Dark/Light mode toggle
- Responsive: Mobile, Tablet, Desktop

#### 7. Lokalisasi
- Bahasa Indonesia (ID)
- English (EN)

### P2 — Should Have

#### 1. Database Lokal (Drift)
- Simpan data portofolio, pendidikan, pengalaman, skill, gambar, organisasi
- SQLite via WebAssembly untuk web

#### 2. Animasi
- Page transition (Slide + Fade)
- Loading animation (block reveal)
- Hover effects (card lift, button arrow)

#### 3. PWA
- Installable web app
- Manifest + icons

### P3 — Nice to Have

#### 1. Blog CMS
- Admin panel untuk CRUD blog
- Markdown editor

#### 2. Contact Form Backend
- Kirim pesan ke email
- Validasi form

#### 3. Analytics
- Google Analytics / custom tracking

#### 4. SEO Optimization
- Meta tags, sitemap, structured data

## 🎨 Design System
- **Theme**: Glassmorphism (BackdropFilter + blur)
- **Background**: Mesh gradient (5 variasi)
- **Font**: Plus Jakarta Sans (PJS)
- **Icons**: Font Awesome, Material Icons
- **Colors**: Light & Dark color scheme (via `colorScheme`)

## 🏗️ Arsitektur
- **Framework**: Flutter Web
- **Architecture**: Clean Architecture (Data, Domain, Presentation)
- **State Management**: flutter_bloc
- **Database**: Drift (SQLite WebAssembly)
- **DI**: get_it
- **Localization**: flutter_localizations + ARB files

## 📊 Metrik Kesuksesan
- [ ] Semua halaman dapat diakses tanpa error
- [ ] Responsive di mobile, tablet, desktop
- [ ] Dark & light theme berfungsi
- [ ] Lokalisasi ID & EN lengkap
- [ ] PWA dapat diinstall
- [ ] `flutter analyze` bersih
- [ ] `flutter test` lulus