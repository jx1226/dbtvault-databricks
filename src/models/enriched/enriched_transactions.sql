SELECT
    b.O_ORDERKEY AS ORDER_ID,
    b.O_CUSTKEY AS CUSTOMER_ID,
    b.O_ORDERDATE AS ORDER_DATE,
    DATEADD(DAY, 20, b.O_ORDERDATE) AS TRANSACTION_DATE,
    UUID() AS TRANSACTION_NUMBER, 
    b.O_TOTALPRICE AS AMOUNT,
    CAST(
    CASE ABS(MOD(RANDOM(1), 2)) + 1
        WHEN 1 THEN 'DR'
        WHEN 2 THEN 'CR'
    END AS VARCHAR(2)) AS TYPE
FROM {{ source('tpch_sample', 'orders') }}  AS b
LEFT JOIN {{ source('tpch_sample', 'customers') }} AS c
    ON b.O_CUSTKEY = c.C_CUSTKEY