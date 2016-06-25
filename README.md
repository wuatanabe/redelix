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


iex(5)> Redelix.getIssues(project_id: "112485", status_id: "2")
{:ok, []}
iex(6)> Redelix.getIssues(project_id: "112485", tracker_id: "2")
{:ok,
 [%{"assigned_to" => %{"id" => 157747, "name" => "aaaa bbbb"},
    "author" => %{"id" => 157747, "name" => "aaaa bbbb"},
    "created_on" => "2016-06-24T09:36:58.000Z", "description" => "aaaa",
    "done_ratio" => 0, "id" => 139327,
    "priority" => %{"id" => 4, "name" => "Normal"},
    "project" => %{"id" => 112485, "name" => "adfad"},
    "start_date" => "2016-06-24", "status" => %{"id" => 1, "name" => "New"},
    "subject" => "dfa", "tracker" => %{"id" => 2, "name" => "Feature"},
    "updated_on" => "2016-06-24T09:36:58.000Z"}]}
iex(7)> Terminare il processo batch (S/N)? s
