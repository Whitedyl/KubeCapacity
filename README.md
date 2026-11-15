# Kubernetes Capacity Planner

A Rails application for estimating Kubernetes node capacity for a hypothetical
workload. The application uses CPU and memory resource requests, replica count,
node capacity, and reserved system capacity to produce a transparent planning
estimate.

## Local setup

Requirements:

- Ruby 4.0.7
- Rails 8.1.4
- SQLite

Install dependencies and prepare the database:

```powershell
bundle install
bin/rails db:prepare
```

Run the application:

```powershell
bin/rails server
```

Run the test suite:

```powershell
bin/rails test
```

## Architecture

The project follows the standard Rails MVC structure. Models handle
persisted data and validations, controllers handle HTTP requests, and service
objects will contain the capacity and Kubernetes-manifest calculations.

The first domain model is `SizingScenario`. Its input fields represent the
workload and node assumptions used by the capacity calculation.
