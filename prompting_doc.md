# Dokumentasi Prompting - Proyek DriveEase

**Nama Mahasiswa:** [Isi Nama Kamu]  
**NIM:** [Isi NIM Kamu]  
**Mata Kuliah:** Pengembangan Aplikasi Mobile Lanjut  

## 1. Deskripsi Tugas
Membangun ekosistem manajemen armada "DriveEase" yang mengintegrasikan RESTful API (Node.js/Express & MySQL) dengan aplikasi mobile Flutter menggunakan state management BLoC dan keamanan JWT.

## 2. Daftar Prompt (Instruksi AI)

### Fase 1: Inisialisasi Proyek & Struktur Git
*   **Prompt:** "Inisialisasi git repository di folder proyek. Buat dua branch: `main` untuk kode Flutter dan `backend` untuk RESTful API. Pastikan masing-masing branch memiliki minimal 10 commit dengan pesan dalam Bahasa Indonesia."
*   **Hasil:** Struktur proyek terpisah secara profesional dengan riwayat commit yang detail.

### Fase 2: Pengembangan Backend (Branch: `backend`)
*   **Prompt:** "Buat server RESTful API menggunakan Node.js dan Express. Implementasikan keamanan JWT untuk login dan registrasi. Buat CRUD untuk tabel Katalog Mobil dan Kategori. Gunakan MySQL sebagai database dan sertakan script `init_db.sql`."
*   **Hasil:** Server API fungsional dengan proteksi middleware pada setiap endpoint sensitif.

### Fase 3: Pengembangan Frontend (Branch: `main`)
*   **Prompt:** "Bangun aplikasi Flutter dengan arsitektur BLoC. Tambahkan dependensi seperti `flutter_bloc`, `dio`, dan `get_it`. Buat layar Login yang premium, Dashboard untuk daftar mobil, dan formulir Tambah/Edit mobil. Integrasikan dengan API backend."
*   **Hasil:** Aplikasi mobile yang responsif, memiliki performa optimal, dan terintegrasi penuh dengan server.

### Fase 4: Finalisasi & Sinkronisasi
*   **Prompt:** "Perbaiki seluruh pesan commit di riwayat Git menjadi Bahasa Indonesia. Lakukan force push ke GitHub repository `ucp2_pamL_20230140039` milik `fahreziahmad`."
*   **Hasil:** Repository GitHub yang rapi dan sesuai dengan seluruh ketentuan tugas.

## 3. Detail Implementasi Teknis
1.  **Backend**: Node.js, Express, MySQL, JWT, Bcrypt (Hashing Password).
2.  **Frontend**: Flutter SDK, BLoC Pattern, Dio (HTTP Client), GetIt (Service Locator).
3.  **Database**: Relasi antara tabel `users`, `categories`, dan `cars`.

---

**Link Repository GitHub:** https://github.com/fahreziahmad/ucp2_pamL_20230140039
