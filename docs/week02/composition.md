# Justifikasi Komposisi: Photocard Vault (Minggu 02)

// Di mana state disimpan
State disimpan di `_CollectionScreenState`: daftar kartu (`_cards`) beserta status wishlist/owned-nya, teks pencarian (`_query`), filter member (`_member`), filter status (`_statusFilter`), dan bias yang dipilih (`_bias`). Semua widget hasil ekstraksi stateless. Mereka hanya menerima nilai dan callback dari layar.

## Widget yang diekstrak

### BiasProgressHeader
- Pemicu: keterbacaan. Dropdown bias dan bar progres adalah satu blok mandiri, dan kalau digabung ke layar membuat `build` terlalu panjang.
- Yang dimiliki: tidak ada. Bias, jumlah kartu yang dimiliki, dan total dikirim dari layar.
- Yang dilaporkan ke atas: bias yang dipilih lewat `onBiasChanged`, lalu layar memperbarui `_bias`.

### SearchField
- Pemicu: keterbacaan. Dekorasi input dan padding dipisah supaya layar tidak ramai.
- Yang dimiliki: tidak ada. Teks yang sedang diketik hanya disimpan `TextField` secara internal.
- Yang dilaporkan ke atas: teks pencarian lewat `onChanged`, lalu layar memperbarui `_query`.

### StatusFilterBar
- Pemicu: keterbacaan. Pengaturan `SegmentedButton` dengan tiga pilihan (All, Wishlist, Owned) cukup panjang untuk dipisah.
- Yang dimiliki: tidak ada. Pilihan yang aktif (`selected`) datang dari layar.
- Yang dilaporkan ke atas: filter status baru lewat `onChanged`, lalu layar memperbarui `_statusFilter`.

### MemberFilterBar
- Pemicu: keterbacaan. Pembuatan chip untuk tiap member dan logika toggle dikeluarkan dari layar.
- Yang dimiliki: tidak ada. Daftar member dan member terpilih datang dari layar.
- Yang dilaporkan ke atas: member yang dipilih (atau null jika dibatalkan) lewat `onSelected`, lalu layar memperbarui `_member`.

### PhotocardGrid
- Pemicu: keterbacaan. Pengaturan grid dan builder hanya urusan tata letak.
- Yang dimiliki: tidak ada. Kartu yang diterima sudah difilter dan diurutkan berdasarkan halaman binder.
- Yang dilaporkan ke atas: id kartu yang di-tap lewat `onToggle`, diteruskan dari tile.

### PhotocardTile
- Pemicu: penggunaan ulang. Widget ini dirender satu kali untuk setiap kartu, dan tampilannya hanya bergantung pada `card.isOwned`.
- Yang dimiliki: tidak ada.
- Yang dilaporkan ke atas: tap lewat `onToggle`, lalu layar mengubah kartu itu antara wishlist dan owned.

## Alasan state diangkat (hoisted) ke layar
- Header bias, grid, dan kedua filter bar membaca dari `_cards` dan nilai filter yang sama.
- Induk terdekat yang dimiliki bersama oleh widget-widget itu adalah `CollectionScreen`, sehingga state harus berada di sana.
- Saat sebuah tile di-tap, `_cards` berubah satu kali, lalu header, grid, dan bar progres ikut diperbarui dari satu sumber data yang sama.
- Widget yang stateless membuat sebagian besar constructor bisa memakai `const`, yang diperiksa oleh lint `prefer_const_constructors`.