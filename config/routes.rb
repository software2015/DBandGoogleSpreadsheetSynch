Rails.application.routes.draw do
	root 'contacts#new_contact'
  post  '/save_contact',    to: 'contacts#save_contact'
end
