# Redelix

Simple Elixir Redmine RestAPI client 

## Installation

* Unzip 
* mix.deps get
* config url and auth in config/config.exs

## Usage

* iex -S mix

iex(2)> Redelix.getIssue("139357")
{:ok,
 %{"author" => %{"id" => 157839, "name" => "edek edek"},
   "created_on" => "2016-06-24T13:07:22.000Z", "description" => "asdfasdfasdf",
   "done_ratio" => 0, "id" => 139357,
   "priority" => %{"id" => 4, "name" => "Normal"},
   "project" => %{"id" => 112484, "name" => "aaaaaaa"}, "spent_hours" => 0.0,
   "start_date" => "2016-06-24", "status" => %{"id" => 1, "name" => "New"},
   "subject" => "sdfasd", "tracker" => %{"id" => 1, "name" => "Bug"},
   "updated_on" => "2016-06-24T13:07:22.000Z"}}


