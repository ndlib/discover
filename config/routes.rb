Discover::Application.routes.draw do
  devise_for :users
  mount HesburghErrors::Engine => "/hesburgh_errors"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'records#show', id: "ndu_aleph000188916"

  get 'check' => 'health_check#check'

  get 'record' => 'records#show', as: :record, constraints: {id: /.+/}
  get 'online_access' => 'online_access#show', as: 'online_access', constraints: {id: /.+/}

  get 'holds' => 'holds#volumns', constraints: {id: /.+/}
  get 'step1' => 'holds#volumns', constraints: {id: /.+/}
  get 'step2' => 'holds#institutions', constraints: {id: /.+/}
  get 'step3' => 'holds#pickup', constraints:  {id: /.+/}
  get 'step4' => 'holds#finalize', constraints:  {id: /.+/}
  get 'submit' => 'holds#submit', constraints:  {id: /.+/}

  resources :primo_missing_fields, only: [ :index, :show ]

  get 'examples', to: redirect('/examples/ndu'), as: :examples_root
  get 'examples/:institution' => 'examples#index', as: :examples

  get 'utilities/sfx_compare' => 'utilities#sfx_compare'
  post 'utilities/sfx_compare' => 'utilities#sfx_compare'

  get 'demo', to: redirect('/primo_library/libweb/action/search.do?mode=Basic&vid=NDU&vl(freeText0)=test&fn=search&tab=nd_campus')

  get 'primo_library/libweb/tiles/local/discover-details.jsp' => 'records#show', xhr: true
  get 'primo_library/libweb/tiles/local/discover-online-access.jsp' => 'online_access#show', xhr: true
  get 'primo_library/libweb/*path' => 'primo_proxy#index', as: :proxy
  post 'primo_library/libweb/*path' => 'primo_proxy#index'

end
