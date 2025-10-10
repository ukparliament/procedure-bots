Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  
  mount LibraryDesign::Engine => "/library_design"

  # Defines the root path route ("/")
  root 'home#index', as: :root
  root 'home#index', as: :home
  
  get 'made-n-laid' => 'made_n_laid#index', as: :made_n_laid_list
  get 'made-n-laid/not-posted-to-bluesky' => 'made_n_laid#not_posted_to_bluesky', as: :made_n_laid_not_posted_to_bluesky
  get 'made-n-laid/not-posted-to-mastodon' => 'made_n_laid#not_posted_to_mastodon', as: :made_n_laid_not_posted_to_mastodon
  
  get 'tweaty-twacker' => 'tweaty_twacker#index', as: :tweaty_twacker_list
  get 'tweaty-twacker/not-posted-to-bluesky' => 'tweaty_twacker#not_posted_to_bluesky', as: :tweaty_twacker_not_posted_to_bluesky
  get 'tweaty-twacker/not-posted-to-mastodon' => 'tweaty_twacker#not_posted_to_mastodon', as: :tweaty_twacker_not_posted_to_mastodon
  
  get 'meta' => 'meta#index', as: :meta_list
  get 'meta/cookies' => 'meta#cookies', as: :meta_cookies
end
