Rails.application.routes.draw do
  scope module: 'chat_box' do
    resources :conversations, only: [:create] do
      member do
        post :close
      end
      resources :messages, only: [:create]
    end
  end
end