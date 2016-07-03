# Redelix

Elixir Redmine RestAPI client 

## Installation

* Unzip 
* mix.deps get
* config url and auth in config/config.exs

## Usage

* iex -S mix

Get an issue by id
> iex(1)> Redelix.getIssue("139357")

Get issues by filtering 
> iex(2)> Redelix.getIssues(project_id: "112485", tracker_id: "2")

Create a new issue
> iex(3)> Redelix.createIssue(project_id: "112485", tracker_id: "2", priority_id: 1, subject: "This is a subject")

Get all the projects
> iex(4)> Redelix.getProjects()


## Include

Most of the API is covered or going to be covered
Check the code for more info.
Documentation: coming soon

## Limitations

* Key-based auth not yet supported

## Todos

* Adding key-based authentication
* Documentation
* Unit Tests

# CREDITS

* Dogbert (hint at [stackoverflow question](http://stackoverflow.com/questions/38037325/elixir-how-to-post-on-a-rest-api-redmine-with-httpotion) used in commit 7effa4d