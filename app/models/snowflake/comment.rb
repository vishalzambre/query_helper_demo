module Snowflake
  class Comment < Snowflake::ApplicationRecord
    self.primary_key = :id
    belongs_to :post, class_name: 'Snowflake::Post', foreign_key: :post_id
  end
end
