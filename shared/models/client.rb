class Client
  include MongoMapper::Document

  key :client_id, String
  key :private_key, String

  def self.find_by_client_id(client_id)
    client = Client.new()
    client.client_id = "clientpublickey"
    client.private_key = "supersecret"
    client
  end
end