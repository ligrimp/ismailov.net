load 'deploy' if respond_to?(:namespace) # cap2 differentiator
load 'config/deploy'

namespace :deploy do

  task :start, :roles => :app do
    run "touch /home/ismailo/apps/graphium/current/tmp/restart.txt"
  end

  task :restart, :roles => :app do
    run "touch /home/ismailo/apps/graphium/current/tmp/restart.txt"
  end

  task :after_symlink, :roles => :app do
    run "rm -rf ~/public_html/404.html  ~/public_html/422.html  ~/public_html/500.html  ~/public_html/favicon.ico  ~/public_html/images/  ~/public_html/javascripts/  ~/public_html/robots.txt  ~/public_html/stylesheets/;cp -r /home/ismailo/apps/ismailov_net/current/public/*.html /home/ismailo/apps/ismailov_net/current/public/favicon.ico  /home/ismailo/apps/ismailov_net/current/public/images  /home/ismailo/apps/ismailov_net/current/public/javascripts  /home/ismailo/apps/ismailov_net/current/public/robots.txt  /home/ismailo/apps/ismailov_net/current/public/stylesheets  ~/public_html"
  end

end