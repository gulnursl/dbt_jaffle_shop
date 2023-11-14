WITH 
source AS (
  SELECT * FROM {{ source('jaffle_shop', 'payments') }}
),
renamed AS (
  SELECT
    id AS payment_id,
    order_id,
    payment_method,
    amount / 100 AS amount -- `amount` is currently stored in cents, so we convert it to dollars
  FROM 
    source
)
SELECT * FROM renamed
