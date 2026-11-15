require "test_helper"

class SizingScenarioTest < ActiveSupport::TestCase
  test "accepts a complete sizing scenario" do
    scenario = SizingScenario.new(
      name: "Web workload",
      replica_count: 3,
      cpu_request_millicores: 500,
      memory_request_megabytes: 512,
      node_cpu_millicores: 4000,
      node_memory_megabytes: 8192,
      system_reserved_percentage: 20
    )

    assert_predicate scenario, :valid?
  end

  test "rejects missing and non-positive capacity values" do
    scenario = SizingScenario.new

    assert_not_predicate scenario, :valid?
    assert_includes scenario.errors[:name], "can't be blank"

    scenario.assign_attributes(
      name: "Invalid workload",
      replica_count: 0,
      cpu_request_millicores: -1,
      memory_request_megabytes: 512,
      node_cpu_millicores: 4000,
      node_memory_megabytes: 8192,
      system_reserved_percentage: 100
    )

    assert_not_predicate scenario, :valid?
    assert scenario.errors[:replica_count].any?
    assert scenario.errors[:cpu_request_millicores].any?
    assert scenario.errors[:system_reserved_percentage].any?
  end
end
