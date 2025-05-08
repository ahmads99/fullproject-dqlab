# Proyek Mini SQL: Analisis Data Pelanggan dengan DQLab

Selamat datang di proyek mini SQL saya! dalam proyek ini, saya akan membagikan hasil belajar saya tentang SQL melalui platform DQLab. Fokus proyek ini adalah modul **Fundamental SQL: GROUP BY dan HAVING**, yang mencakup dua analisis data pelanggan, yaitu:

1. **Menghitung Total Nilai Denda Pelanggan**
2. **Mencari Pelanggan yang Mengganti Layanan**

Berikut adalah penjelasan singkat tentang masing-masing bagian proyek ini.

---

## 1. Menghitung Total Nilai Denda Pelanggan

Dalam layanan tertentu, beberapa pelanggan dikenakan denda karena keterlambatan pembayaran. Tujuan dari analisis ini adalah untuk menemukan pelanggan yang memiliki total denda lebih dari Rp20.000 berdasarkan data di tabel `invoice`.

### Query SQL
```sql
SELECT customer_id, SUM(pinalty) AS total_denda
FROM invoice
GROUP BY customer_id
HAVING SUM(pinalty) > 20000;
```

### Penjelasan
- **SELECT**: Mengambil `customer_id` dan menghitung total denda dengan fungsi `SUM(pinalty)`.
- **GROUP BY**: Mengelompokkan hasil berdasarkan `customer_id`.
- **HAVING**: Memfilter pelanggan yang memiliki total denda lebih dari Rp20.000.

### Hasil
Query ini akan menghasilkan daftar `customer_id` beserta total denda yang dibayarkan oleh pelanggan yang memenuhi kriteria.

---

## 2. Mencari Pelanggan yang Mengganti Layanan

Dalam layanan jaringan internet, pelanggan sering kali mengganti paket langganan mereka. Analisis ini bertujuan untuk menemukan pelanggan yang telah berlangganan lebih dari satu paket layanan.

Tabel yang digunakan:
- `customer`: Berisi informasi pelanggan.
- `subscription`: Berisi data langganan pelanggan.
- `product`: Berisi informasi produk/layanan.

### Query SQL
```sql
SELECT t1.name, GROUP_CONCAT(t3.product_name) AS product_name
FROM customer t1
JOIN subscription t2 ON t1.id = t2.customer_id 
JOIN product t3 ON t2.product_id = t3.id 
WHERE t1.id IN (
    SELECT customer_id
    FROM subscription
    GROUP BY customer_id
    HAVING COUNT(customer_id) > 1
)
GROUP BY t1.name;
```

### Penjelasan
- **Subquery**: Memfilter `customer_id` yang memiliki lebih dari satu langganan di tabel `subscription` menggunakan `GROUP BY` dan `HAVING`.
- **JOIN**: Menggabungkan tabel `customer`, `subscription`, dan `product` untuk mendapatkan nama pelanggan dan nama produk.
- **GROUP_CONCAT**: Menggabungkan semua nama produk yang terkait dengan pelanggan tertentu menjadi satu string.
- **GROUP BY**: Mengelompokkan hasil berdasarkan nama pelanggan.

### Hasil
Query ini akan menampilkan nama pelanggan dan daftar produk/layanan yang mereka gunakan, dipisahkan oleh koma.

---

## Tentang Proyek Ini
Proyek ini adalah bagian dari perjalanan belajar saya di DQLab untuk memahami konsep dasar SQL, khususnya penggunaan `GROUP BY` dan `HAVING`. Dengan proyek ini, saya belajar cara mengelompokkan data, memfilter hasil, dan menggabungkan tabel untuk menghasilkan informasi yang bermakna.