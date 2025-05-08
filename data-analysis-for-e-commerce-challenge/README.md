# Dataset DQLab Store

Dataset ini berisi data transaksi e-commerce DQLab Store dimana pengguna bisa berperan sebagai pembeli maupun penjual.

## Daftar Tabel

### 1. Tabel `users`
Berisi data profil pengguna/platform.

| Kolom | Tipe Data | Deskripsi |
|-------|-----------|-----------|
| user_id | INTEGER | ID unik pengguna |
| nama_user | STRING | Nama lengkap pengguna |
| kodepos | INTEGER | Kode pos alamat utama pengguna |
| email | STRING | Alamat email pengguna |

### 2. Tabel `products`
Berisi data produk yang dijual di platform.

| Kolom | Tipe Data | Deskripsi |
|-------|-----------|-----------|
| product_id | INTEGER | ID unik produk |
| desc_product | STRING | Nama/deskripsi produk |
| category | STRING | Kategori produk |
| base_price | INTEGER | Harga dasar produk |

### 3. Tabel `orders`
Berisi data transaksi order/pembelian.

| Kolom | Tipe Data | Deskripsi |
|-------|-----------|-----------|
| order_id | INTEGER | ID unik transaksi |
| seller_id | INTEGER | ID penjual |
| buyer_id | INTEGER | ID pembeli |
| kodepos | INTEGER | Kode pos pengiriman |
| subtotal | INTEGER | Total sebelum diskon |
| discount | INTEGER | Besaran diskon |
| total | INTEGER | Total setelah diskon |
| created_at | DATETIME | Waktu pembuatan order |
| paid_at | DATETIME | Waktu pembayaran (nullable) |
| delivery_at | DATETIME | Waktu pengiriman (nullable) |

### 4. Tabel `order_details`
Berisi detail item produk dalam setiap transaksi.

| Kolom | Tipe Data | Deskripsi |
|-------|-----------|-----------|
| order_detail_id | INTEGER | ID unik detail order |
| order_id | INTEGER | ID transaksi terkait |
| product_id | INTEGER | ID produk yang dibeli |
| price | INTEGER | Harga satuan produk |
| quantity | INTEGER | Jumlah produk yang dibeli |

![image](https://github.com/user-attachments/assets/5666468e-5c47-4da2-82e4-0c67c2099a27)

![image](https://github.com/user-attachments/assets/272a58db-2f61-436d-93ae-e9710295ca21)

![image](https://github.com/user-attachments/assets/51174c4b-a404-4191-bc7f-dda3e0182877)

![image](https://github.com/user-attachments/assets/22b9f790-e1ff-43d2-abc1-b3a79d1258e6)

![image](https://github.com/user-attachments/assets/de164e29-c9ea-444b-8bea-4546cc73523f)

![image](https://github.com/user-attachments/assets/9deed59f-88c3-4d5a-87fe-24d97819492a)

![image](https://github.com/user-attachments/assets/3b2111df-62c1-433f-a503-56ae33362b87)

![image](https://github.com/user-attachments/assets/28006797-56b0-4ef8-8f8d-6d2e2e83284d)

![image](https://github.com/user-attachments/assets/8bcb9f74-25d7-4b19-ae80-f3706dff67e0)
