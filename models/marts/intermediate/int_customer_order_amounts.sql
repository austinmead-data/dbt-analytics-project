with customer_order_amounts as (

    select 
        customer_id,
        customer_name,
        sum(sales) as lifetime_customer_sales,
        sum(case when date_trunc('year',order_date) = date_trunc('year',getdate()) then sales else 0 end) as ytd_customer_sales,
        sum(case when date_trunc('quarter',order_date) = date_trunc('quarter',getdate()) then sales else 0 end) as qtd_customer_sales,
        sum(case when date_trunc('month',order_date) = date_trunc('month',getdate()) then sales else 0 end) as mtd_customer_sales,
        sum(case when order_date >= dateadd(day,-30,getdate()) then sales else 0 end) as l30_days_sales,
        sum(case when order_date >= dateadd(day,-60,getdate()) then sales else 0 end) as l60_days_sales,
        sum(case when order_date >= dateadd(day,-90,getdate()) then sales else 0 end) as l90_days_sales
    from {{ ref('stg_superstore') }}
    {{ dbt_utils.group_by(n=2) }}
)

select * from customer_order_amounts