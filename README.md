# Redelix

Elixir Redmine RestAPI client 

## Installation

* Unzip 
* mix.deps get
* config url and auth in config/config.exs

## Usage

* iex -S mix

Get an issue by id
iex(1)> Redelix.getIssue("139357")

Get issues by filtering 
iex(2)> Redelix.getIssues(project_id: "112485", tracker_id: "2")

Create a new issue

iex(3)> Redelix.createIssue(project_id: "112485", tracker_id: "2", priority_id: 1, subject: "This is a subject")



# CREDITS

* Dogbert (hint at http://stackoverflow.com/questions/38037325/elixir-how-to-post-on-a-rest-api-redmine-with-httpotion used in commit 7effa4d)