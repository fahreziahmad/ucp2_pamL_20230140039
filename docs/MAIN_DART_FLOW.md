# App Startup & Main Flow Logic

Dokumen ini menjelaskan apa yang terjadi di balik layar saat aplikasi MotoEase pertama kali dijalankan.

## 1. Bootstrapping (main.dart)
Saat fungsi `main()` dijalankan:
1.  **Service Initialization**: Aplikasi menyiapkan `TokenStorage` (untuk baca kunci login) dan `ApiService` (untuk koneksi internet).
2.  **Dependency Injection**: Seluruh Repository (Auth, Catalog, Category) didaftarkan agar bisa dipakai oleh BLoC.
3.  **Bloc Creation**: BLoC utama dibuat dan langsung mulai mendengarkan perintah dari UI.

## 2. Authentication Check (App Startup)
Segera setelah aplikasi menyala, **AuthBloc** menjalankan event `AppStarted`:
*   Aplikasi mengecek ke `TokenStorage`: *"Apakah user ini punya kunci login yang valid?"*
*   **Jika ADA**: Status berubah menjadi `Authenticated`, dan user langsung diarahkan ke **HomeScreen (Katalog)**.
*   **Jika TIDAK ADA**: Status menjadi `Unauthenticated`, dan user diarahkan ke halaman **Login**.

## 3. Data Loading Flow
Di dalam halaman Katalog (`HomeScreen`):
1.  UI mengirim perintah `FetchCatalog`.
2.  **CatalogBloc** memanggil `CatalogRepository`.
3.  `CatalogRepository` memanggil API melalui `ApiService`.
4.  `ApiService` secara otomatis menempelkan **JWT Token** di header.
5.  Server mengirim data JSON motor.
6.  BLoC mengubah data JSON menjadi `MotorModel` dan mengirimkannya kembali ke UI untuk ditampilkan.

## 4. CRUD Lifecycle
*   **Create/Update**: User mengisi form -> Kirim data + foto -> BLoC kirim ke API -> API balas sukses -> BLoC memerintahkan Katalog untuk refresh otomatis.
*   **Delete**: User klik hapus -> Konfirmasi dialog -> API hapus data -> Katalog otomatis terupdate tanpa perlu tarik layar manual.

---
**Key Highlight**: Alur ini memastikan bahwa tidak ada data yang bisa diakses tanpa melalui pengecekan token JWT di `ApiService`.
