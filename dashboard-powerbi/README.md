# Portofolio Power BI - Dashboard Manajemen Inventaris

## Gambaran Umum
Repositori ini menampilkan dashboard Power BI yang dirancang untuk menganalisis data inventaris bisnis. Dashboard ini memberikan wawasan tentang jumlah stok, nilai inventaris, dan tren berdasarkan kategori produk, lokasi gudang, dan status stok. Proyek ini menunjukkan kemampuan dalam visualisasi data, pembuatan dashboard interaktif, dan analisis data menggunakan Power BI.

## Dataset
Dataset berisi 1.500 entri dengan kolom berikut:
- `product_id`: ID unik untuk setiap produk.
- `product_name`: Nama produk.
- `category`: Kategori produk.
- `stock_quantity`: Jumlah stok barang.
- `warehouse_location`: Lokasi gudang penyimpanan.
- `stock_status`: Status stok (misalnya, Tersedia, Habis).
- `inventory_value`: Nilai moneter inventaris.
- `date_updated`: Tanggal pembaruan terakhir inventaris.

## Pertanyaan Bisnis yang Dijawab
Dashboard ini menjawab enam pertanyaan bisnis berikut melalui visualisasi interaktif:

1. **Kategori produk mana yang memiliki stok terbanyak?**
   - **Visualisasi**: Clustered Bar Chart
   - **Detail**: Menampilkan total jumlah stok per kategori, dengan filter interaktif berdasarkan lokasi gudang.
   - **Manfaat**: Mengidentifikasi kategori yang kelebihan stok untuk perencanaan strategi penjualan.

2. **Bagaimana distribusi nilai inventaris berdasarkan status stok?**
   - **Visualisasi**: Pie Chart
   - **Detail**: Menunjukkan proporsi nilai inventaris berdasarkan status stok (misalnya, Tersedia, Habis), dengan filter kategori.
   - **Manfaat**: Mengungkap nilai inventaris yang terkunci di stok tidak tersedia.

3. **Bagaimana tren nilai inventaris dari waktu ke waktu?**
   - **Visualisasi**: Line Chart
   - **Detail**: Melacak nilai inventaris dari waktu ke waktu, dengan opsi breakdown per kategori dan filter lokasi gudang.
   - **Manfaat**: Menunjukkan apakah nilai inventaris meningkat atau menurun.

4. **Lokasi gudang mana yang menyimpan stok terbanyak?**
   - **Visualisasi**: Clustered Column Chart
   - **Detail**: Menampilkan jumlah stok berdasarkan lokasi gudang, dengan filter kategori.
   - **Manfaat**: Mengidentifikasi gudang dengan stok tinggi atau rendah.

5. **Produk mana yang memiliki nilai inventaris tertinggi?**
   - **Visualisasi**: Table/Matrix
   - **Detail**: Daftar produk diurutkan berdasarkan nilai inventaris, dengan filter kategori dan status stok.
   - **Manfaat**: Menyoroti produk bernilai tinggi untuk fokus manajemen inventaris.

6. **Bagaimana distribusi stok berdasarkan kategori dan status stok?**
   - **Visualisasi**: Stacked Bar Chart
   - **Detail**: Menampilkan jumlah stok per kategori, dipisahkan berdasarkan status stok, dengan filter lokasi gudang.
   - **Manfaat**: Menunjukkan pola ketersediaan stok di setiap kategori.

## Visualisasi
Berikut adalah pratinjau dashboard:

![Pratinjau Dashboard](powerbi-portofolio.jpg)

Untuk tampilan statis, unduh versi PDF: [powerbi-portofolio.pdf](powerbi-portofolio.pdf)

## File dalam Repositori
- `Inventory_Dashboard.pbix`: File Power BI dengan dashboard lengkap dan data.
- `Inventory_Dashboard.pbit`: File template Power BI (tanpa data, untuk berbagi).
- `Inventory_Dashboard.pdf`: Ekspor PDF statis dari dashboard.
- `dashboard_screenshot.png`: Screenshot dashboard untuk pratinjau cepat.

## Cara Menggunakan
1. **Unduh File**:
   - Clone repositori ini atau unduh `Inventory_Dashboard.pbix` atau `Inventory_Dashboard.pbit`.
2. **Buka di Power BI Desktop**:
   - Gunakan Power BI Desktop untuk membuka file `.pbix` untuk pengalaman interaktif penuh atau `.pbit` untuk menjelajahi template.
3. **Interaksi dengan Dashboard**:
   - Gunakan slicer untuk memfilter berdasarkan `category`, `warehouse_location`, atau `stock_status`.
   - Arahkan kursor ke visual untuk tooltip atau drill-down untuk detail lebih lanjut.
4. **Lihat Versi Statis**:
   - Buka `Inventory_Dashboard.pdf` untuk gambaran non-interaktif.

## Alat yang Digunakan
- **Power BI Desktop**: Untuk membuat dan mendesain dashboard.
- **Dataset**: Data inventaris simulasi (1.500 entri).
- **Visualisasi**: Clustered Bar Chart, Pie Chart, Line Chart, Clustered Column Chart, Table/Matrix, Stacked Bar Chart.