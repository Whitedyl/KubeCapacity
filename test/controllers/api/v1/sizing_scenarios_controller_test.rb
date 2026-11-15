require "test_helper"

class Api::V1::SizingScenariosControllerTest < ActionDispatch::IntegrationTest
  test "creates a sizing scenario and returns its calculation" do
    assert_difference("SizingScenario.count", 1) do
      post api_v1_sizing_scenarios_url,
           params: {
             sizing_scenario: {
               name: "Web application",
               replica_count: 6,
               cpu_request_millicores: 500,
               memory_request_megabytes: 1024,
               node_cpu_millicores: 4000,
               node_memory_megabytes: 8192,
               system_reserved_percentage: 20
             }
           },
           as: :json
    end

    assert_response :created
    response_body = JSON.parse(response.body)
    assert_equal "Web application", response_body["name"]
    assert_equal 1, response_body.dig("calculation", "recommended_nodes")
  end

  test "rejects an invalid sizing scenario" do
    assert_no_difference("SizingScenario.count") do
      post api_v1_sizing_scenarios_url,
           params: {
             sizing_scenario: {
               name: "",
               replica_count: 0
             }
           },
           as: :json
    end

    assert_response :unprocessable_entity
    assert JSON.parse(response.body)["errors"].any?
  end

  test "returns a saved sizing scenario and its calculation" do
    scenario = SizingScenario.create!(
      name: "Saved workload",
      replica_count: 3,
      cpu_request_millicores: 500,
      memory_request_megabytes: 512,
      node_cpu_millicores: 4000,
      node_memory_megabytes: 8192,
      system_reserved_percentage: 20
    )

    get api_v1_sizing_scenario_url(scenario), as: :json

    assert_response :success
    response_body = JSON.parse(response.body)
    assert_equal scenario.id, response_body["id"]
    assert_equal 1, response_body.dig("calculation", "recommended_nodes")
  end
end
