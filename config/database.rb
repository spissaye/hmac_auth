mongo_conf = YAML::load_file('db/mongo.yml')[PADRINO_ENV]

MongoMapper.connection = Mongo::Connection.new(mongo_conf['host'], mongo_conf['port'], :logger => logger)

case Padrino.env
  when :development then MongoMapper.database = 'hmac_auth_api_development'
  when :production  then MongoMapper.database = 'hmac_auth_api_production'
  when :test        then MongoMapper.database = 'hmac_auth_api_test'
end