ChatBox::Engine.routes.draw do
  # scope module: 'chat_box' do
    resources :conversations, only: [:create] do
      get :group_modal, on: :collection
      member do
        post :close
      end
      resources :messages, only: [:create]
    end
  # end
end