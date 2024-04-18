json.extract! payment, :id, :from_user, :to_user, :amount, :note, :method, :created_at, :updated_at
json.url payment_url(payment, format: :json)
