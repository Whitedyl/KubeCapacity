class SizingScenario < ApplicationRecord
  validates :name, presence: true
  validates :replica_count,
            :cpu_request_millicores,
            :memory_request_megabytes,
            :node_cpu_millicores,
            :node_memory_megabytes,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }
  validates :system_reserved_percentage,
            presence: true,
            numericality: { only_integer: true, in: 0..99 }
end
