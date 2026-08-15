# Mermaid Standards — Standar Diagram Mermaid

## 🎯 Tujuan
Standar penggunaan diagram **Mermaid** untuk dokumentasi di project ini. Mermaid membantu memvisualisasikan arsitektur, alur, dan relasi secara konsisten.

## 📊 Jenis Diagram yang Digunakan

### 1. Flowchart — Alur Proses
Digunakan untuk: Alur data, proses bisnis, flow navigasi.

```mermaid
flowchart TD
    A[UI / Widget] -->|emit event| B[BLoC]
    B -->|call method| C[Repository Interface]
    C -->|implements| D[Repository Impl]
    D -->|query| E[Drift DAO]
    E -->|access| F[AppDatabase]
```

**Aturan**:
- Gunakan `TD` (top-down) untuk alur proses
- Label edge dengan `-->|label|`
- Node text dalam `[]` atau `()`

### 2. Sequence Diagram — Urutan Interaksi
Digunakan untuk: Interaksi antar komponen, API calls.

```mermaid
sequenceDiagram
    participant U as User
    participant W as Widget
    participant B as BLoC
    participant R as Repository

    U->>W: Klik Tombol
    W->>B: Dispatch Event
    B->>R: Get Data
    R-->>B: Return Data
    B-->>W: Emit State
    W-->>U: Render UI
```

**Aturan**:
- Gunakan `participant` dengan alias singkat
- Arrow solid `->>` untuk call, dashed `-->>` untuk return
- Deskripsi interaksi dalam bahasa Indonesia

### 3. Class Diagram — Struktur Class
Digunakan untuk: Arsitektur, pola desain.

```mermaid
classDiagram
    class AppDatabase {
        +schemaVersion: int
        +migration: MigrationStrategy
        +_openConnection() QueryExecutor
    }
    class ExperienceDao {
        +getAllExperiences() Future
        +insertExperience() Future
    }
    AppDatabase --> ExperienceDao : has DAO
```

### 4. ER Diagram — Entity Relationship
Digunakan untuk: Skema database, relasi tabel.

```mermaid
erDiagram
    EXPERIENCE ||--o{ IMAGE : has
    EXPERIENCE {
        string id PK
        string companyName
        string role
        datetime startDate
        datetime endDate
        bool hasFinished
    }
    IMAGE {
        string id PK
        string url
    }
```

## 📍 Penempatan Diagram dalam Dokumentasi

### 1. Dokumentasi Arsitektur (`.agents/skills/*/SKILL.md`)
```markdown
## 🔄 Alur Data
```mermaid
flowchart TD
    A --> B
```
```

### 2. Dokumentasi Spesifikasi (`.agents/spec/*.md`)
Gunakan sequence diagram untuk flow user:
```mermaid
sequenceDiagram
    User->>HomePage: Buka /experience
    HomePage->>ExperienceBloc: LoadExperiences()
    ExperienceBloc->>Repository: getExperiences()
    Repository-->>ExperienceBloc: UIDataEntity
    ExperienceBloc-->>HomePage: ExperienceLoaded
    HomePage-->>User: Tampilkan Timeline
```

## 🚨 Aturan Mermaid
1. **SELALU gunakan sintaks yang valid** — test di [Mermaid Live Editor](https://mermaid.live)
2. **Gunakan label Bahasa Indonesia** untuk deskripsi user-facing
3. **Pisahkan node** dengan baris baru — jangan satu baris panjang
4. **Gunakan alias** untuk panjang: `A[UI / Widget]`
5. **JANGAN gunakan emoji** di dalam diagram (bisa break renderer)
6. **Sesuaikan arah**: `TD` untuk top-down, `LR` untuk left-right
7. **Dokumentasikan dengan diagram** — jangan hanya teks untuk menjelaskan arsitektur

## ✅ Contoh Lengkap — Alur Load Data

```mermaid
flowchart TD
    A[Widget/UI] -->|BlocProvider| B[BLoC]
    B -->|add event| C[Bloc.on Event]
    C -->|call repository| D[Repository Interface]
    D -->|implements| E[Repository Impl]
    E -->|try-catch| F{Error?}
    F -->|Yes| G[emit Error State]
    F -->|No| H[emit Loaded State]
    G --> I[UI: Tampilkan pesan error]
    H --> J[UI: Tampilkan data]
```

Diagram ini digunakan di dokumentasi untuk menjelaskan pola error handling yang konsisten.