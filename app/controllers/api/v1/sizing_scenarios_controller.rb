class Api::V1::SizingScenariosController < ApplicationController
  def create
    scenario = SizingScenario.new(sizing_scenario_params)

    if scenario.save
      render json: scenario_response(scenario), status: :created
    else
      render json: { errors: scenario.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    scenario = SizingScenario.find(params[:id])
    render json: scenario_response(scenario)
  end

  private

  def sizing_scenario_params
    params.require(:sizing_scenario).permit(
      :name,
      :replica_count,
      :cpu_request_millicores,
      :memory_request_megabytes,
      :node_cpu_millicores,
      :node_memory_megabytes,
      :system_reserved_percentage
    )
  end

  def scenario_response(scenario)
    {
      id: scenario.id,
      name: scenario.name,
      inputs: scenario.attributes.except(
        "id",
        "name",
        "created_at",
        "updated_at"
      ),
      calculation: SizingCalculator.new(scenario).call
    }
  end
end
