-- ==========================================================
-- SUPABASE SCHEMA UNTUK WEB PORTOFOLIO (Raka Agus Maulana)
-- Jalankan skrip ini di: Supabase Dashboard -> SQL Editor -> New Query
-- ==========================================================

-- 1. TABEL PROJECTS
CREATE TABLE IF NOT EXISTS public.projects (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    slug TEXT UNIQUE NOT NULL,
    title TEXT NOT NULL,
    description TEXT NOT NULL,
    overview TEXT,
    architecture TEXT,
    challenges TEXT,
    category TEXT DEFAULT 'Mobile',
    tech_stacks TEXT[] DEFAULT '{}',
    image_url TEXT,
    demo_url TEXT,
    github_url TEXT,
    playstore_url TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 2. TABEL EXPERIENCES
CREATE TABLE IF NOT EXISTS public.experiences (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    company_name TEXT NOT NULL,
    role TEXT NOT NULL,
    description TEXT,
    start_date TEXT NOT NULL,
    end_date TEXT NOT NULL,
    has_finished BOOLEAN DEFAULT false,
    category TEXT DEFAULT 'Work',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- 3. TABEL CERTIFICATIONS
CREATE TABLE IF NOT EXISTS public.certifications (
    id UUID DEFAULT gen_random_uuid() PRIMARY KEY,
    title TEXT NOT NULL,
    issuer TEXT NOT NULL,
    issue_date TEXT NOT NULL,
    expiry_date TEXT,
    credential_id TEXT,
    credential_url TEXT,
    logo_url TEXT,
    skills TEXT[] DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT timezone('utc'::text, now()) NOT NULL
);

-- ==========================================================
-- ENABLE ROW LEVEL SECURITY (RLS) & PUBLIC READ ACCESS
-- ==========================================================
ALTER TABLE public.projects ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.experiences ENABLE ROW LEVEL SECURITY;
ALTER TABLE public.certifications ENABLE ROW LEVEL SECURITY;

-- Izinkan publik membaca data portofolio (Read-Only)
CREATE POLICY "Allow public read projects" ON public.projects FOR SELECT USING (true);
CREATE POLICY "Allow public read experiences" ON public.experiences FOR SELECT USING (true);
CREATE POLICY "Allow public read certifications" ON public.certifications FOR SELECT USING (true);

-- ==========================================================
-- SEED DATA AWAL (Contoh Data)
-- ==========================================================
INSERT INTO public.projects (slug, title, description, overview, architecture, challenges, category, tech_stacks, image_url, demo_url, github_url)
VALUES
(
    'smart-parking-system',
    'Smart Parking System',
    'A comprehensive parking solution with NFC integration, real-time monitoring, and seamless mobile payments.',
    'Smart Parking System is designed to modernize vehicle management across commercial areas with ticketless gate tapping and live lot occupancy monitoring.',
    'Clean Architecture and MVI pattern on Android using Kotlin & Jetpack Compose, paired with a Flutter Web dashboard for parking operators.',
    'Low-latency NFC communication with hardware turnstiles and offline transactional queueing.',
    'Mobile',
    ARRAY['Flutter', 'Kotlin', 'NFC', 'Jetpack Compose', 'Firebase'],
    'assets/images/profile_image.jpeg',
    'https://github.com/rakaagus',
    'https://github.com/rakaagus'
),
(
    'wedding-reservation-platform',
    'Wedding Reservation Platform',
    'Modular wedding invitation and attendance reservation system built for high scalability and customization.',
    'Responsive digital invitation and reservation platform with live RSVP verification and customizable guest management.',
    'Flutter Web with responsive layout system and BLoC state management.',
    'Fast responsive cross-browser rendering and real-time attendance counter.',
    'Web',
    ARRAY['Flutter Web', 'Dart', 'BLoC', 'Firebase'],
    'assets/images/profile_image.jpeg',
    'https://github.com/rakaagus',
    'https://github.com/rakaagus'
),
(
    'smart-pos-handheld',
    'Smart POS Handheld',
    'Android-based Point of Sale system optimized for handheld devices with thermal printer and e-money support.',
    'Point of Sale terminal application optimized for handheld Android hardware with integrated receipt printing.',
    'Native Android SDK, Room DB offline-first persistence, Coroutines & Flow, and thermal printer driver integration.',
    'Bluetooth/USB printer spooling stability and low-latency barcode scanning.',
    'Mobile',
    ARRAY['Android SDK', 'Kotlin', 'Room DB', 'Hardware Interop'],
    'assets/images/profile_image.jpeg',
    'https://github.com/rakaagus',
    'https://github.com/rakaagus'
)
ON CONFLICT (slug) DO NOTHING;

INSERT INTO public.certifications (title, issuer, issue_date, expiry_date, credential_id, credential_url, skills)
VALUES
(
    'Google Associate Android Developer',
    'Google Developers Certification',
    '2023',
    '2026',
    'AAD-8492048',
    'https://developers.google.com/certification/directory',
    ARRAY['Android', 'Kotlin', 'Jetpack', 'Testing', 'Clean Architecture']
),
(
    'Menjadi Android Developer Expert (MADE)',
    'Dicoding Indonesia',
    '2023',
    NULL,
    'DICODING-MADE-91823',
    'https://www.dicoding.com/certificates',
    ARRAY['Kotlin', 'Coroutines', 'Room Database', 'Dagger/Hilt', 'Clean Architecture']
),
(
    'Belajar Fundamental Aplikasi Flutter',
    'Dicoding Indonesia',
    '2024',
    NULL,
    'DICODING-FLUTTER-77124',
    'https://www.dicoding.com/certificates',
    ARRAY['Flutter', 'Dart', 'BLoC', 'State Management', 'REST API']
),
(
    'Jetpack Compose: Building Modern Android Apps',
    'Android Developers',
    '2024',
    NULL,
    'JC-ANDROID-2024',
    'https://developer.android.com/courses/pathways/compose',
    ARRAY['Declarative UI', 'Compose State', 'Material 3', 'Animations']
)
ON CONFLICT DO NOTHING;
