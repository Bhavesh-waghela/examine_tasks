Rails.application.routes.draw do
  resources :options
  get 'home/index'
  ActiveAdmin.routes(self)
  resources :answers
  resources :questions
  resources :users
  root "home#index"
  post 'begin_test', :controller => "home"
  post 'create_user_answers', :controller => "home"
  get 'show_question/:question_id/', to: 'home#show_question', as: :show_question
  get 'final_evaluation', :controller => "home"
  get 'generate_users_xlsx_file', :controller => "home"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
