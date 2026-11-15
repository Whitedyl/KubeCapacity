require "test_helper"

class SizingCalculatorTest < ActiveSupport::TestCase
  test "calculates capacity using the larger CPU or memory requirement" do
    scenario = SizingScenario.new(
      name: "Web workload",
      replica_count: 6,
      cpu_request_millicores: 500,
      memory_request_megabytes: 1024,
      node_cpu_millicores: 4000,
      node_memory_megabytes: 8192,
      system_reserved_percentage: 20
    )

    result = SizingCalculator.new(scenario).call

    assert_equal 3000, result[:total_cpu_millicores]
    assert_equal 6144, result[:total_memory_megabytes]
    assert_equal 1, result[:cpu_nodes_required]
    assert_equal 1, result[:memory_nodes_required]
    assert_equal 1, result[:recommended_nodes]
    assert_equal 93.75, result[:cpu_utilisation_percentage]
    assert_equal 96.0, result[:memory_utilisation_percentage]
  end

  test "rounds up when a workload does not fit on one node" do
    scenario = SizingScenario.new(
      name: "Large workload",
      replica_count: 10,
      cpu_request_millicores: 1000,
      memory_request_megabytes: 512,
      node_cpu_millicores: 4000,
      node_memory_megabytes: 8192,
      system_reserved_percentage: 0
    )

    result = SizingCalculator.new(scenario).call

    assert_equal 3, result[:cpu_nodes_required]
    assert_equal 1, result[:memory_nodes_required]
    assert_equal 3, result[:recommended_nodes]
  end
end
