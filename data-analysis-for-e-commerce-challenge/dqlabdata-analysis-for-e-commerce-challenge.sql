SELECT 
    COUNT(*) AS jumlah_transaksi,
    COUNT(DISTINCT buyer_id) AS jumlah_pembeli
FROM 
    orders
WHERE 
    EXTRACT(YEAR FROM CAST(created_at AS TIMESTAMP)) = 2020;

SELECT 
    buyer_id,
    COUNT(DISTINCT EXTRACT(MONTH FROM CAST(created_at AS TIMESTAMP))) AS jumlah_bulan
FROM 
    orders
WHERE 
    EXTRACT(YEAR FROM CAST(created_at AS TIMESTAMP)) = 2020
GROUP BY 
    buyer_id
ORDER BY 
    jumlah_bulan DESC
LIMIT 10;

SELECT bfq.buyer_id, u.email, bfq.average, bfq.month_count
FROM (
    SELECT trx.buyer_id, trx.average, months.jumlah_order, months.month_count
    FROM (
        SELECT buyer_id, ROUND(AVG(total), 2) AS average
        FROM orders
        WHERE TO_CHAR(created_at::date, 'YYYY') = '2020'
        GROUP BY buyer_id
        HAVING AVG(total) > 1000000
        ORDER BY buyer_id
    ) trx
    JOIN (
        SELECT buyer_id,
               COUNT(order_id) AS jumlah_order,
               COUNT(DISTINCT TO_CHAR(created_at::date, 'Month')) AS month_count
        FROM orders
        WHERE TO_CHAR(created_at::date, 'YYYY') = '2020'
        GROUP BY buyer_id
        HAVING COUNT(DISTINCT TO_CHAR(created_at::date, 'Month')) >= 5
           AND COUNT(order_id) >= COUNT(DISTINCT TO_CHAR(created_at::date, 'Month'))
        ORDER BY buyer_id
    ) months ON trx.buyer_id = months.buyer_id
) bfq
JOIN users u ON bfq.buyer_id = u.user_id;

SELECT
    bfq.buyer_id,
    u.email,
    bfq.rata_rata,
    bfq.month_count
FROM (
    SELECT
        trx.buyer_id,
        trx.rata_rata,
        months.jumlah_order,
        months.month_count
    FROM (
        SELECT
            buyer_id,
            ROUND(AVG(total), 2) AS rata_rata
        FROM
            orders
        WHERE
            TO_CHAR(created_at::date, 'YYYY') = '2020'
        GROUP BY
            buyer_id
        HAVING
            ROUND(AVG(total), 2) > 1000000
        ORDER BY
            buyer_id
    ) AS trx
    JOIN (
        SELECT
            buyer_id,
            COUNT(order_id) AS jumlah_order,
            COUNT(DISTINCT TO_CHAR(created_at::date, 'MM')) AS month_count
        FROM
            orders
        WHERE
            TO_CHAR(created_at::date, 'YYYY') = '2020'
        GROUP BY
            buyer_id
        HAVING
            COUNT(DISTINCT TO_CHAR(created_at::date, 'MM')) >= 5
            AND COUNT(order_id) >= COUNT(DISTINCT TO_CHAR(created_at::date, 'MM'))
        ORDER BY
            buyer_id
    ) AS months
    ON trx.buyer_id = months.buyer_id
) AS bfq
JOIN
    users u ON bfq.buyer_id = u.user_id;

SELECT
    bfq.buyer_id,
    u.email,
    bfq.rata_rata,
    bfq.month_count
FROM (
    SELECT
        trx.buyer_id,
        trx.rata_rata,
        months.jumlah_order,
        months.month_count
    FROM (
        SELECT
            buyer_id,
            ROUND(AVG(total), 2) AS rata_rata
        FROM
            orders
        WHERE
            TO_CHAR(created_at::date, 'YYYY') = '2020'
        GROUP BY
            buyer_id
        HAVING
            ROUND(AVG(total), 2) > 1000000
        ORDER BY
            buyer_id
    ) AS trx
    JOIN (
        SELECT
            buyer_id,
            COUNT(order_id) AS jumlah_order,
            COUNT(DISTINCT TO_CHAR(created_at::date, 'MM')) AS month_count
        FROM
            orders
        WHERE
            TO_CHAR(created_at::date, 'YYYY') = '2020'
        GROUP BY
            buyer_id
        HAVING
            COUNT(DISTINCT TO_CHAR(created_at::date, 'MM')) >= 5
            AND COUNT(order_id) >= COUNT(DISTINCT TO_CHAR(created_at::date, 'MM'))
        ORDER BY
            buyer_id
    ) AS months
    ON trx.buyer_id = months.buyer_id
) AS bfq
JOIN
    users u ON bfq.buyer_id = u.user_id

SELECT
    bfq.buyer_id,
    u.email,
    bfq.rata_rata,
    bfq.month_count
FROM (
    SELECT
        trx.buyer_id,
        trx.rata_rata,
        months.jumlah_order,
        months.month_count
    FROM (
        SELECT
            buyer_id,
            ROUND(AVG(total), 2) AS rata_rata
        FROM
            orders
        WHERE
            TO_CHAR(created_at::date, 'YYYY') = '2020'
        GROUP BY
            buyer_id
        HAVING
            ROUND(AVG(total), 2) > 1000000
        ORDER BY
            buyer_id
    ) AS trx
    JOIN (
        SELECT
            buyer_id,
            COUNT(order_id) AS jumlah_order,
            COUNT(DISTINCT TO_CHAR(created_at::date, 'MM')) AS month_count
        FROM
            orders
        WHERE
            TO_CHAR(created_at::date, 'YYYY') = '2020'
        GROUP BY
            buyer_id
        HAVING
            COUNT(DISTINCT TO_CHAR(created_at::date, 'MM')) >= 5
            AND COUNT(order_id) >= COUNT(DISTINCT TO_CHAR(created_at::date, 'MM'))
        ORDER BY
            buyer_id
    ) AS months
    ON trx.buyer_id = months.buyer_id
) AS bfq
JOIN
    users u ON bfq.buyer_id = u.user_id
      
SELECT
    DISTINCT SUBSTRING(email FROM POSITION('@' IN email) + 1) AS domain_email,
    COUNT(user_id) AS jumlah_pengguna_seller
FROM
    users
WHERE
    user_id IN (
        SELECT seller_id FROM orders
    )
GROUP BY
    domain_email;

SELECT
    DISTINCT SUBSTRING(email FROM POSITION('@' IN email) + 1) AS domain_email,
    COUNT(user_id) AS jumlah_pengguna_seller
FROM
    users
WHERE
    user_id IN (
        SELECT seller_id FROM orders
    )
GROUP BY
    domain_email
    
SELECT
	sum(quantity) AS total_quantity,
	desc_product
FROM
	order_details od
JOIN
	products p
	ON od.product_id = p.product_id
JOIN
	orders o
	ON od.order_id = o.order_id
WHERE
	created_at BETWEEN '2019-12-01' AND '2019-12-31'
GROUP BY
	2
ORDER BY
	1 DESC
LIMIT
	5;

select seller_id, buyer_id, total as nilai_transaksi, created_at as tanggal_transaksi
from orders
where buyer_id = 12476
order by 3 desc
limit 10

-- 10 Transaksi terbesar user 12476

SELECT 
    u.user_id,
    u.nama_user,
    SUM(o.total) AS total_pembelian
FROM 
    users u
INNER JOIN 
    orders o ON u.user_id = o.buyer_id
GROUP BY 
    u.user_id, u.nama_user
ORDER BY 
    total_pembelian DESC
LIMIT 5;

-- Transaksi per bulan
SELECT
    TO_CHAR(created_at::date, 'YYYY-MM') AS tahun_bulan,
    COUNT(1) AS jumlah_transaksi,
    SUM(total) AS total_nilai_transaksi
FROM
    orders
WHERE
    created_at >= '2020-01-01'
GROUP BY
    tahun_bulan
ORDER BY
    tahun_bulan;

-- Pengguna dengan rata-rata transaksi terbesar di Januari 2020
select buyer_id, count(1) as jumlah_transaksi, avg(total) as avg_nilai_transaksi
from orders
where created_at>='2020-01-01' and created_at<'2020-02-01'
group by 1
having count(1)>=2 
order by 3 desc
limit 10

-- Transaksi besar di Desember 2019
select nama_user as nama_pembeli, total as nilai_transaksi, created_at as tanggal_transaksi
from orders
inner join users on buyer_id = user_id
where created_at>='2019-12-01' and created_at<'2020-01-01'
and total >=20000000
order by 1

-- Kategori Produk Terlaris di 2020
select category, sum(quantity) as total_quantity, sum(price) as total_price
from orders
inner join order_details using(order_id)
inner join products using(product_id)
where created_at>='2020-01-01'
and delivery_at is not null
group by 1
order by 2 desc
limit 5

-- Mencari pembeli high value
select nama_user as nama_pembeli, count(1) as jumlah_transaksi, sum(total) as total_nilai_transaksi, min(total) as min_nilai_transaksi
from orders
inner join users on buyer_id = user_id
group by user_id, nama_user
having count(1) > 5 and min(total)>2000000
order by 3 desc

-- Mencari Dropshipper
select nama_user as nama_pembeli, count(1) as jumlah_transaksi, count(distinct orders.kodepos) as distinct_kodepos, sum(total) as total_nilai_transaksi, avg(total) as avg_nilai_transaksi
from orders
inner join users on buyer_id = user_id
group by user_id, nama_user
having count(1) >= 10 and count(1) = count(distinct orders.kodepos)
order by 2 desc

-- Mencari Reseller Offline
select nama_user as nama_pembeli, count(1) as jumlah_transaksi, sum(total) as total_nilai_transaksi, avg(total) as avg_nilai_transaksi, avg(total_quantity) as avg_quantity_per_transaksi
from orders
inner join users on buyer_id = user_id
inner join (select order_id, sum(quantity) as total_quantity from order_details group by 1) as summary_order using(order_id) 
where orders.kodepos = users.kodepos
group by user_id, nama_user
having count(1)>=8  and avg(total_quantity)>10
order by 3 desc

-- Pembeli sekaligus penjual
select nama_user as nama_pengguna, jumlah_transaksi_beli, jumlah_transaksi_jual
from users
inner join (select buyer_id, count(1) as jumlah_transaksi_beli from orders group by 1) as buyer on buyer_id = user_id
inner join (select seller_id, count(1) as jumlah_transaksi_jual from orders group by 1) as seller on seller_id = user_id
where jumlah_transaksi_beli>=7
order by 1

-- Lama transaksi dibayar
SELECT
    TO_CHAR(created_at::date, 'YYYY-MM') AS tahun_bulan,
    COUNT(1) AS jumlah_transaksi,
    AVG(paid_at::date - created_at::date) AS avg_lama_dibayar,
    MIN(paid_at::date - created_at::date) AS min_lama_dibayar,
    MAX(paid_at::date - created_at::date) AS max_lama_dibayar
FROM
    orders
WHERE
    paid_at IS NOT NULL
GROUP BY
    tahun_bulan
ORDER BY
    tahun_bulan;

SELECT 
    COUNT(*) FILTER (WHERE o.paid_at IS NULL) AS transaksi_tidak_dibayar,
    COUNT(*) FILTER (WHERE o.paid_at IS NOT NULL AND o.delivery_at IS NULL) AS transaksi_dibayar_tapi_tidak_dikirim,
    COUNT(*) FILTER (WHERE o.delivery_at IS NULL) AS transaksi_tidak_dikirim,
    COUNT(*) FILTER (WHERE o.paid_at IS NOT NULL AND o.delivery_at IS NOT NULL 
        AND DATE(CAST(o.paid_at AS TIMESTAMP)) = DATE(CAST(o.delivery_at AS TIMESTAMP))) AS transaksi_dikirim_hari_sama
FROM 
    orders o;


