# MotoEase Presentation and Q&A Guide
Gunakan panduan ini untuk demo 5 menit di depan dosen/penguji.

## Demo Flow (5 Menit)
### 1. Opening (0:00 - 1:00)
"Selamat siang, saya akan mempresentasikan MotoEase, aplikasi manajemen motor full-stack. Keunggulan aplikasi ini adalah UI Premium dengan efek Glassmorphism, keamanan JWT, dan state management menggunakan BLoC."

### 2. Login & Register (1:00 - 2:00)
"Pertama, user bisa daftar akun baru. Data dienkripsi dengan bcrypt di backend. Setelah login, token JWT disimpan di aplikasi untuk keamanan akses data motor."

### 3. Katalog & Search Debounce (2:00 - 3:30)
"Di halaman utama, user bisa melihat daftar motor. Saya mengimplementasikan Search Debounce, di mana pencarian otomatis berjalan saat user berhenti mengetik, memberikan pengalaman yang lebih mulus."

### 4. CRUD Motor & Image Picker (3:30 - 4:30)
"User bisa menambah motor baru, memilih kategori, dan mengambil foto langsung dari kamera atau galeri menggunakan Image Picker."

### 5. Closing & Technical (4:30 - 5:00)
"Aplikasi ini menggunakan clean architecture, memisahkan data layer (Repository), business logic (BLoC), dan presentation layer (UI)."

## Pertanyaan yang Sering Muncul (Q&A)
* **Q: Kenapa pakai BLoC?**
  * A: Agar logic bisnis dan UI terpisah. UI hanya mengirim event dan menerima state, sehingga kode lebih rapi dan mudah di-test.
* **Q: Bagaimana keamanan datanya?**
  * A: Kita menggunakan JWT (JSON Web Token). Setiap request ke data motor harus menyertakan token yang valid di header, jika tidak maka akses ditolak (401).
* **Q: Apa itu Debounce?**
  * A: Teknik untuk menunda eksekusi fungsi (pencarian API) sampai user selesai mengetik dalam durasi tertentu (0.5 detik), tujuannya untuk menghemat beban server.
