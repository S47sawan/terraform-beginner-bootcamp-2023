# Terraform Beginner Bootcamp – Week 2 

## [Sinatra Server]( https://sinatrarb.com/documentation.html)

In week 2 Terraform bootcamp we will be deploying a developer **Sinatra** mock server.
Sinatra is a lightweight framework used for building web applications in ruby with minimal effort.

### Installation of Sinatra server into terraform_beginner_bootcamp_2023 directory:
:forward_arrow: In GitHub create an issue Terratowns Mock Server.
:forward_arrow: Next create a branch from the GitHub.
:forward_arrow: Select the newly created branch in the GitHub from the drop-down menu and click on the Gitpod green button.

![Github Flow](<Screenshot 2023-10-10 101257.png>)

:forward_arrow: In the Gitpod, clone the terratown_mock_server directory into the existing environment.
````bash
$ git clone https://github.com/ExamProCo/terratowns_mock_server
````
:forward_arrow: At this stage your code has two .git files which should not be the case. Remove the .git file from the terraform_mock_server directory.
:forward_arrow: To view the .git file in terminal
 ```` bash
 $ Ls -al
````
This command will list all directories and files including the hidden files e.g. .git file.
:forward_arrow: Remove the. git from the terraform_mock_server directory.
             : warning: double check that you are in the terraform_mock_server directory.
````bash
 $ rm -rf. git
````
Run the ` ls -al ‘command in the terraform_mock_server directory to check that. git has been removed. At this stage you should only have one. git in the main project.
### Edit the.gitpod.yml file
Edit the existing .gitpod.yml  file with the code block below. 
```` yml
tasks:
 - name: sinatra
    init: | 
      bundle install              # Bundle is a package manager for Ruby. 
      bundle exec ruby server.rb
````
#### `bundle install`: 
This command installs Ruby gems specified in the project’s `Gemfile`. It ensures that all required dependencies for the Sinatra application are installed.
Gemfile 
````rb
source "https://rubygems.org"
gem 'sinatra'
gem 'rake'
gem 'pry'
gem 'puma'
gem 'activerecord'
````
#### `bundle exec ruby server.rb`: 
This command executes the Sinatra web application. It uses the `bundle exec` prefix to run the Ruby script `server.rb` within the context of the installed gems and dependencies.
A Gemfile.lock file will be created to lock down the gem versions used in this project.
Once the .gitpod.yml file is updated with the new block of code, it should look like this:
````yaml
tasks:
  - name: sinatra
    before : | 
      cd $PROJECT_ROOT
      cd terratowns_mock_server
      bundle install
      bundle exec ruby server.rb 
  - name: terraform
    before: |
      cd $PROJECT_ROOT
      source ./bin/install_terraform_cli
      source ./bin/generate_tfrc_credentials
      source ./bin/set_tf_alias
      cp $PROJECT_ROOT/terraform.tfvars.example $PROJECT_ROOT/terraform.tfvars
  - name: aws-cli
    env:
      AWS_CLI_AUTO_PROMPT: on-partial
    before: |
      cd $PROJECT_ROOT
      source ./bin/install_aws_cli
      source ./bin/set_tf_alias
  - name: https-server
    before: |
      cd $PROJECT_ROOT
      npm install --global http-server
    command:
      http-server 
vscode:
  extensions:
    - amazonwebservices.aws-toolkit-vscode
    - hashicorp.terraform
    - phil294.git-log--graph
````
:arrow_forward: At this stage commit all changes and stop the workspace. Reopen the workspace so that when a new workspace is span up, the Sinatra server is up and running!

![Sinatra Server Running](<Screenshot 2023-10-10 092937.png>)

The developer mock server is now up and running.

Click on open browser and it will take you to a window as shown below:

![Sinatra web server serving the page](<Screenshot 2023-10-10 083216.png>)

#### Sinatra server code.
The code for the mock server is stored in a file called server.rb
```` rb
require 'sinatra'
require 'json'
require 'pry'
require 'active_model'

$home = {}

class Home
  include ActiveModel::Validations
  attr_accessor :town, :name, :description, :domain_name, :content_version

  validates :town, presence: true
  validates :name, presence: true
  validates :description, presence: true
  validates :domain_name, 
    format: { with: /\.cloudfront\.net\z/, message: "domain must be from .cloudfront.net" }
    # uniqueness: true, 

  validates :content_version, numericality: { only_integer: true }
end

class TerraTownsMockServer < Sinatra::Base

  def error code, message
    halt code, {'Content-Type' => 'application/json'}, {err: message}.to_json
  end

  def error_json json
    halt code, {'Content-Type' => 'application/json'}, json
  end

  def ensure_correct_headings
    unless request.env["CONTENT_TYPE"] == "application/json"
      error 415, "expected Content_type header to be application/json"
    end

    unless request.env["HTTP_ACCEPT"] == "application/json"
      error 406, "expected Accept header to be application/json"
    end
  end

  def x_access_code
    '9b49b3fb-b8e9-483c-b703-97ba88eef8e0'
  end

  def x_user_uuid
    'e328f4ab-b99f-421c-84c9-4ccea042c7d1'
  end

  def find_user_by_bearer_token
    auth_header = request.env["HTTP_AUTHORIZATION"]
    if auth_header.nil? || !auth_header.start_with?("Bearer ")
      error 401, "a1000 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    code = auth_header.split("Bearer ")[1]
    if code != x_access_code
      error 401, "a1001 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    if params['user_uuid'].nil?
      error 401, "a1002 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end

    unless code == x_access_code && params['user_uuid'] == x_user_uuid
      error 401, "a1003 Failed to authenicate, bearer token invalid and/or teacherseat_user_uuid invalid"
    end
  end

  # CREATE
  post '/api/u/:user_uuid/homes' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# create - POST /api/homes"

    begin
      payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      halt 422, "Malformed JSON"
    end

    # Validate payload data
    name = payload["name"]
    description = payload["description"]
    domain_name = payload["domain_name"]
    content_version = payload["content_version"]
    town = payload["town"]

    puts "name #{name}"
    puts "description #{description}"
    puts "domain_name #{domain_name}"
    puts "content_version #{content_version}"
    puts "town #{town}"

    home = Home.new
    home.town = town
    home.name = name
    home.description = description
    home.domain_name = domain_name
    home.content_version = content_version
    
    unless home.valid?
      error 422, home.errors.messages.to_json
    end

    uuid = SecureRandom.uuid
    puts "uuid #{uuid}"
    $home = {
      uuid: uuid,
      name: name,
      town: town,
      description: description,
      domain_name: domain_name,
      content_version: content_version
    }

    return { uuid: uuid }.to_json
  end

  # READ
  get '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# read - GET /api/homes/:uuid"

    # checks for house limit

    content_type :json
    if params[:uuid] == $home[:uuid]
      return $home.to_json
    else
      error 404, "failed to find home with provided uuid and bearer token"
    end
  end

  # UPDATE
  put '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# update - PUT /api/homes/:uuid"
    begin
      # Parse JSON payload from the request body
      payload = JSON.parse(request.body.read)
    rescue JSON::ParserError
      halt 422, "Malformed JSON"
    end

    # Validate payload data
    name = payload["name"]
    description = payload["description"]
    domain_name = payload["domain_name"]
    content_version = payload["content_version"]

    unless params[:uuid] == $home[:uuid]
      error 404, "failed to find home with provided uuid and bearer token"
    end

    home = Home.new
    home.town = $home[:town]
    home.name = name
    home.description = description
    home.domain_name = domain_name
    home.content_version = content_version

    unless home.valid?
      error 422, home.errors.messages.to_json
    end

    return { uuid: params[:uuid] }.to_json
  end

  # DELETE
  delete '/api/u/:user_uuid/homes/:uuid' do
    ensure_correct_headings
    find_user_by_bearer_token
    puts "# delete - DELETE /api/homes/:uuid"
    content_type :json

    if params[:uuid] != $home[:uuid]
      error 404, "failed to find home with provided uuid and bearer token"
    end

    $home = {}
    { message: "House deleted successfully" }.to_json
  end
end

TerraTownsMockServer.run!

````

:question: So what does the above code do?

This code creates a simple mock server for managing "homes" data, allowing clients to perform CRUD operations on these resources. The server validates input data and responds with appropriate status codes and JSON responses. It's intended for testing and development purposes and doesn't persist data beyond the runtime of the server.

## [Creating a Terraform provider](https://www.hashicorp.com/resources/creating-terraform-provider-for-anything)

### main.go file

The **main.go** file is typically used as the entry point of the application. 

It's where the Go program starts executing. In the context of creating a Terraform provider using Go, main.go may not be directly related to your provider's logic but serves as a way to execute or run your provider.



### .terraformrc file

The `.terraformrc` file is used by Terraform to configure various aspects of Terraform behavior and to set global settings for providers. This file, when present in the user's home directory, can influence how Terraform behaves, including interactions with providers. It's not directly related to the development of a custom Terraform provider in Go; instead, it's a user-specific configuration file.

Here are some key aspects of the `.terraformrc` file and what it does:

1. **Provider Configuration**: You can use the `.terraformrc` file to configure provider settings, such as credentials, access keys, and other provider-specific configuration options. This is especially useful if you want to set provider configurations globally across all Terraform projects.

2. **Authentication**: You can store authentication credentials (e.g., API keys or access tokens) for different providers, and Terraform will automatically use these credentials when interacting with the specified providers. This can make it more convenient for users, as they don't need to specify these credentials in every Terraform project.

3. **Alias Configuration**: You can define provider aliases in the `.terraformrc` file, allowing you to use different provider configurations for the same provider within a single project. This can be useful when dealing with multiple environments (e.g., development, staging, and production) that require different configurations for the same provider.

4. **Plugin Cache Configuration**: The `.terraformrc` file allows you to configure settings related to Terraform's plugin caching, including the cache directory and cache lifetime.

### CRUD

Terraform Provider resources utilize CRUD.

CRUD is as acronym for  Create, Read, Update, Delete 

[More on CRUD](https://en.wikipedia.org/wiki/Create,_read,_update_and_delete)




