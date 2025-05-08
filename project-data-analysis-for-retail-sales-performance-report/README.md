# Medium Artikel
[Analisis Penjualan dan Efektivitas Promosi di DQLab Store](https://medium.com/@ahmadattoriq19/project-data-analysis-for-retail-sales-performance-report-2fa52394ef1e)

# Analisis Penjualan dan Efektivitas Promosi di DQLab Store

## Deskripsi Proyek
Proyek ini bertujuan untuk menganalisis kinerja penjualan dan promosi di DQLab Store dari tahun 2009 hingga 2012. Analisis ini meliputi total penjualan, jumlah pesanan, efektivitas dan efisiensi promosi, serta transaksi pelanggan per tahun. Data yang digunakan berasal dari tabel `dqlab_sales_store`, yang mencakup informasi tentang tanggal pesanan, status pesanan, kategori produk, dan nilai promosi.

## Tujuan
1. Menyajikan total penjualan dan jumlah pesanan berdasarkan tahun.
2. Menganalisis total penjualan berdasarkan subkategori produk dari tahun 2011 hingga 2012.
3. Menghitung persentase burn rate untuk menilai efektivitas dan efisiensi promosi.
4. Menganalisis jumlah pelanggan yang bertransaksi setiap tahun.

## Struktur Analisis

### 1. **Total Penjualan dan Jumlah Pesanan per Tahun**
Menggunakan SQL untuk menghitung total penjualan dan jumlah pesanan per tahun dari tahun 2009 hingga 2012, hanya untuk pesanan yang sudah selesai (`order_status = 'Order Finished'`).

```sql
SELECT
    EXTRACT(YEAR FROM order_date) AS years,
    SUM(sales) AS sales,
    COUNT(order_status) AS number_of_order
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY years
ORDER BY years ASC;
```

**Hasil:**
Tabel berikut menunjukkan total penjualan dan jumlah pesanan per tahun:

| Tahun | Penjualan (Sales) | Jumlah Pesanan (Orders) |
|-------|-------------------|-------------------------|
| 2009  | 4,613,872,681     | 1,244                   |
| 2010  | 4,059,100,607     | 1,248                   |
| 2011  | 4,112,036,186     | 1,178                   |
| 2012  | 4,482,983,158     | 1,254                   |

### 2. **Total Penjualan Berdasarkan Subkategori Produk (2011-2012)**
Menganalisis total penjualan berdasarkan subkategori produk dari tahun 2011 hingga 2012.

```sql
SELECT
    EXTRACT(YEAR FROM order_date) AS years,
    product_sub_category,
    SUM(sales) AS sales
FROM dqlab_sales_store
WHERE order_status = 'Order Finished' AND EXTRACT(YEAR FROM order_date) BETWEEN 2011 AND 2012
GROUP BY years, product_sub_category
ORDER BY years, sales DESC;
```

**Hasil:**
Daftar produk dengan penjualan tertinggi pada tahun 2011 dan 2012.

### 3. **Efektivitas dan Efisiensi Promosi Berdasarkan Tahun (Burn Rate)**
Menghitung persentase burn rate untuk menilai efektivitas promosi yang dilakukan dengan membandingkan total diskon yang dikeluarkan terhadap total penjualan yang diperoleh.

```sql
SELECT
    EXTRACT(YEAR FROM order_date) AS years,
    SUM(sales) AS sales,
    SUM(discount_value) AS promotion_value,
    ROUND((SUM(discount_value) / NULLIF(SUM(sales), 0)) * 100, 2) AS burn_rate_percentage
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY years
ORDER BY years ASC;
```

**Hasil:**
Tabel berikut menunjukkan burn rate untuk tahun 2009 hingga 2012:

| Tahun | Penjualan (Sales) | Nilai Promosi (Promotion Value) | Burn Rate (%) |
|-------|-------------------|---------------------------------|---------------|
| 2009  | 4,613,872,681     | 214,330,327                     | 4.65          |
| 2010  | 4,059,100,607     | 197,506,939                     | 4.87          |
| 2011  | 4,112,036,186     | 214,611,556                     | 5.22          |
| 2012  | 4,482,983,158     | 225,867,642                     | 5.04          |

### 4. **Efektivitas dan Efisiensi Promosi Berdasarkan Subkategori Produk (2012)**
Menganalisis efektivitas dan efisiensi promosi per subkategori produk pada tahun 2012.

```sql
SELECT
    EXTRACT(YEAR FROM order_date) AS years,
    product_sub_category,
    product_category,
    SUM(sales) AS sales,
    SUM(discount_value) AS promotion_value,
    ROUND((SUM(discount_value) / SUM(sales)) * 100, 2) AS burn_rate_percentage
FROM dqlab_sales_store
WHERE order_status = 'Order Finished' AND EXTRACT(YEAR FROM order_date) = 2012
GROUP BY years, product_sub_category, product_category
ORDER BY sales DESC;
```

**Hasil:**
Tabel berikut menunjukkan burn rate per subkategori produk pada tahun 2012:

| Tahun | Subkategori Produk            | Kategori Produk   | Penjualan (Sales) | Nilai Promosi (Promotion Value) | Burn Rate (%) |
|-------|-------------------------------|-------------------|-------------------|---------------------------------|---------------|
| 2012  | Office Machines               | Technology        | 811,427,140       | 46,616,695                      | 5.75          |
| 2012  | Chairs & Chairmats            | Furniture         | 654,168,740       | 26,623,882                      | 4.07          |
| 2012  | Telephones and Communication  | Technology        | 422,287,514       | 18,800,188                      | 4.45          |
| 2012  | Tables                        | Furniture         | 388,993,784       | 16,348,689                      | 4.20          |
| 2012  | Binders and Binder Accessories| Office Supplies   | 363,879,200       | 22,338,980                      | 6.14          |

### 5. **Jumlah Pelanggan yang Bertransaksi per Tahun**
Menghitung jumlah pelanggan yang bertransaksi setiap tahun dari 2009 hingga 2012.

```sql
SELECT
    EXTRACT(YEAR FROM order_date) AS years,
    COUNT(DISTINCT customer) AS number_of_customer
FROM dqlab_sales_store
WHERE order_status = 'Order Finished'
GROUP BY years
ORDER BY years;
```

**Hasil:**
Tabel berikut menunjukkan jumlah pelanggan yang bertransaksi per tahun:

| Tahun | Jumlah Pelanggan (Customer) |
|-------|-----------------------------|
| 2009  | 585                         |
| 2010  | 593                         |
| 2011  | 581                         |
| 2012  | 594                         |

## Rekomendasi
Berdasarkan analisis di atas, berikut beberapa rekomendasi untuk meningkatkan kinerja DQLab Store:

1. **Efisiensi Promosi**: Burn rate pada tahun 2011 dan 2012 lebih tinggi dibandingkan tahun 2009 dan 2010. DQLab perlu mengevaluasi kembali promosi yang dijalankan, dengan fokus pada pengurangan burn rate agar tetap berada di bawah 4.5%.
2. **Strategi Penjualan Produk**: Fokuskan strategi pemasaran pada produk dengan penjualan tertinggi di setiap tahun. Misalnya, pada tahun 2012, produk "Office Machines" dan "Chairs & Chairmats" memiliki penjualan yang signifikan.
3. **Segmentasi Pelanggan**: Meskipun jumlah pelanggan cenderung stabil, DQLab perlu mengeksplorasi cara untuk meningkatkan loyalitas pelanggan dan menarik lebih banyak pelanggan pada tahun-tahun yang lebih rendah, seperti 2011.
4. **Evaluasi Promosi Per Subkategori**: Beberapa subkategori produk seperti "Binders and Binder Accessories" menunjukkan burn rate yang sangat tinggi. Evaluasi perlu dilakukan untuk memastikan efisiensi penggunaan anggaran promosi di setiap subkategori.

Dengan penerapan rekomendasi ini, DQLab dapat meningkatkan profitabilitas dan mengoptimalkan penggunaan anggaran promosi.
