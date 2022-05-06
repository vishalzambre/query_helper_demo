module Snowflake
  class Post < Snowflake::ApplicationRecord
    self.primary_key = :id
    has_many :comments, class_name: 'Snowflake::Comment', foreign_key: :post_id
  end
end
