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

## State Management

Aplikasi ini sepenuhnya menggunakan **BLoC (Business Logic Component)** untuk memisahkan logika bisnis dari tampilan (UI):

*   **AuthBloc**: Mengatur alur *Splash token check*, login, register, dan logout.
*   **CatalogBloc**: Mengatur *load catalog*, pencarian (search), create, update, delete, upload image, hingga sinkronisasi data katalog.
*   **CategoryBloc**: Mengatur manajemen kategori (load, create, dan delete kategori).

**Alur Data**:
1.  **UI** tidak memanggil API secara langsung, melainkan mengirim **Event** ke BLoC.
2.  **BLoC** memproses logika dan memanggil **Repository**.
3.  **Repository** berkomunikasi dengan backend melalui **ApiService**.
4.  Hasilnya dikembalikan ke UI dalam bentuk **State** (Loading, Success, Empty, atau Error).

4.  Hasilnya dikembalikan ke UI dalam bentuk **State** (Loading, Success, Empty, atau Error).

## Alur Aplikasi

1.  **Start Up**: User membuka aplikasi, Splash screen mengecek token lokal di penyimpanan HP.
2.  **Auth Check**: Jika belum login, user diarahkan ke halaman Login/Register. Jika sudah login, langsung masuk ke Katalog.
3.  **Authentication**: Setelah pendaftaran sukses, user diminta login manual. Token dari login sukses disimpan otomatis.
4.  **Data Fetching**: Halaman utama (Catalog) mengambil data motor secara real-time dari backend.
5.  **Navigasi**: User berpindah antara tab **Katalog Motor** dan **Manajemen Kategori** melalui Bottom Navigation.
6.  **Manajemen Data**: User dapat melakukan pencarian, melihat detail, menambah, mengubah, hingga menghapus data motor dan kategori.
7.  **Token Security**: Jika kunci login (token) kedaluwarsa atau tidak valid, server akan menolak akses data dan aplikasi otomatis mengarahkan user untuk login ulang demi keamanan.

## Struktur Proyek

*   `lib/blocs/`: Manajemen state aplikasi.
*   `lib/core/`: Service dasar seperti API client dan penyimpanan token.
*   `lib/data/`: Model data dan Repository untuk akses API.
*   `lib/ui/`: Semua tampilan layar (screens) dan widget kustom.


