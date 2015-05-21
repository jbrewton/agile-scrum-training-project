require 'fileutils'
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
    g = Git.open('/tmp/tasklistapp/TaskListApp', :log => Logger.new(STDOUT))
    #g.add_remote('TaskListApp', 'https://bitbucket.org/vetrik77/tasklistapp')
    g.add(:all=>true) 
    g.commit_all('Auto commit')
    #g.push
    g.push(g.remote('tasklistapp'))
  end

  def get_ssh_key
    if current_user
      url = base_uri_v1 + current_user.uid + '/ssh-keys/'
      response = access_token.get(url)
      response.body
    end
  end

  def create_file
    if !Dir['/tmp/tasklistapp']
      g = Git.clone('https://bitbucket.org/vetrik77/tasklistapp', 'TaskListApp', :path => '/tmp/tasklistapp')
    else
      g = Dir.entries('/tmp/tasklistapp/TaskListApp')
    end
    if !Dir['/tmp/tasklistapp/TaskListApp/tasklist.txt']
      tasks = Task.all
      tasks.each do |t|
        File.open('/tmp/tasklistapp/TaskListApp/tasklist.txt', 'w') { |file| file.write(t)}
      end
    end
  end
end