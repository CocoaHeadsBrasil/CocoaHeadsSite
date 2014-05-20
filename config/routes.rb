Cocoaheads::Application.routes.draw do

  root 'home#index'

  get 'cupertino' => "access#index"
  
  match '/agendas', :to => 'agendas#ativas', :via => :get
  match '/cidades', :to => 'cidades#todas', :via => :get
  match '/videos', :to => 'videos#todos', :via => :get
  match '/fotos', :to => 'fotos#todos', :via => :get
  match '/podcasts/itunes.rss', :controller => 'videos', :action => 'itunes', :format => 'rss', :via => :get
  scope '/cupertino' do
    resources :agendas, :cidades, :fotos, :videos, :palestrantes, :posts, :contents, :faq_groups, :downloads, :faqs
  end
  
  get '/fotos/albuns/:id', :to => 'fotos#public', :via => [:get]
  
  resources :admin_users do
    member do
      get :upload_avatar
      get :persist_avatar
    end
  end

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
