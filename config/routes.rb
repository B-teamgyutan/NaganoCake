Rails.application.routes.draw do
  namespace :public do
    get 'cart_items/index'
  end
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  scope module: :public do
    root :to =>"homes#top"
    get '/about' => 'homes#about'
    resources :orders, only: [:new, :index, :create, :show] do
      collection do
        get 'thanks'
        post 'confirm'
      end
    end
    resources :cart_items, only: [:index, :create, :update, :destroy] do
      collection do
        delete 'destroy_all'
      end
    end
    resources :addresses, except: [:new, :show]
  end

  devise_scope :customer do
  get '/customers/sign_out', to: 'public/sessions#destroy'
end


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    get '/' => 'homes#top'
    resources :items, except: [:destroy]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end
end