# Refleksi Minggu 5

## 1. Keputusan struktural dari Minggu 1 yang paling membantu sampai Minggu 5

Keputusan yang paling membantu adalah memisahkan kode berdasarkan fungsinya: model di `lib/models/`, data sample di `lib/data/`, widget yang bisa dipakai ulang di `lib/widgets/`, dan tema di `lib/theme/`. Saat Minggu 3 saya harus mengganti warna dan gaya di seluruh aplikasi, saya cukup mengubah `AppTheme` tanpa menyentuh setiap layar. Saat Minggu 4 saya perlu menguji beberapa skenario data (kosong, 500 item, nama 200 karakter), saya cukup mengganti satu fungsi `initialCards()` di `lib/data/sample_cards.dart`, dan layar tidak perlu diubah. Pemisahan ini membuat setiap perubahan berdampak pada satu tempat saja.

## 2. Bagian yang paling memakan waktu dan apa yang akan saya ubah

Bagian yang paling memakan waktu adalah Git dan penyelesaian error setelah merge. Saya menambal beberapa file sekaligus tanpa menjalankan `flutter analyze` di antaranya, sehingga satu error kecil berubah menjadi puluhan error. Saya juga belum memahami bahwa GitHub bisa berisi commit yang belum ada di laptop, sehingga push ditolak dan saya salah mengira kode tidak tersimpan.

Kalau mengerjakan ulang, saya akan melakukan tiga hal. Pertama, commit setiap selesai satu langkah kecil, bukan menumpuk pekerjaan. Kedua, jalankan `git pull` sebelum mulai kerja di hari yang baru. Ketiga, mengganti nama class dan model sejak awal menjadi satu versi (`PhotoCard`), sehingga tidak perlu banyak perbaikan nama di akhir.

## 3. Kondisi state aplikasi saat ini dan apa yang sulit dipindah di Modul 2

Saat ini state aplikasi hanya tersimpan di memori. Daftar kartu berasal dari `initialCards()`, lalu disimpan di `_HomeScreenState` di `app.dart`. Filter (member, status, pencarian) juga disimpan di state layar yang sama. Akibatnya, kartu yang ditambahkan akan hilang saat aplikasi ditutup, dan tidak ada cara bagi layar lain untuk membaca data itu tanpa melewatkannya lewat parameter.

Hal yang akan sulit dipindahkan di Modul 2 adalah state tersebut tersebar di satu `State` besar. Kalau nanti data harus disimpan ke database atau dibagikan ke beberapa layar, saya harus memindahkan `_cards` dan filter keluar dari layar, lalu mengubah setiap widget yang memakainya. Bagian ini yang paling berisiko, jadi saya akan memikirkan cara menaruh state di luar widget sebelum menambah fitur baru.