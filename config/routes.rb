Discover::Application.routes.draw do
  devise_for :users
#  mount HesburghErrors::Engine => "/hesburgh_errors"

  if Rails.env.development?
    root to: redirect('/examples')
  else
    root to: redirect('http://library.nd.edu')
  end

  get 'check' => 'health_check#check'

  get 'record' => 'records#show', as: :record, constraints: {id: /.+/}
  get 'online_access' => 'online_access#show', as: 'online_access', constraints: {id: /.+/}
  get 'request' => 'holds#hold_request', constraints: {id: /.+/}
  post 'place_request' => 'holds#place_request', as: 'original_place_request'
  # This route exists so we don't have to do a post request via the discover-place-request.jsp tile in Primo
  get 'place_request_get' => 'holds#place_request', as: 'place_request_get'

  resources :primo_missing_fields, only: [ :index, :show ]

  get 'examples', to: redirect('/examples/ndu'), as: :examples_root
  get 'examples/:institution' => 'examples#index', as: :examples

  get 'utilities/sfx_compare' => 'utilities#sfx_compare'
  post 'utilities/sfx_compare' => 'utilities#sfx_compare'

  get 'demo', to: redirect('/primo_library/libweb/action/search.do?mode=Basic&vid=NDU&vl(freeText0)=test&fn=search&tab=nd_campus')

  get 'primo_library/libweb/tiles/local/discover-details.jsp' => 'records#show', xhr: true
  get 'primo_library/libweb/tiles/local/discover-online-access.jsp' => 'online_access#show', xhr: true
  get 'primo_library/libweb/tiles/local/discover-request.jsp' => 'holds#hold_request', xhr: true
  post 'primo_library/libweb/tiles/local/discover-place-request.jsp' => 'holds#place_request', xhr: true, as: 'place_request'
  get 'primo_library/libweb/*path' => 'primo_proxy#index', as: :proxy
  post 'primo_library/libweb/*path' => 'primo_proxy#index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
