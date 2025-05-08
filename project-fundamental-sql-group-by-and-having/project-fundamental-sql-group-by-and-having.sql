--Introducing
--Setelah teman - teman mempelajari tentang penggunaan Group By dan Having dalam modul belajar
    --Fundamental SQL Group By and Having sebelumnya, sekarang teman - teman akan menggunakan Group By dan Having
    --tersebut lebih dalam lagi.

    --Data yang digunakan sama dengan pada modul Fundamental SQL Group By and Having.

    --Mendapatkan jumlah nilai pinalty
    --Pada pelayanan terdapat customer yang mendapatkan pinalty yang diakibatkan telat membayar.

    --Carilah customer - customer id dan jumlah pinalty dari yang dibayarkan oleh customer yang mendapatkan pinalty.

SELECT
customer_id,
sum(pinalty)
FROM invoice
GROUP BY customer_id
HAVING sum(pinalty) > 20000;

--Mencari customer yang mengganti layanan
--Dalam pelayanan jaringan internet akan terjadi perubahan paket yang dilakukan oleh konsumen tersebut.
    --Sekarang kita akan mencari konsumen - konsumen yang melakukan perubahan layanannya.

    --Ada 3 table yang dibutuhkan dalam mencari data tersebut:

    --customer
    --subscription
    --product
    --Lakukanlah query dengan petunjuk sebagai berikut:

    SELECT t1.name, group_concat(t3.product_name) as product_name
FROM customer t1
JOIN subscription t2 ON t1.id = t2.customer_id
JOIN product t3 ON t2.product_id = t3.id
WHERE t1.id IN(
    SELECT customer_id FROM subscription GROUP BY customer_id HAVING COUNT(customer_id) > 1
)
GROUP BY t1.name;