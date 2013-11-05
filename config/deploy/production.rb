set :stage, :production
set :rails_env, :production

role :app, %w{deploy@eniv.co}
role :web, %w{deploy@eniv.co}
role :db,  %w{deploy@eniv.co}
