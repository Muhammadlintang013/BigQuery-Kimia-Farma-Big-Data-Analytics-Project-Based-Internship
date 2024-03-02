#RAKAMIN-KF-analytics
SELECT 
  transaksi.transaction_id AS id_transaksi,
  transaksi.date AS tanggal_beli,
  kantor.branch_id AS id_kantor,
  kantor.branch_name AS nama_kantor,
  kantor.kota  AS kota,
  kantor.provinsi  AS provinsi,
  kantor.rating  AS rating_kantor,
  transaksi.customer_name AS nama_customer,
  transaksi.product_id AS id_produk,
  produk.product_name AS nama_produk,
  produk.price AS harga,
  transaksi.discount_percentage AS diskon,
CASE
    WHEN produk.price <= 50000 THEN 0.10
    WHEN produk.price > 50000 AND produk.price <= 100000 THEN 0.15
    WHEN produk.price > 100000 AND produk.price <= 300000 THEN 0.20
    WHEN produk.price > 300000 AND produk.price <= 500000 THEN 0.25
    WHEN produk.price > 500000 THEN 0.30
    ELSE NULL
  END AS persentase_gross_laba,
  CAST(produk.price * (1 - transaksi.discount_percentage) AS INT64) AS nett_sales,
  CAST(produk.price * (1 - discount_percentage) * CASE
    WHEN produk.price <= 50000 THEN 0.1
    WHEN produk.price > 50000 AND produk.price <= 100000 THEN 0.15
    WHEN produk.price > 100000 AND produk.price <= 300000 THEN 0.2
    WHEN produk.price > 300000 AND produk.price <= 500000 THEN 0.25
    WHEN produk.price > 500000 THEN 0.3
    ELSE NULL
  END  AS INT64) AS nett_profit,
FROM rakamin-kf-analytics-415918.kimia_farma.transaksi AS transaksi
LEFT JOIN rakamin-kf-analytics-415918.kimia_farma.kantor AS kantor ON transaksi.branch_id = kantor.branch_id
LEFT JOIN rakamin-kf-analytics-415918.kimia_farma.produk AS produk ON transaksi.product_id = produk.product_id
LEFT JOIN rakamin-kf-analytics-415918.kimia_farma.inventori AS inventori ON produk.product_id = inventori.product_id
LIMIT 10000;
