Cocoaheads::Application.routes.draw do

  resources :fotos

  # get 'fotos/(:nome)', :to => 'fotos#public'
  get '/fotos/albuns/:id', :to => 'fotos#public', :via => [:get]

  resources :videos

  resources :palestrantes

  resources :cidades

  resources :agendas do
    collection do
      get 'export/:id', :action => :export, :as => 'export'
    end
  end

  root 'home#index'

  get 'cupertino' => "access#index"

  resources :admin_users do
    member do
      get :upload_avatar
      get :persist_avatar
    end
  end

  get 'tags/:tag', to: 'posts#index', as: :tag

  resources :posts

  resources :contents

  resources :faq_groups

  resources :faqs

  resources :subscriptions do
    member do
      get :delete # for some reason, rails left delete out of the crud (security probally)
    end
  end

  match ':controller(/:action(/:id))', :via => [:get, :post]

  get 'questions', :to => 'faq_groups#public'
  match 'questions/:id/useful/:state', :to => 'faqs#useful', :via => [:get, :post]
  
  match "/500", :to => "errors#error500", :via => [:get, :post]
  match "/404", :to => "errors#error404", :via => [:get, :post]
  get ':permalink', :to => 'contents#public'



end
