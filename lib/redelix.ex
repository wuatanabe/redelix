defmodule Redelix do

 @derive [Poison.Decoder, Poison.Encoder]
  
   def getWiki(project_name, wiki_page_name) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/projects/#{project_name}/wiki/#{wiki_page_name}.json", [basic_auth: auth()])
    return_decoded_response(decoded_response, "wiki_page")
 end
  
 def getWikis(project_name) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/projects/#{project_name}/wiki/index.json", [basic_auth: auth()])
    return_decoded_response(decoded_response, "wiki_pages")
 end
 
 
 def createIssue(issue) do
  value = %{"project_id" => 1, "subject" => "Example", "priority_id" => 1, "tracker_id" => 1}
  content=   Poison.Encoder.encode(value, [])
  HTTPotion.post("#{url}/issues.json", [body: "issue=#{content}" , basic_auth: auth()])
 end
 
  
 def getIssue(issue_id) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/issues/#{issue_id}.json", [basic_auth: auth()])
    return_decoded_response(decoded_response, "issue")
end 

def getIssues() do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/issues.json", [basic_auth: auth()]  ) 
    return_decoded_response(decoded_response, "issues")
end

def getIssues(query_string) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/issues.json", [basic_auth: auth(), query: query_string]  ) 
    return_decoded_response(decoded_response, "issues")
end


 def url() do
    Application.get_env(:redelix, :url)
 end
 
 def auth() do
    {Application.get_env(:redelix, :username) , Application.get_env(:redelix, :password) }
 end

defp return_decoded_response(decoded_response, key) do
    case  decoded_response do
	{:ok, items} ->
	  {:ok, items[key]}
	_ ->
	  decoded_response
       end
end

 defp decode_get_response(response) do
    case response do
	%HTTPotion.Response{status_code: 200} ->
          Poison.decode(response.body)
        _->
	 {:error, response.status_code}
       end
 end
 
end

