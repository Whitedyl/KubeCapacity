class RenameReservedPercentageOnSizingScenarios < ActiveRecord::Migration[8.1]
  def change
    rename_column :sizing_scenarios, :reserved_percentage, :system_reserved_percentage
  end
end
