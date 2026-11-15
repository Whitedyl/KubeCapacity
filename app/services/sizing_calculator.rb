# Estimates node capacity from workload requests and usable node capacity.
class SizingCalculator
  def initialize(scenario)
    @scenario = scenario
  end

  def call
    {
      total_cpu_millicores: total_cpu_millicores,
      total_memory_megabytes: total_memory_megabytes,
      cpu_nodes_required: cpu_nodes_required,
      memory_nodes_required: memory_nodes_required,
      recommended_nodes: [cpu_nodes_required, memory_nodes_required].max,
      cpu_utilisation_percentage: utilisation(total_cpu_millicores, usable_node_cpu),
      memory_utilisation_percentage: utilisation(total_memory_megabytes, usable_node_memory)
    }
  end

  private

  attr_reader :scenario

  def total_cpu_millicores
    scenario.replica_count * scenario.cpu_request_millicores
  end

  def total_memory_megabytes
    scenario.replica_count * scenario.memory_request_megabytes
  end

  def usable_node_cpu
    capacity_after_reservation(scenario.node_cpu_millicores)
  end

  def usable_node_memory
    capacity_after_reservation(scenario.node_memory_megabytes)
  end

  def capacity_after_reservation(capacity)
    capacity * (100 - scenario.system_reserved_percentage) / 100.0
  end

  def cpu_nodes_required
    nodes_required(total_cpu_millicores, usable_node_cpu)
  end

  def memory_nodes_required
    nodes_required(total_memory_megabytes, usable_node_memory)
  end

  def nodes_required(required, usable_capacity)
    (required / usable_capacity).ceil
  end

  def utilisation(required, usable_capacity)
    (required / usable_capacity * 100).round(2)
  end
end
