# Justifikasi Komposisi: Photocard Vault (Minggu 02)

## Di mana state disimpan
`_CollectionScreenState` menyimpan semua state yang dibutuhkan oleh lebih dari satu widget:
`_cards` (beserta status wishlist/owned tiap kartu), `_query`, `_member`,
`_statusFilter`, dan `_bias`. Semua widget hasil ekstraksi bersifat stateless: mereka
hanya menerima nilai dan callback, dan tidak mengubah state apa pun sendiri.

## Widget yang diekstrak

| Widget | Pemicu | Yang dimiliki | Yang dilaporkan ke atas |
|---|---|---|---|
| `BiasProgressHeader` | Keterbacaan: dropdown bias dan bar progres adalah satu blok mandiri yang membuat `build` layar terlalu panjang | Tidak ada (bias, jumlah kartu yang dimiliki, dan total dikirim dari atas) | `onBiasChanged(String?)`: layar memperbarui `_bias` |
| `SearchField` | Keterbacaan: memisahkan dekorasi input dan padding | Tidak ada (`TextField` menyimpan teksnya sendiri secara internal) | `onChanged(String)`: layar memperbarui `_query` |
| `StatusFilterBar` | Keterbacaan: pengaturan `SegmentedButton` dengan tiga segmen membuat kode layar ramai | Tidak ada (`selected` berasal dari induk) | `onChanged(StatusFilter)`: layar memperbarui `_statusFilter` |
| `MemberFilterBar` | Keterbacaan: pembuatan chip dan logika toggle dipisah dari layar | Tidak ada | `onSelected(String?)`: layar memperbarui `_member` |
| `PhotocardGrid` | Keterbacaan: pengaturan grid dan builder hanya urusan tata letak | Tidak ada (menerima kartu yang sudah difilter dan diurutkan berdasarkan halaman binder) | `onToggle(String id)`, diteruskan dari tile |
| `PhotocardTile` | Penggunaan ulang: dirender satu kali untuk setiap kartu, tampilannya hanya bergantung pada `card.isOwned` | Tidak ada | `onToggle()`: layar mengubah kartu itu antara wishlist dan owned |

## Alasan state diangkat (hoisted) ke layar
- `BiasProgressHeader` (jumlah kartu bias), `PhotocardGrid` (kartu yang tampil), dan
  kedua filter bar membaca dari `_cards` dan nilai filter yang sama.
- Induk terdekat yang dimiliki bersama oleh widget-widget itu adalah `CollectionScreen`,
  sehingga di sanalah state harus berada. Saat sebuah tile di-tap, `_cards` berubah satu
  kali, lalu header, grid, dan bar progres ikut diperbarui dari satu sumber data yang sama.
- Widget yang stateless juga membuat sebagian besar constructor bisa memakai `const`,
  yang menjadi objek pemeriksaan lint `prefer_const_constructors`.