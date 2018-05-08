Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, '15374538248-sskjollg5hgkp1dr1vfdoq55c1nq62q2.apps.googleusercontent.com', 'O8UfZRIKxd-zLiK-JfvwcT3l'
end