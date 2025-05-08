# Analisis Performa Penjualan xyz.com: Laporan Townhall Q1-Q2 2004

## Sekilas tentang Proyek
Selamat datang di proyek analisis data saya untuk xyz.com, sebuah perusahaan rintisan B2B yang fokus menjual produk ke bisnis lain. Sebagai data analyst, saya ditugaskan untuk menyiapkan laporan performa perusahaan selama kuartal pertama dan kedua tahun 2004. Laporan ini disusun untuk dipresentasikan dalam townhall triwulanan, di mana semua divisi berkumpul untuk mengevaluasi kinerja dan merumuskan strategi ke depan. Dengan pendekatan berbasis data, saya menggali informasi dari database untuk menjawab pertanyaan kunci tentang penjualan, pelanggan, kategori produk, dan retensi pelanggan.

Proyek ini adalah bagian dari portofolio saya untuk menunjukkan kemampuan analisis data menggunakan SQL, sekaligus memberikan wawasan bisnis yang actionable. Saya berusaha membuat laporan ini tidak hanya informatif, tetapi juga menarik dan mudah dipahami, seperti cerita yang mengalir dari data. Mari kita jelajahi apa yang saya temukan!

## Apa yang Ingin Dicapai?
Laporan ini bertujuan untuk menjawab lima pertanyaan utama yang relevan bagi strategi bisnis xyz.com:
1. **Bagaimana pertumbuhan penjualan saat ini?** Apakah penjualan dan pendapatan meningkat atau menurun antara Q1 dan Q2 2004?
2. **Apakah jumlah pelanggan bertambah?** Berapa banyak pelanggan baru yang mendaftar setiap kuartal?
3. **Seberapa banyak pelanggan yang bertransaksi?** Dari pelanggan yang mendaftar, berapa persen yang benar-benar membeli?
4. **Kategori produk apa yang paling laku?** Produk mana yang paling diminati di Q2 2004?
5. **Seberapa banyak pelanggan yang tetap aktif?** Berapa tingkat retensi pelanggan dari Q1 ke Q2?

## Data yang Digunakan
Analisis ini menggunakan tiga tabel dari database xyz.com:
- **orders_1**: Data transaksi penjualan untuk Q1 2004 (Januari–Maret).
- **orders_2**: Data transaksi penjualan untuk Q2 2004 (April–Juni).
- **customer**: Profil pelanggan yang mendaftar di xyz.com, termasuk tanggal pendaftaran.

Setiap tabel menyediakan informasi penting seperti jumlah pesanan, harga, status pengiriman, ID pelanggan, dan kode produk. Saya memastikan hanya data dengan status "Shipped" yang dianalisis untuk mencerminkan penjualan yang benar-benar terealisasi.

## Langkah Analisis
Saya menggunakan SQL untuk mengolah data dengan pendekatan yang terstruktur. Berikut adalah langkah-langkah yang saya lakukan:
1. **Eksplorasi Data**: Memahami isi tabel dengan `SELECT * FROM` dan `LIMIT` untuk melihat struktur dan contoh data.
2. **Pemfilteran**: Menggunakan klausa `WHERE` untuk memilih hanya pesanan dengan status "Shipped".
3. **Agregasi**: Menggunakan `GROUP BY` dan fungsi seperti `SUM()` serta `COUNT()` untuk menghitung total penjualan, pendapatan, dan jumlah pelanggan.
4. **Penggabungan Data**: Menggunakan `UNION` untuk menggabungkan data Q1 dan Q2 agar bisa dibandingkan.
5. **Manipulasi Tanggal**: Menggunakan fungsi seperti `QUARTER()` untuk mengelompokkan data berdasarkan kuartal.
6. **Subquery**: Membuat tabel sementara untuk menyederhanakan analisis kompleks, seperti menghitung pelanggan yang bertransaksi.
7. **Pengurutan**: Menggunakan `ORDER BY` untuk menyusun hasil, misalnya kategori produk berdasarkan jumlah pesanan.

Berikut adalah cuplikan beberapa query yang saya gunakan:

### 1. Total Penjualan dan Pendapatan per Kuartal
```sql
-- Q1 2004
SELECT
    SUM(quantity) AS total_penjualan,
    SUM(quantity * priceEach) AS revenue
FROM orders_1
WHERE status = 'Shipped';

-- Q2 2004
SELECT
    SUM(quantity) AS total_penjualan,
    SUM(quantity * priceEach) AS revenue
FROM orders_2
WHERE status = 'Shipped';
```

### 2. Persentase Penjualan Keseluruhan
```sql
SELECT quarter, SUM(quantity) AS total_penjualan, SUM(priceEach * quantity) AS revenue
FROM (
    SELECT orderNumber, status, quantity, priceEach, '1' AS quarter FROM orders_1
    UNION
    SELECT orderNumber, status, quantity, priceEach, '2' AS quarter FROM orders_2
) AS tabel_a
WHERE status = 'Shipped'
GROUP BY quarter;
```

### 3. Jumlah Pelanggan Baru
```sql
SELECT quarter, COUNT(DISTINCT customerID) AS total_customers
FROM (
    SELECT customerID, createDate, QUARTER(createDate) AS quarter
    FROM customer
    WHERE createDate BETWEEN '2004-01-01' AND '2004-07-01'
) AS tabel_b
GROUP BY quarter;
```

### 4. Kategori Produk Terpopuler di Q2
```sql
SELECT categoryID, COUNT(DISTINCT orderNumber) AS total_order, SUM(quantity) AS total_penjualan
FROM (
    SELECT productCode, orderNumber, quantity, status, LEFT(productCode, 3) AS categoryID
    FROM orders_2
    WHERE status = 'Shipped'
) tabel_c
GROUP BY categoryID
ORDER BY total_order DESC;
```

### 5. Retensi Pelanggan
```sql
SELECT 1 AS quarter, (COUNT(DISTINCT customerID) * 100) / 25 AS Q2
FROM orders_1
WHERE customerID IN (SELECT DISTINCT customerID FROM orders_2);
```

## Temuan Utama
Setelah mengolah data, berikut adalah hasil analisis yang saya rangkum:

1. **Penurunan Performa Penjualan**:
   - Penjualan di Q2 2004 turun 20% dan pendapatan turun 24% dibandingkan Q1. Ini menunjukkan adanya tantangan dalam mempertahankan momentum penjualan.

2. **Pertumbuhan Pelanggan Baru Melambat**:
   - Jumlah pelanggan baru sedikit menurun di Q2 dibandingkan Q1. Ini bisa jadi sinyal bahwa strategi akuisisi pelanggan perlu diperkuat.

3. **Konversi Pelanggan Rendah**:
   - Hanya 56% pelanggan baru yang mendaftar di Q1 dan Q2 benar-benar melakukan transaksi. Artinya, banyak pelanggan yang mendaftar tetapi tidak membeli, menunjukkan potensi masalah pada pengalaman pengguna atau daya tarik produk.

4. **Kategori Produk Unggulan**:
   - Kategori produk dengan kode **S18** dan **S24** mendominasi, menyumbang 50% dari total pesanan dan 60% dari total penjualan di Q2. Ini adalah kategori yang sangat strategis untuk bisnis.

5. **Retensi Pelanggan Sangat Rendah**:
   - Hanya 24% pelanggan dari Q1 yang kembali bertransaksi di Q2. Tingkat retensi yang rendah ini mengindikasikan bahwa pelanggan tidak cukup puas atau tidak terdorong untuk repeat order.

## Wawasan Menarik untuk Bisnis
Selain temuan di atas, saya menemukan beberapa wawasan yang bisa menjadi game-changer bagi xyz.com:
- **Pola Musiman?** Penurunan penjualan di Q2 mungkin terkait dengan musim tertentu (misalnya, libur atau siklus pembelian B2B yang melambat). Saya merekomendasikan analisis lebih lanjut untuk memetakan pola musiman dan menyesuaikan strategi pemasaran.
- **Fokus pada Kategori Unggulan**: Kategori S18 dan S24 adalah "bintang" xyz.com. Perusahaan bisa mengembangkan variasi produk baru dalam kategori ini atau menawarkan bundling untuk meningkatkan penjualan.
- **Masalah Retensi**: Retensi 24% adalah peringatan besar. Saya menduga ada masalah pada kepuasan pelanggan, seperti kualitas produk, pengiriman, atau layanan purna jual. Survei pelanggan atau analisis umpan balik bisa membantu mengidentifikasi akar masalah.
- **Optimalisasi Konversi**: Konversi 56% menunjukkan bahwa proses dari pendaftaran ke pembelian perlu disederhanakan. Mungkin ada hambatan di platform, seperti UI yang rumit atau kurangnya promosi untuk pelanggan baru.