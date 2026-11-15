class CreateSizingScenarios < ActiveRecord::Migration[8.1]
  def change
    create_table :sizing_scenarios do |t|
      t.string :name
      t.integer :replica_count
      t.integer :cpu_request_millicores
      t.integer :memory_request_megabytes
      t.integer :node_cpu_millicores
      t.integer :node_memory_megabytes
      t.integer :reserved_percentage

      t.timestamps
    end
  end
end
