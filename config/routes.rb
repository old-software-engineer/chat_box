ChatBox::Engine.routes.draw do
  # scope module: 'chat_box' do
    resources :conversations, only: [:create] do
      collection do
      	get :group_modal
      	post :create_group
      end
      member do
        post :close
      end
      resources :messages, only: [:create]
    end
  # end
end