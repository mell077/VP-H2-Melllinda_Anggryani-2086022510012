# Composition Rationale: Case Study App

Dokumen ini menjelaskan widget yang kuekstrak dari layar utama, beserta alasan,
state yang dimiliki, dan data yang dilaporkan ke atas.

## Daftar widget

| Widget | Trigger ekstraksi | Owns (state) | Reports upward |
|---|---|---|---|
| `StatusFilterBar` | Reuse: dipakai untuk memfilter status kartu (Semua / Dimiliki / Wishlist) | Tidak ada, stateless. Nilai `selected` diterima dari parent | `onSelected(CardStatus?)` saat pengguna memilih opsi |
| `SearchField` | Reuse: input pencarian terpisah dari layar | Isi teks dan `FocusNode` (jika ada) | `onChanged(String)` saat teks berubah |
| `PhotoCardTile` | Readability: satu kartu foto dipisah dari grid agar build lebih mudah dibaca | Tidak ada, stateless | `onTap()` saat kartu ditekan |
| `PhotoCardGrid` | Readability: logika grid (jumlah kolom, `itemBuilder`) dipisah dari layar | Tidak ada, stateless | `onItemTap(PhotoCard)` |
| `MemberFilterBar` | Reuse: filter anggota/bias dengan pola yang sama seperti status filter | Tidak ada, stateless | `onSelected(String?)` |
| `BiasProgressHeader` | Readability: header progres koleksi dipisah agar layar utama ringkas | Tidak ada, stateless | Tidak ada |
| `EmptyState` | Reuse: dipakai saat daftar kosong atau hasil pencarian tidak ditemukan | Tidak ada, stateless | `onAction()` (jika ada tombol) |

## Catatan

Widget yang stateless menerima data dari parent dan tidak menyimpan state sendiri, sehingga state utama tetap berada di layar.