module BitbucketHelper
  def access_token
    session[:access_token]
  end
  
  def base_uri_v1
    "https://bitbucket.org/api/1.0/repositories/" 
  end

  def base_uri_v2
    "https://bitbucket.org/api/2.0/repositories/"
  end

  def repo_exists
    if current_user
      url = base_uri_v1 + current_user.uid + '/tasklistapp'
      json_response = access_token.get(url)
    end
    if json_response.code != "200"
      return false
    end
    return true
  end

  def create_repo
    if current_user
      url = base_uri_v2 + current_user.uid + '/tasklistapp'
      response = access_token.post(url)
    end
  end

  def file_exists
    if current_user
      url = base_uri_v1 + current_user.uid + '/tasklistapp/raw/master/tasklist.txt'
      response = access_token.get(url)
    end
    if response.code != "200"
      return false
    end
    return true
  end

  def pull_file
    if current_user
      url = base_uri_v1 + current_user.uid + '/tasklistapp/raw/master/tasklist.txt'
      response = access_token.get(url) 
    end
  end

  def save_file
    if current_user
      url = base_uri_v1 + current_user.uid + '/tasklistapp/raw/master/tasklist.txt'
      response = access_token.post(url)
    end
  end
end