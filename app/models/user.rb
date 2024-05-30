require 'csv'

class User
  include Mongoid::Document
  field :name, type: String
  field :email, type: String

  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      user_hash = row.to_hash
      User.create!(user_hash)
    end
  end
end
