class AddListingStatus < ActiveRecord::Migration[7.0]
  def up
    execute <<-SQL
      DROP TYPE IF EXISTS listing_status;
      CREATE TYPE listing_status AS ENUM ('active', 'cancelled', 'sold');
    SQL
    add_column :listings, :status, :listing_status, default: 'active'
  end

  def down
    execute <<-SQL
      DROP TYPE listing_status;
    SQL
    remove_column :listings, :status
  end
end
