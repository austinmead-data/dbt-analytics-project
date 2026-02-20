with last_order_date as (

    select 
        customer_id,
        customer_name,
        max(order_date) as last_order_date,
        max(date_trunc('week', order_date)) as last_order_week,
        max(date_trunc('month', order_date)) as last_order_month
    from {{ ref('stg_superstore') }}
    {{ dbt_utils.group_by(n=2) }}

)

select * from last_order_date