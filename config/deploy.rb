set :application, "ismailov_net"
set :domain, "ismailov.net"
set :user, "ismailo"

set :repository, "http://svn.ismailov.net/svn/main/trunk/ismailov.net"

set :scm_username, "rustam"
set :scm_password, "binaneura"
set :use_sudo, false                                  # HostingRails users don't have sudo access
set :deploy_to, "/home/#{user}/apps/#{application}"   # Where on the server your app will be deployed
set :deploy_via, :checkout                            # For this tutorial, svn checkout will be the deployment method, but check out :remote_cache in the future
set :group_writable, false                            # By default, Capistrano makes the release group-writable. You don't want this with HostingRails

default_run_options[:pty] = true

role :app, domain
role :web, domain
role :db,  domain, :primary => true