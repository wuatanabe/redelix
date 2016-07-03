defmodule Redelix do

 @derive [Poison.Decoder, Poison.Encoder]
  


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
    getElementById("issues", "issue", issue_id) 
end 

def getIssues() do 
    getListOf("issues", "issues")
end

def getTrackers() do 
    getListOf("trackers", "trackers")
end

def deleteTracker(tracker_id) do
  deleteElementById("trackers", "trackers", tracker_id) 
end

def getProjects() do 
    getListOf("projects", "projects")
end
  
 def getProject(project_id) do
    getElementById("projects", "projects", project_id) 
end 

def createProject(project) do
 HTTPotion.post!("#{url}/projects.json", [body: Plug.Conn.Query.encode(%{project: project}) , basic_auth: auth()])
end

def deleteProject(project_id) do
  deleteElementById("projects", "projects", project_id) 
end

def getMembershipsByProjectId(project_id) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/projects/#{project_id}/memberships.json", [basic_auth: auth()])
    return_decoded_response(decoded_response, "memberships")
end

def getMembershipsByProjectIdentifier(project_identifier) do
 getMembershipsByProjectId(project_identifier)
end

def getMembership(membership_id) do
  getElementById("memberships", "memberships", membership_id) 
end

def createMembership(project_id, membership) do
 HTTPotion.post!("#{url}/projects/#{project_id}/memberships.json", [body: Plug.Conn.Query.encode(%{membership: membership}) , basic_auth: auth()])
end

def deleteProjectMembership(membership_id) do
  deleteElementById("memberships", "memberships", membership_id) 
end
	

def getUsers() do 
    getListOf("users", "users")
end

 def getUser(user_id) do
    getElementById("users", "user", user_id) 
end

def createUser(user) do
 HTTPotion.post!("#{url}/users.json", [body: Plug.Conn.Query.encode(%{user: user}) , basic_auth: auth()])
end

def deleteUser(user_id) do
  deleteElementById("users", "users", user_id) 
end

def getQueries() do
  getListOf("queries", "queries")
end

def getQuery(query_id) do
    getElementById("queries", "queries", query_id) 
end

def deleteQuery(query_id) do
  deleteElementById("queries", "queries", query_id) 
end

def getRoles() do 
    getListOf("roles", "roles")
end

 def getRole(role_id) do
    getElementById("roles", "role", role_id) 
end

def deleteRole(role_id) do
  deleteElementById("roles", "roles", role_id) 
end

def getGroups() do 
    getListOf("groups", "groups")
end

 def getGroup(group_id) do
    getElementById("groups", "group", group_id) 
end

def deleteGroup(group_id) do
  deleteElementById("groups", "groups", group_id) 
end

def getVersions() do 
    getListOf("versions", "versions")
end

def getVersion(version_id) do 
    getElementById("versions", "version", version_id)
end

def getNews() do
   getListOf("news", "news")
end


def getCustomFields() do
   getListOf("custom_fields", "custom_fields")
end

def getCustomField(custom_field_id) do
   getElementById("custom_fields", "custom_fields", custom_field_id)
end

def getTimeEntries() do
   getListOf("time_entries", "time_entries")
end

def getEnumerations(enumeration_id) do
   getElementById("enumerations", "enumerations", enumeration_id)
end

def getEnumerations() do
   getListOf("enumerations", "enumerations")
end

def getCategories() do
   getListOf("categories", "categories")
end

def getCategory(category_id) do
   getElementById("category", "categories", category_id)
end

def getStatuses() do
   getListOf("statuses", "statuses")
end

def getStatus(status_id) do
   getElementById("statuses", "statuses", status_id)
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
  #HTTPotion.delete!("#{url}/issues/#{issue_id}.json", [basic_auth: auth()] )
  deleteElementById("issues", "issues", issue_id) 
end

def getIssueRelations(issue_id) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/issues/#{issue_id}/relations.json", [basic_auth: auth()])
    return_decoded_response(decoded_response, "relations")
end

def getIssueRelation(relation_id) do
   getElementById("relations", "relations", relation_id)
end

def createIssueRelation(issue_id, issue_relation) do
  HTTPotion.post!("#{url}/issues/#{issue_id}/relations.json", [body: Plug.Conn.Query.encode(%{relation: issue_relation}) , basic_auth: auth()])
end

def deleteIssueRelation(relation_id) do
  #HTTPotion.delete!("#{url}/relations/#{relation_id}.json", [basic_auth: auth()] )
  deleteElementById("relations", "relations", relation_id) 
end


def addWatcher(issue_id, user_id) do
  HTTPotion.post!("#{url}/issues/#{issue_id}/watchers.json", [body: Plug.Conn.Query.encode(%{user_id: user_id}) , basic_auth: auth()])
end

def deleteWatcher(issue_id, user_id) do
  HTTPotion.delete!("#{url}/issues/#{issue_id}/watchers/#{user_id}.json", [basic_auth: auth()])
end


def getAttachment(attachment_id) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/attachments/#{attachment_id}.json", [basic_auth: auth()])
    return_decoded_response(decoded_response, "attachments")
end

 def url() do
    Application.get_env(:redelix, :url)
 end
 
 def auth() do
    {Application.get_env(:redelix, :username) , Application.get_env(:redelix, :password) }
 end

defp getElementById(subpath_for_resource, resource, resource_id) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/#{subpath_for_resource}/#{resource_id}.json", [basic_auth: auth()])
    return_decoded_response(decoded_response, resource)
end

defp getListOf(subpath_for_resources, resources) do
    decoded_response=decode_get_response(HTTPotion.get "#{url}/#{resources}.json", [basic_auth: auth()]  ) 
    return_decoded_response(decoded_response, resources)	
end

defp deleteElementById(subpath_for_resource, resource, resource_id) do
  HTTPotion.delete!("#{url}/#{subpath_for_resource}/#{resource_id}.json", [basic_auth: auth()] )
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

