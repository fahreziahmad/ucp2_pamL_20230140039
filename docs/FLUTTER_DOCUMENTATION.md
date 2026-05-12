# MotoEase Flutter Documentation
Dokumen ini menjelaskan file penting, alur logic Flutter, BLoC, integrasi API, dan panduan kode MotoEase.

## File-by-File Documentation
### lib/main.dart
**Purpose**: Entry point aplikasi MotoEase.
**Logic**: Menjalankan app, menyiapkan Service Locator, dan membungkus App dengan MultiBlocProvider agar state Motor dan Kategori tersedia secara global.

### lib/core/services/
* **token_storage.dart**: Layanan khusus untuk menyimpan JWT Token dan Username secara aman menggunakan SharedPreferences.
* **api_service.dart**: Pusat komunikasi ke Backend. Menggunakan **Interceptor** untuk menyisipkan Token JWT secara otomatis ke setiap request (Authorization: Bearer).

### lib/data/models/motor_model.dart
**Purpose**: Model data motor.
**Logic**: Mengubah JSON dari backend menjadi objek Dart yang bisa dibaca UI.

### lib/blocs/catalog/
**Purpose**: Mengatur semua logic Katalog Motor.
**UX**: Mendukung fitur Search Debounce agar pencarian terasa sangat halus.

### lib/ui/screens/
* **splash_screen.dart**: Cek status login dengan animasi Lottie.
* **login_screen.dart**: Form masuk dengan tema premium.
* **register_screen.dart**: Pendaftaran akun baru.
* **home_screen.dart**: Daftar motor dengan fitur Search.
* **motor_form_screen.dart**: Tambah/Edit motor dengan Image Picker.
* **main_navigation_screen.dart**: Navigasi bawah (Katalog & Kategori).

### lib/ui/widgets/glass_card.dart
**Purpose**: Widget utama untuk tampilan "Premium Glassmorphism".

### lib/utils/currency_formatter.dart
**Logic**: Mengubah angka harga dari backend menjadi format Rupiah (contoh: 500000 -> Rp 500.000).

## Alur Autentikasi & Authorization
1. **User Login**: Kirim data ke API melalui `AuthRepository`.
2. **Handle Response**: API balas dengan JWT Token.
3. **Save Session**: Token disimpan secara aman oleh `TokenStorage`.
4. **Auto Authorization**: `ApiService` secara otomatis menyertakan token tersebut di Header pada setiap request data motor menggunakan Interceptor.
