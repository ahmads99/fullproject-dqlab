--Memahami table

SELECT * FROM orders_1 LIMIT 5;
SELECT * FROM orders_2 LIMIT 5;
SELECT * FROM customer LIMIT 5; 

--Total Penjualan dan Revenue pada Quarter - 1(Jan, Feb, Mar) dan Quarter - 2(Apr, Mei, Jun)
--Dari tabel orders_1 lakukan penjumlahan pada kolom quantity dengan fungsi aggregate sum() dan beri nama“
total_penjualan”, kalikan kolom quantity dengan kolom priceEach kemudian jumlahkan hasil perkalian kedua kolom tersebut
dan beri nama“ revenue”
--Perusahaan hanya ingin menghitung penjualan dari produk yang terkirim saja, jadi kita perlu mem - filter kolom‘
status’ sehingga hanya menampilkan order dengan status“ Shipped”.
--Lakukan Langkah 1 & 2, untuk tabel orders_2.

--Quarter 1: Jan - Mar 2004
SELECT
SUM(quantity) AS total_penjualan,
SUM(quantity * priceeach) AS revenue
FROM orders_1
WHERE status = 'Shipped';

--Quarter 2: Apr - Jun 2004
SELECT
SUM(quantity) AS total_penjualan,
SUM(quantity * priceeach) AS revenue
FROM orders_2
WHERE status = 'Shipped';

--Menghitung persentasi keseluruhan penjualan
--Kedua tabel orders_1 dan orders_2 masih terpisah, untuk menghitung persentasi keseluruhan penjualan dari kedua tabel
tersebut perlu digabungkan:

SELECT quarter, SUM(quantity) AS total_penjualan, SUM(priceEach * quantity) as revenue
FROM(SELECT orderNumber, status, quantity, priceEach, '1'
as quarter FROM orders_1 UNION SELECT orderNumber, status, quantity, priceEach, '2'
as quarter FROM orders_2) AS tabel_a
WHERE status = 'Shipped'
GROUP BY quarter

--Apakah jumlah customers xyz.com semakin bertambah ?
SELECT quarter, COUNT(DISTINCT customerID) AS total_customers
FROM(SELECT customerID, createDate, quarter(createDate) AS quarter FROM customer WHERE createDate BETWEEN '2004-01-01'
AND '2004-07-01') as tabel_b
GROUP BY quarter

--Seberapa banyak customers tersebut yang sudah melakukan transaksi ?
SELECT quarter, COUNT(DISTINCT customerID) AS total_customers
FROM(SELECT customerID, createDate, quarter(createDate) AS quarter FROM customer WHERE createDate BETWEEN '2004-01-01'
AND '2004-07-01') AS tabel_b
WHERE customerID IN(SELECT DISTINCT customerID FROM orders_1 UNION SELECT DISTINCT customerID FROM orders_2)
GROUP BY quarter


--Category produk apa saja yang paling banyak di - order oleh customers di Quarter - 2 ?
--Untuk mengetahui kategori produk yang paling banyak dibeli, maka dapat dilakukan dengan menghitung total order dan
jumlah penjualan dari setiap kategori produk.

SELECT * FROM(SELECT categoryID, COUNT(DISTINCT orderNumber) AS total_order, SUM(quantity) AS total_penjualan
FROM(SELECT productCode, orderNumber, quantity, status, LEFT(productCode, 3) AS categoryID FROM orders_2 WHERE status =
"Shipped") tabel_c GROUP BY categoryID) a ORDER BY total_order DESC

--Seberapa banyak customers yang tetap aktif bertransaksi setelah transaksi pertamanya ?
--Mengetahui seberapa banyak customers yang tetap aktif menunjukkan apakah xyz.com tetap digemari oleh customers untuk
memesan kebutuhan bisnis mereka.Hal ini juga dapat menjadi dasar bagi tim product dan business untuk pengembangan
product dan business kedepannya.Adapun metrik yang digunakan disebut retention cohort.Untuk project ini, kita akan
menghitung retention dengan query SQL sederhana, sedangkan cara lain yaitu JOIN dan SELF JOIN akan dibahas dimateri
selanjutnya :

--Menghitung total unik customers yang transaksi di quarter_1

SELECT COUNT(DISTINCT customerID) as total_customers FROM orders_1;
--output = 25
SELECT 1 AS quarter, (COUNT(DISTINCT customerID) * 100) / 25 AS Q2 FROM orders_1 WHERE customerID IN(SELECT DISTINCT
customerID FROM orders_2);