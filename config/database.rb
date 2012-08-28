MongoMapper.connection = Mongo::Connection.new('localhost', nil, :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'hmac_auth_development'
  when :production  then MongoMapper.database = 'hmac_auth_production'
  when :test        then MongoMapper.database = 'hmac_auth_test'
end
