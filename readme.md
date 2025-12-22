# SkillMatch – Flutter MVVM + Go Echo Backend

## Daftar Isi
1. Fitur Aplikasi  
2. Arsitektur MVVM  
3. Teknologi yang Digunakan  
4. Cara Menjalankan Backend  
5. Cara Menjalankan Flutter  
6. Struktur Folder  
7. Alur Kerja MVVM  

---

## Fitur Aplikasi

### Authentication
- Register
- Login

### User Profile
- Get Profile (`/users/me`)
- Update Profile (`/users/update`)

Catatan:  
CRUD untuk fitur lain (Skill, Projects, Task) belum dibuat.

---

## Arsitektur MVVM

Aplikasi menggunakan arsitektur MVVM untuk memisahkan antara UI, state, dan data.

Pola alur MVVM:

```
View  ↔  ViewModel  ↔  Repository  ↔  Backend API
```

Penjelasan:
- **Model** → Struktur data (contoh: User)
- **Repository** → Komunikasi API (HTTP POST/GET/PUT)
- **ViewModel** → Pengelolaan state menggunakan Provider
- **View** → Antarmuka aplikasi (Login, Register, Profile, Home)

---

## Teknologi yang Digunakan

### Frontend (Flutter)
- Flutter
- Provider (state management)
- HTTP package
- MVVM architecture

### Backend (Golang)
- Echo Framework
- PostgreSQL
- GORM ORM
- JWT Authentication

---

## Cara Menjalankan Backend

1. Pastikan PostgreSQL berjalan dan database telah dibuat bernama:

```
skillmatch
```

2. Menjalankan backend:

```
cd backend
go run main.go
```

3. Jika berhasil, terminal akan menampilkan:

```
Database connected!
http server started on [::]:8080
```

---

## Cara Menjalankan Flutter

1. Masuk ke folder:

```
cd skillmatch_app
flutter pub get
flutter run
```

2. Atur `baseUrl` pada file repository:

| Platform | Base URL |
|---------|-----------|
| Android Emulator | `http://10.0.2.2:8080` |
| Flutter Web (Chrome) | `http://localhost:8080` |
| Real Device (WiFi) | `http://IP-LAPTOP:8080` |

Cara melihat IP laptop (Windows):

```
ipconfig
```

Contoh:

```
http://192.168.1.10:8080
```

---

## Struktur Folder

```
lib/
│── main.dart
│
├── models/
│   └── user.dart
│
├── repositories/
│   ├── auth_repository.dart
│   └── user_repository.dart
│
├── viewmodels/
│   ├── auth_view_model.dart
│   └── profile_view_model.dart
│
└── views/
    ├── auth/
    │   ├── login_page.dart
    │   └── register_page.dart
    │
    ├── home/
    │   └── home_page.dart
    │
    └── profile/
        └── profile_page.dart
```

---

## Alur Kerja MVVM

### Login
1. Pengguna mengisi email dan password.
2. View memanggil `authViewModel.login()`.
3. ViewModel memanggil `AuthRepository.login()`.
4. Repository mengirim request POST ke backend.
5. Backend mengembalikan token dan data user.
6. ViewModel menyimpan state.
7. UI berpindah ke halaman Home/Profile.

### Update Profile
1. Pengguna mengubah data.
2. ViewModel memanggil `update()`.
3. Repository mengirim PUT `/users/update`.
4. Backend memperbarui data di database.
5. ViewModel memperbarui state.
6. UI menampilkan data terbaru.

---

# Test

penerapan **unit testing** dan **widget testing** pada aplikasi mobile berbasis Flutter.
pengujian dilakukan untuk memastikan logika aplikasi dan tampilan antarmuka berjalan dengan benar tanpa bergantung pada backend
## Daftar Fitur

## 1. Validasi Input (Unit Test)
Fitur yang dipilih untuk unit testing adalah **validasi input** pada halaman Login dan Register.

### Logika yang Diuji
File: `lib/utils/validators.dart`

Fungsi yang diuji:
- `validateEmail()`
  - Mengembalikan pesan error jika email kosong
  - Mengembalikan pesan error jika format email tidak valid
  - Mengembalikan `null` jika email valid
- `validatePassword()`
  - Mengembalikan pesan error jika password kosong
  - Mengembalikan pesan error jika panjang password kurang dari 6 karakter
  - Mengembalikan `null` jika password valid

  ## Implementasi Unit Test
File: `test/validators_test.dart`

Unit test ditulis dengan mengikuti pola **Arrange – Act – Assert (AAA)**:
- **Arrange**: Menyiapkan data atau kondisi awal
- **Act**: Memanggil fungsi yang akan diuji
- **Assert**: Memastikan hasil sesuai dengan yang diharapkan menggunakan `expect()`

Pengujian ini memastikan logika validasi input bekerja dengan benar pada berbagai kondisi.

---

## 2. Widget Testing

### Widget yang Diuji
- `HomePage`

### Tujuan Pengujian
Widget test dilakukan untuk memastikan bahwa:
- Halaman Home dapat dirender tanpa error
- Teks sambutan (Welcome back) ditampilkan
- Nama pengguna tampil pada layar
- Tombol Logout tersedia dan dapat diakses

### Implementasi Widget Test
File: `test/home_page_widget_test.dart`

Pada pengujian ini:
- `AuthViewModel` dan `ProfileViewModel` disediakan menggunakan `Provider`
- Data pengguna dummy digunakan untuk mensimulasikan kondisi pengguna sudah login
- Tidak ada pemanggilan backend atau API
## Cara Menjalankan Pengujian
Jalankan perintah berikut di root project:

```bash
flutter test

```
### Hasil Pengujian
Gambar : 

<img width="788" height="72" alt="image" src="https://github.com/user-attachments/assets/798d9577-ee0f-4de7-9c32-a1ebb71131c4" />




