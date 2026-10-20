# Fandom Vault

Aplikasi Flutter untuk penggemar K-Pop yang mengoleksi photocard dan album: melacak kartu yang sudah dimiliki, kartu wishlist, halaman binder, dan progres melengkapi koleksi bias.

> Tugas **AFL 1: Production-Ready Flutter Application & Architecture Case Study** (Visual Programming), Track A: *The Fandom Vault*.

## Studi Kasus

**Pengguna:** penggemar K-Pop yang menyimpan photocard di binder fisik dan membuka app lewat HP dalam sesi singkat, misalnya saat merapikan kartu atau mengecek kartu apa yang masih kurang.

**Masalah:** koleksi terdiri dari banyak kartu yang tampak mirip (member, album, dan versi berbeda), sehingga sulit mengingat mana yang sudah dimiliki dan di halaman binder mana kartu itu disimpan.

**Solusi:** satu layar koleksi dengan pencarian, filter member, filter status, dan header progres "berapa kartu bias yang sudah terkumpul", ditambah form untuk menambah kartu baru.

## Fitur

- **Header progres bias**: jumlah kartu dimiliki dari total kartu untuk member terpilih, ditampilkan dengan `LinearProgressIndicator`.
- **Pencarian**: cari berdasarkan nama album atau member.
- **Filter member**: `ChoiceChip` yang bisa digulir horizontal, termasuk pilihan "Semua member".
- **Filter status**: Semua / Dimiliki / Wishlist.
- **Grid koleksi**: tile photocard dengan status (dimiliki atau wishlist), nama member, dan album.
- **Tambah kartu**: bottom sheet dengan pilihan member, nama album, dan status; sheet naik mengikuti keyboard.
- **Loading state**: indikator saat data dimuat (disimulasikan 1 detik).
- **Empty state**: pesan berbeda untuk koleksi kosong dan untuk pencarian/filter tanpa hasil.
- **Penanganan teks panjang**: teks dipotong dengan `maxLines` dan `TextOverflow.ellipsis`.
- **Skenario uji data**: data sample bisa diganti lewat `--dart-define` (kosong, 500 item, nama 200 karakter).

## Struktur Proyek

```
lib/
├── main.dart                 # entry point
├── app.dart                  # MaterialApp + HomeScreen
├── constraints_demo.dart     # demo error constraint (Week 4)
├── models/
│   └── photocard.dart        # PhotoCard, CardStatus
├── data/
│   └── sample_cards.dart     # data sample + skenario uji
├── theme/
│   └── app_theme.dart        # ThemeData light & dark
└── widgets/
    ├── add_card_sheet.dart
    ├── bias_progress_header.dart
    ├── empty_state.dart
    ├── member_filter_bar.dart
    ├── photo_card_grid.dart
    ├── photo_card_tile.dart
    └── status_filter_bar.dart
docs/
├── structure.md              # penjelasan arsitektur
├── week02/composition.md
├── week03/design.md          # pemilihan tema dan seed colour
├── week04/constraints.md     # diagnosis constraint
└── week05/reflection.md      # refleksi akhir
```

Penjelasan lengkap pemisahan kode ada di [`docs/structure.md`](docs/structure.md).

## Dokumentasi Tambahan

- [Arsitektur dan struktur direktori](docs/structure.md)
- [Tema dan seed colour (Week 3)](docs/week03/design.md)
- [Diagnosis constraint (Week 4)](docs/week04/constraints.md)
- [Refleksi Minggu 5](docs/week05/reflection.md)

## Setup dan Menjalankan

### Prasyarat

- Flutter SDK (channel stable) dengan Dart `^3.13.3`
- Android Studio atau VS Code dengan ekstensi Flutter
- Emulator atau perangkat Android dengan USB debugging aktif

### Langkah

```bash
git clone <url-repository>
cd tugas_app
flutter pub get
flutter run
```

### Skenario data uji

Data awal dipilih lewat `--dart-define=SCENARIO=...`:

```bash
flutter run --dart-define=SCENARIO=empty      # koleksi kosong
flutter run --dart-define=SCENARIO=long       # 500 kartu
flutter run --dart-define=SCENARIO=longtext   # nama member/album 200 karakter
```

### Demo constraint (Week 4)

```bash
flutter run -t lib/constraints_demo.dart
```

Pilih kasus (Row, Column, List), biarkan **Show fix** mati untuk melihat error, lalu nyalakan untuk melihat perbaikannya.

### Analisis kode

```bash
flutter analyze
```

### Build Release APK

```bash
flutter build apk --release
```

Hasil: `build/app/outputs/flutter-apk/app-release.apk`

## Release APK

Unduh APK rilis di halaman **Releases** repository ini: _tambahkan tautan tag release di sini_

APK diuji pada perangkat bersih (tanpa debugging): _isi nama perangkat dan versi Android_

## Keputusan Desain

- **Material 3** dengan `ColorScheme.fromSeed`, sehingga seluruh palet diturunkan dari satu seed colour violet.
- Status kartu dibedakan lewat ikon dan colour role, bukan warna manual.
- Layout menggunakan `Expanded`, `ConstrainedBox`, dan `ellipsis` agar tidak terjadi overflow (lihat `docs/week04/constraints.md`).

## Catatan Pengembangan

- State aplikasi saat ini hanya tersimpan di memori (`_HomeScreenState`), sehingga kartu yang ditambahkan hilang saat aplikasi ditutup. Detail dan rencana pemindahan state ada di [`docs/week05/reflection.md`](docs/week05/reflection.md).
- Riwayat commit mencakup lima minggu pengerjaan modul.