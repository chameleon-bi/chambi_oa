Optimadmin::Engine.routes.draw do
  # Inline editing
  get 'inline-editing/navigation', to: 'inline_editing#navigation'
  get 'inline-editing/edit', to: 'inline_editing#edit'

  # Module actions
  get 'module_actions/reorder'
  get 'edit-images/crop/:model/:id/:image/:version', to: 'edit_images#crop', as: 'cropping'
  post :reorder, to: 'module_actions#reorder', as: 'reorder'
  get :toggle, to: 'module_actions#toggle', as: 'toggle'

  # Session routes
  get :login, to: 'administrator_sessions#new', as: 'login'
  get :logout, to: 'administrator_sessions#destroy', as: 'logout'

  # TinyMCE link list
  get :link_list, to: 'application#link_list', as: 'link_list'

  # Administrators
  resources :password_resets, except: [:show, :index], path: 'reset-password'
  resources :administrator_sessions, only: [:new, :create, :destroy]
  resources :administrators, except: :show do
    collection do
      get 'edit-details', as: 'edit_details', action: 'edit_own_details'
    end
  end

  # Documents and images
  resources :documents do
    collection do
      get 'update_collection'
      post 'upload'
      get 'new_inline'
      post 'create_inline'
    end
  end

  resources :images do
    collection do
      get 'update_collection'
      post 'upload'
      get 'new_inline'
      post 'create_inline'
      get 'tinymce'
    end
  end

  # Navigation
  resources :menu_items, except: :show do
    collection do
      get 'update-link-resources'
      get 'reorder'
      post 'order'
    end
  end
  resources :external_links, except: :show
  resources :site_settings, except: :show
  resources :module_pages

  root to: 'application#index'
end
