class Storage
  cattr_accessor :fog

  Fog.credentials_path = Rails.root.join('.fog')
  @@fog = Fog::Storage.new({provider: Settings.fog.provider})

  def self.create_directory(path)
    @@fog.directories.create(
        key: File.join(Settings.fog.root_directory, path),
        public: true
      )
  end
end

