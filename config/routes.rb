Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "relevant_prompts#index"
  get 'search_prompts', to: 'relevant_prompts#search_prompts'
  # Defines the root path route ("/")
  # root "articles#index"
end
