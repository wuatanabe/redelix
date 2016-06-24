defmodule Redelix do

 @derive [Poison.Decoder]
  
 def getIssue(issue_id) do
    decoded_response=decode_get_issue_response(HTTPotion.get "#{url}/issues/#{issue_id}.json", auth)
    case  decoded_response do
	{:ok, issue} ->
	  {:ok, issue["issue"]}
	_ ->
	  decoded_response
       end
end 


 def url() do
    Application.get_env(:redelix, :url)
 end
 
 def auth() do
    [basic_auth: {Application.get_env(:redelix, :username) , Application.get_env(:redelix, :password) }]
 end
 
 def decode_get_issue_response(response) do
    case response do
	%HTTPotion.Response{status_code: 200} ->
          Poison.decode(response.body)
        _->
	 {:error, response.status_code}
       end
 end
 
end
