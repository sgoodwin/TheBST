json.extract! listing, :id, :title, :info, :price, :currency, :created_at, :updated_at
json.url listing_url(listing, format: :json)
