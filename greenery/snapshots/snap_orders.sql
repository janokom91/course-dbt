{% snapshot snap_orders %}

  {{
    config(
      target_schema='snapshots',
      unique_key='order_id',
      strategy='check',
      check_cols='all',
    )
  }}

  SELECT * FROM {{ source('plants', 'orders') }}

{% endsnapshot %}
