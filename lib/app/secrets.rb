class Secrets < Settingslogic
  source "#{Rails.root}/config/secrets.yml"
  suppress_errors Rails.env.production?
end
