# MotoEase Flutter

MotoEase Flutter adalah aplikasi mobile untuk manajemen katalog dan armada motor. Aplikasi ini terhubung ke **MotoEase Backend (Node.js)** menggunakan REST API, menyimpan JWT token secara lokal untuk keamanan, dan menggunakan **BLoC** untuk mengatur state UI secara reaktif.

## Fitur Utama

*   **Splash Screen**: Pengecekan session otomatis saat aplikasi dibuka.
*   **Login & Register**: Sistem autentikasi user lengkap.
*   **Keamanan JWT**: Penyimpanan token menggunakan `SharedPreferences` secara lokal.
*   **Otorisasi Otomatis**: Setiap request API menyertakan `Authorization: Bearer <token>` melalui Interceptor.
*   **Katalog Motor**: Tampilan daftar motor menggunakan card modern dan efek Glassmorphism.
*   **Detail Katalog**: Informasi lengkap motor, harga, status, dan kategori.
*   **Manajemen Katalog (CRUD)**:
    *   **Tambah Motor**: Form input dengan upload foto dari Kamera/Galeri.
    *   **Edit Motor**: Pembaruan data motor yang sudah ada.
    *   **Hapus Motor**: Penghapusan data dengan dialog konfirmasi keamanan.
*   **Bottom Navigation**: Navigasi mudah antara tab Katalog dan Manajemen Kategori.
*   **Pencarian Cerdas**: Fitur search dengan sistem *debounce* (tidak perlu tekan enter).
*   **Manajemen Kategori**: Halaman khusus untuk menambah dan menghapus kategori motor.
*   **Formatter Rupiah**: Harga motor otomatis ditampilkan dalam format Rupiah yang rapi.
*   **Validasi Form**: Proteksi input untuk field wajib, angka (tahun/harga), dan foto.
*   **UI Premium**: Desain modern menggunakan Gradient, Glass Panel, dan tipografi Outfit/Inter.
*   **State Management**: Penanganan kondisi Loading, Empty (Data Kosong), Error, dan Success yang konsisten.

## Teknologi yang Digunakan

*   **Framework**: Flutter
*   **State Management**: Flutter BLoC
*   **HTTP Client**: Dio (dengan Interceptor)
*   **Local Storage**: SharedPreferences
*   **Image Picker**: Untuk akses kamera dan galeri foto.

## Struktur Proyek

*   `lib/blocs/`: Manajemen state aplikasi.
*   `lib/core/`: Service dasar seperti API client dan penyimpanan token.
*   `lib/data/`: Model data dan Repository untuk akses API.
*   `lib/ui/`: Semua tampilan layar (screens) dan widget kustom.

---
*Proyek ini dikembangkan sebagai bagian dari Ujian Praktikum Pemrograman Aplikasi Mobile Lanjut.*
