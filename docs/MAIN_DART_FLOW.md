# MotoEase main.dart Flow Documentation
Dokumen ini menjelaskan alur awal aplikasi saat pertama kali dijalankan.

## Peran main.dart
`main.dart` adalah pusat inisialisasi aplikasi. Di sini kita menyiapkan pondasi utama:
1. **TokenStorage**: Dibuat untuk mengelola session login user.
2. **ApiService**: Komponen utama komunikasi data yang memerlukan `TokenStorage` untuk otorisasi request.
3. **Service Locator**: Menyiapkan dependency injection (GetIt) agar repository, service, dan storage mudah dipanggil di mana saja.
4. **State Management**: Memasang `MultiBlocProvider` agar Auth, Catalog, dan Category BLoC siap digunakan.

## Alur Booting
1. **WidgetsFlutterBinding**: Menyiapkan engine Flutter agar bisa menjalankan fungsi async sebelum `runApp`.
2. **setupLocator()**: Mendaftarkan `TokenStorage`, `ApiService`, dan semua `Repository` ke dalam Service Locator (GetIt).
3. **MultiBlocProvider**:
   * `AuthBloc`: Mengambil instance `TokenStorage` dan menjalankan event `AppStarted` untuk cek apakah user masih login.
   * `CatalogBloc` & `CategoryBloc`: Disiapkan dengan repository masing-masing.
4. **MaterialApp**: Menentukan tema global dan membuka `SplashScreen`.

## Alur Dependency
**Screen/BLoC** -> **Repository** -> **ApiService** -> **Backend API**.
Dengan alur ini, kode menjadi rapi karena masing-masing file punya tanggung jawab yang spesifik.
