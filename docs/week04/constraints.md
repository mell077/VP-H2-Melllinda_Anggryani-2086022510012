# Constraint Diagnosis

Tiga error ini dibuat dengan sengaja di `lib/constraints_demo.dart`
(`flutter run -t lib/constraints_demo.dart`). Pilih kasusnya, biarkan **Show fix**
mati untuk memunculkan error, lalu nyalakan untuk melihat perbaikannya.

Angka pixel di pesan error bisa berbeda di perangkatmu.

Aturan dasar layout Flutter yang dipakai di bawah:
**constraints turun, ukuran naik, parent menentukan posisi.**

---

## 1. Teks panjang di dalam `Row`

**Error di konsol:** `A RenderFlex overflowed by ... pixels on the right.`

![Error 1](constraint-1-error.png)

**Aturan yang dilanggar:** `Row` tidak membatasi lebar anak yang bukan `Flexible`/`Expanded`, jadi `Text` 200 karakter meminta lebar alaminya (ribuan pixel) yang jauh melebihi lebar layar.

**Dalam app ini:** terjadi pada nama panjang di tile, chip filter, dan dropdown bias.

**Perbaikan:**

```dart
Row(
  children: [
    const Icon(Icons.favorite_border),
    const SizedBox(width: 8),
    Expanded(
      child: Text(name, maxLines: 1, overflow: TextOverflow.ellipsis),
    ),
  ],
)
```

![Fix 1](constraint-1-fix.png)

---

## 2. `Column` lebih tinggi dari parent yang tingginya tetap

**Error di konsol:** `A RenderFlex overflowed by ... pixels on the bottom.`

![Error 2](constraint-2-error.png)

**Aturan yang dilanggar:** `SizedBox(height: 120)` memberi `Column` constraint tinggi yang pas (tight), dan `Column` tidak bisa menggulir atau mengecilkan anaknya, jadi isi yang butuh sekitar 160 px meluap.

**Dalam app ini:** terjadi pada tile kartu kalau `mainAxisExtent` grid terlalu kecil untuk isi tile.

**Perbaikan:** ganti tinggi pasti dengan batas minimum, sehingga kotak boleh tumbuh mengikuti isinya.

```dart
// sebelum
SizedBox(height: 120, child: content)

// sesudah
ConstrainedBox(
  constraints: const BoxConstraints(minHeight: 120),
  child: content,
)
```

![Fix 2](constraint-2-fix.png)

---

## 3. `ListView` di dalam `Column`

**Error di konsol:** `Vertical viewport was given unbounded height.`

![Error 3](constraint-3-error.png)

**Aturan yang dilanggar:** `Column` memberi anak non-flex tinggi tak terbatas, sedangkan `ListView` butuh tinggi yang terbatas untuk tahu seberapa besar viewport-nya.

**Catatan:** ini error constraint tak terbatas (layar merah/abu-abu di debug), bukan garis kuning overflow seperti dua kasus sebelumnya, tetapi akar masalahnya sama: constraint yang diterima anak tidak cocok dengan yang ia butuhkan.

**Dalam app ini:** inilah alasan grid awal harus dibungkus `Expanded`, dan kenapa sekarang seluruh layar memakai `CustomScrollView`.

**Perbaikan:**

```dart
Column(
  children: [
    Text('Collection'),
    Expanded(child: ListView.builder(...)),
  ],
)
```

![Fix 3](constraint-3-fix.png)