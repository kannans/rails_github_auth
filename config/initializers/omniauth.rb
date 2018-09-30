opts = { scope: "user:email" }

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :github, Rails.application.credentials.github_client_id, Rails.application.credentials.github_client_secret, opts
end