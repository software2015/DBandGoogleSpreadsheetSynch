Rails.application.routes.draw do
	root 'contacts#new'
	resources :contacts
end
