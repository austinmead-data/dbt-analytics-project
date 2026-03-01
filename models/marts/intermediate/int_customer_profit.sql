with customer_profit as (

    select 
        customer_id,
        customer_name,
        sum(profit) as lifetime_customer_profit,
        sum(case when date_trunc('year',order_date) = date_trunc('year',getdate()) then profit else 0 end) as ytd_customer_profit,
        sum(case when date_trunc('quarter',order_date) = date_trunc('quarter',getdate()) then profit else 0 end) as qtd_customer_profit,
        sum(case when date_trunc('month',order_date) = date_trunc('month',getdate()) then profit else 0 end) as mtd_customer_profit,
        sum(case when order_date >= dateadd(day,-30,getdate()) then profit else 0 end) as l30_days_profit,
        sum(case when order_date >= dateadd(day,-60,getdate()) then profit else 0 end) as l60_days_profit,
        sum(case when order_date >= dateadd(day,-90,getdate()) then profit else 0 end) as l90_days_profit
    from {{ ref('stg_superstore') }}
    {{ dbt_utils.group_by(n=2) }}
)

select * from customer_profit