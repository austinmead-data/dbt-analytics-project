with first_order_date as (

    select 
        customer_id,
        customer_name,
        min(order_date) as first_order_date,
        min(date_trunc('week', order_date)) as first_order_week,
        min(date_trunc('month', order_date)) as first_order_month
    from main."stg_superstore"
    group by 1,2

)

select * from first_order_date