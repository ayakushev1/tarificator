Tarificator::Application.routes.draw do

  root to: 'home#index', via: :get

  namespace :admin do

    namespace :authority do
      controller :user_authorities do
        get 'search_user_authorities' => :search_user_authorities
        get 'user_authorities/:id/set_user_authority' => :set_user_authority, as: :set_user_authority
        post 'user_authorities/:id/update_user_authority' => :update_user_authority, as: :update_user_authority
      end

      controller :url_access_authorities do
        get 'url_access_authorities' => :set_url_access_authorities#, as: :set_url_access_authorities
        get 'url_access_authorities/init_url_access_authority' => :init_url_access_authorities, as: :init_url_access_authorities
        get 'url_access_authorities/new_url_access_authority' => :new_url_access_authority, as: :new_url_access_authority
        get 'url_access_authorities/create_url_access_authority' => :create_url_access_authority, as: :create_url_access_authority
        get 'url_access_authorities/:id/edit_url_access_authority' => :edit_url_access_authority, as: :edit_url_access_authority
        get 'url_access_authorities/:id/update_url_access_authority' => :update_url_access_authority, as: :update_url_access_authority
        get 'url_access_authorities/:id/delete_url_access_authority' => :delete_url_access_authority, as: :delete_url_access_authority
#        post 'url_access_authorities/:id/update_url_access_authority' => :update_url_access_authority, as: :update_url_access_authority
      end
    end
  end

  
  get "home/index"
  get "home/top_secret"
  
  controller :sessions do
    get  'login' => :new
    get 'submit_login' => :create
    get 'logout' => :destroy
  end
  
  resources :users
end
