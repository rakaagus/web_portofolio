# PRD Estimation — Estimasi Timeline & Prioritas

## 🎯 Tujuan
Estimasi timeline untuk pengembangan fitur-fitur di **Web Portofolio** berdasarkan prioritas (P1, P2, P3).

## 📅 Estimasi Timeline

### Fase 1: MVP (P1) — Estimasi: 2-3 Minggu ✅ (Selesai)

| Fitur | Estimasi | Status |
|-------|----------|--------|
| Setup project Flutter Web + Clean Architecture | 1 hari | ✅ |
| Theme (Dark/Light) + Color System | 1 hari | ✅ |
| Localization (ID/EN) | 1 hari | ✅ |
| Navigasi (Sidebar + Bottom Bar) | 2 hari | ✅ |
| Halaman Home (Hero, About, Experience, Projects, Contact, Footer) | 4 hari | ✅ |
| Halaman Experience (Timeline detail) | 2 hari | ✅ |
| Halaman Projects (Grid + Filter + Pagination) | 2 hari | ✅ |
| Halaman Blog (Empty state) | 1 hari | ✅ |
| Responsive Design (Mobile, Tablet, Desktop) | 2 hari | ✅ |
| Page Transition + Loading Animation | 1 hari | ✅ |
| 404 Not Found Page | 0.5 hari | ✅ |
| **Total Fase 1** | **~17.5 hari** | **✅ Selesai** |

### Fase 2: P2 (Should Have) — Estimasi: 1-2 Minggu

| Fitur | Estimasi | Status |
|-------|----------|--------|
| Drift Database Setup + Entity + DAO | 2 hari | 🟡 Parsial |
| Repository Pattern + Implementasi | 2 hari | 🟡 Parsial |
| BLoC Integration (data dari database) | 2 hari | ⬜ Belum |
| Animasi (hover, loading, transition) | 1 hari | ✅ Selesai |
| PWA (manifest, icons, install) | 1 hari | ✅ Selesai |
| **Total Fase 2** | **~8 hari** | **🟡 Sebagian** |

### Fase 3: P3 (Nice to Have) — Estimasi: 2-3 Minggu

| Fitur | Estimasi | Status |
|-------|----------|--------|
| Blog CMS (Admin panel + CRUD) | 5 hari | ⬜ Belum |
| Contact Form Backend (email) | 3 hari | ⬜ Belum |
| Analytics (Google Analytics) | 1 hari | ⬜ Belum |
| SEO Optimization (meta tags, sitemap) | 2 hari | ⬜ Belum |
| **Total Fase 3** | **~11 hari** | **⬜ Belum** |

## 📊 Ringkasan Total

| Fase | Hari | Status |
|------|------|--------|
| **Fase 1 (MVP)** | ~17.5 hari | ✅ **Selesai** |
| **Fase 2 (Should Have)** | ~8 hari | 🟡 Sebagian |
| **Fase 3 (Nice to Have)** | ~11 hari | ⬜ Belum |
| **Total** | **~36.5 hari** | **🟡 On Progress** |

## 🚀 Prioritas Selanjutnya

### 1. Tinggi (Segera)
- Selesaikan integrasi database Drift + Repository + BLoC
- Hubungkan data dari database ke UI

### 2. Sedang
- Blog CMS (admin panel)
- Contact form backend

### 3. Rendah
- Analytics
- SEO Optimization

## ✅ Catatan
- Estimasi bersifat relatif dan bisa berubah tergantung kompleksitas
- Semua fitur P1 (MVP) sudah selesai dan berfungsi
- Fokus saat ini adalah menyelesaikan P2 (database integration)
- P3 akan dikerjakan setelah P2 selesai