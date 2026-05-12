# MotoEase Flutter Documentation
Dokumen ini menjelaskan struktur file, alur logika BLoC, integrasi API dengan JWT, dan panduan teknis untuk aplikasi MotoEase.

## File-by-File Documentation

### lib/main.dart
**Purpose**: Titik masuk utama (Entry Point) aplikasi.
**Logic**: Melakukan inisialisasi service utama, mengatur dependency injection, dan menentukan layar awal.
**Main Parts**:
*   **main()**: Menyiapkan `TokenStorage` dan `ApiService` sebelum aplikasi dijalankan.
*   **MultiRepositoryProvider**: Menyediakan repository agar bisa diakses oleh semua BLoC.
*   **MotoEaseApp**: Mengatur tema global (Glassmorphism) dan memasang BLoC (Auth, Catalog, Category).
*   **SplashScreen**: Menentukan apakah user harus login atau langsung ke halaman utama berdasarkan token.

### lib/core/services/api_service.dart
**Purpose**: Service pusat untuk semua request HTTP menggunakan Dio.
**Logic**: Menyediakan **Interceptor** yang otomatis menyisipkan `Authorization: Bearer <token>` ke setiap request backend. Ini adalah layer **Authorization** utama aplikasi.

### lib/core/services/token_storage.dart
**Purpose**: Manajemen penyimpanan JWT Token secara lokal menggunakan `SharedPreferences`.
**Logic**: Menyimpan token saat login/register dan menghapus token saat logout agar session user aman.

### lib/data/models/
*   **user_model.dart**: Memetakan data user dari database.
*   **motor_model.dart**: Model data utama katalog motor (nama, model, harga, gambar, dll).
*   **category_model.dart**: Model data untuk pengelompokan jenis motor.

### lib/data/repositories/
*   **auth_repository.dart**: Menangani komunikasi API untuk Login dan Register.
*   **catalog_repository.dart**: Menangani CRUD motor (Create, Read, Update, Delete) dan upload foto.
*   **category_repository.dart**: Menangani manajemen data kategori motor.

### lib/blocs/ (State Management)
*   **AuthBloc**: Mengatur status login user. Jika sukses daftar, user diarahkan kembali ke login sesuai permintaan alur manual.
*   **CatalogBloc**: Mengatur aliran data katalog motor, termasuk fitur pencarian (Search) dan sinkronisasi data setelah CRUD.
*   **CategoryBloc**: Mengatur data kategori agar sinkron antara halaman manajemen kategori dan dropdown di form motor.

### lib/ui/screens/
*   **login_screen.dart**: Form masuk dengan validasi dan desain gradient premium.
*   **register_screen.dart**: Form pendaftaran akun baru dengan notifikasi sukses yang informatif.
*   **home_screen.dart (Catalog List)**: Halaman utama menampilkan daftar motor dengan pencarian cerdas.
*   **motor_form_screen.dart**: Form canggih untuk menambah/mengedit motor lengkap dengan pemilihan foto dari Galeri/Kamera.
*   **category_screen.dart**: Manajemen kategori (Tambah/Hapus) untuk pengelompokan motor.

## Flutter Logic Documentation

### Alur Autentikasi & JWT
Aplikasi menerapkan **2 Layer Keamanan**:
1.  **Authentication**: Dilakukan di `AuthBloc` saat login. User mendapatkan JWT Token dari backend.
2.  **Authorization**: Dilakukan di `ApiService`. Setiap kali aplikasi mengambil data motor, token JWT otomatis dikirim di header. Jika token tidak valid, server akan menolak akses data.

### BLoC Pattern
Aplikasi memisahkan antara tampilan (UI) dan logika bisnis (BLoC).
*   **Event**: Perintah dari UI (contoh: Klik tombol hapus).
*   **State**: Status tampilan (contoh: Muncul loading, lalu sukses, lalu data terupdate).

### Fitur Unggulan (CRUD & Media)
*   **Image Handling**: Aplikasi mendukung tampilan gambar dari URL internet maupun file lokal HP, sehingga foto motor yang baru diupload langsung bisa terlihat.
*   **Search Debounce**: Fitur pencarian tidak akan membebani server karena menggunakan delay (debounce) saat user mengetik.
*   **Currency Formatter**: Harga motor otomatis diformat agar mudah dibaca oleh user.

---
**Presentation Tip**: Saat demo, tunjukkan file `api_service.dart` untuk membuktikan implementasi Authorization JWT, dan tunjukkan `home_screen.dart` untuk mendemokan fitur CRUD yang real-time.
