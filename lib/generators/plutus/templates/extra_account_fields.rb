class AddExtraAccountFields < ActiveRecord::Migration[6.0]
  def change
    add_column :plutus_accounts, :code, :integer
    add_column :plutus_accounts, :rollup_code, :integer
  end
end
