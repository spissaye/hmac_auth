class HmacAuth < Padrino::Application
  register Padrino::Rendering
  register Padrino::Mailer
  register Padrino::Helpers
  register Padrino::Cache
  register CompassInitializer

  use HMACAuth::Middleware

  #loads /config/*.const.yml and assigns ENV-specific data into a constant based on file name
  def self.load_configs
    paths = Dir.glob(File.join(Padrino.root, "config", "*.const.yml"))
    paths.each do |path|
      module_eval <<-code
        ::#{ path.split("/").last.split(".").first.upcase } = YAML::load_file(path)[PADRINO_ENV]
      code
    end
  end

  self.load_configs

  configure do
    set :send_emails, true
    set :haml, :ugly => true
    disable :show_exceptions, :dump_errors, :raise_errors
  end

  configure :development do
    enable :reload
    set :haml, :ugly => false
    set :send_emails, false
    enable :show_exceptions, :dump_errors, :raise_errors
  end

  configure :test do
    set :send_emails, false
    enable :show_exceptions, :dump_errors, :raise_errors
  end

  configure :staging do
    set :send_emails, true
    set :ssl_required, true
  end
end