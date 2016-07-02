defmodule Redelix do

 @derive [Poison.Decoder, Poison.Encoder]
  
  
def getListOf(subpath_for_resources, resources) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/#{resources}.json", [basic_auth: auth()]  ) 
    return_decoded_response(decoded_response, resources)	
end


def getWiki(project_name, wiki_page_name) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/projects/#{project_name}/wiki/#{wiki_page_name}.json", [basic_auth: auth()])
    return_decoded_response(decoded_response, "wiki_page")
 end

 def uploadAttachment(attachment) do
    HTTPotion.post!("#{url}/uploads.json", [body: attachment , basic_auth: auth(), headers: ["Content-Type": "application/octet-stream"]])  
 end


def getWikiVersion(project_name, wiki_page_name, version) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/projects/#{project_name}/wiki/#{wiki_page_name}/#{version}.json", [basic_auth: auth()])
    return_decoded_response(decoded_response, "wiki_page")
end
  
 def getWikis(project_name) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/projects/#{project_name}/wiki/index.json", [basic_auth: auth()])
    return_decoded_response(decoded_response, "wiki_pages")
 end
  

def deleteWiki(project_name, wiki_page_name) do
  HTTPotion.delete!("#{url}/projects/#{project_name}/wiki/#{wiki_page_name}.json", [basic_auth: auth()] )
end

def updateWiki(project_name, wiki_page_name, wiki_changes) do
    {ok, content} = Poison.encode(%{wiki_page: Enum.into(wiki_changes, %{})})
    HTTPotion.put!("#{url}/projects/#{project_name}/wiki/#{wiki_page_name}.json", [body: content, basic_auth: auth(), headers: ["Content-Type": "application/json"]])  
end

def createWiki(project_name, wiki_page_name, wiki_changes) do
    updateWiki(project_name, wiki_page_name, wiki_changes)
end
  
 def getIssue(issue_id) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/issues/#{issue_id}.json", [basic_auth: auth()])
    return_decoded_response(decoded_response, "issue")
end 

def getIssues() do 
    getListOf("issues", "issues")
end

def getTrackers() do 
    getListOf("trackers", "trackers")
end

def getProjects() do 
    getListOf("projects", "projects")
end

def getUsers() do 
    getListOf("users", "users")
end

def getRoles() do 
    getListOf("roles", "roles")
end

def getGroups() do 
    getListOf("groups", "groups")
end

def getVersions() do 
    getListOf("versions", "versions")
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

