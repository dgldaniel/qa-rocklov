require 'mongo'

Mongo::Logger.logger = Logger.new('./logs/mongo.log')

# manager Mongo DB
class MongoDB
  attr_accessor :users, :equipos

  def initialize
    client = Mongo::Client.new('mongodb://localhost:27017/rocklov')

    @users = client[:users]
    @equipos = client[:equipos]
  end

  def remove_user(email)
    @users.delete_many({ email: email })
  end

  def get_user(email)
    user = @users.find({ email: email }).first

    user[:_id]
  end

  def remove_equipo(nome, email)
    user_id = get_user(email)
    @equipos.delete_many({ name: nome, user: user_id })
  end
end
