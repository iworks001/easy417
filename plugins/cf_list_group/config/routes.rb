RedmineApp::Application.routes.draw do
  resources :cf_groups, except: [:show]
end
