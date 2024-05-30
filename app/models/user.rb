require 'csv'

class User
  include Mongoid::Document
  include Mongoid::Timestamps  # Optional, if you want to track created_at and updated_at fields

  field :name, type: String
  field :email, type: String

  # バリデーションの追加
  validates :name, presence: true
  validates :email, presence: true

  def self.import(file)
    errors = []
    CSV.foreach(file.path, headers: true).with_index(1) do |row, index|
      user_hash = row.to_hash
      user = User.new(user_hash)
      unless user.save
        errors << "Row #{index}: #{user.errors.full_messages.join(", ")}"
      end
    end
    { errors: errors }
  end
end
