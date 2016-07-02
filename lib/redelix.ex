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


 #CREDIT: thanks to Dogbert (http://stackoverflow.com/users/320615/dogbert)
 #http://stackoverflow.com/questions/38037325/elixir-how-to-post-on-a-rest-api-redmine-with-httpotion
 #~ def createIssue(issue) do
   #~ HTTPotion.post("#{url}/issues.json", [body: Plug.Conn.Query.encode(issue), basic_auth: auth()])
 #~ end
def createIssue(issue) do
 HTTPotion.post!("#{url}/issues.json", [body: Plug.Conn.Query.encode(%{issue: issue}) , basic_auth: auth()])
 end
 

 def updateIssue(issue_changes) do
   {ok, content} = Poison.encode(%{issue: Enum.into(issue_changes, %{})})
   HTTPotion.put!("#{url}/issues/#{issue_changes[:id]}.json", [body: content, basic_auth: auth(), headers: ["Content-Type": "application/json"]])
end


def deleteIssue(issue_id) do
  HTTPotion.delete!("#{url}/issues/#{issue_id}.json", [basic_auth: auth()] )
end


def addWatcher(issue_id, user_id) do
  HTTPotion.post!("#{url}/issues/#{issue_id}/watchers.json", [body: Plug.Conn.Query.encode(%{user_id: user_id}) , basic_auth: auth()])
end

def deleteWatcher(issue_id, user_id) do
  HTTPotion.delete!("#{url}/issues/#{issue_id}/watchers/#{user_id}.json", [basic_auth: auth()])
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

