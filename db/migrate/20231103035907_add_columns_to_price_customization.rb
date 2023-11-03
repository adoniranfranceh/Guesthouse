class AddColumnsToPriceCustomization < ActiveRecord::Migration[7.1]
  def change
    add_column :price_customizations, :season, :integer
    add_column :price_customizations, :season_name, :string
  end
end
