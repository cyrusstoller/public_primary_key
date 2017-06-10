require "active_record"

ActiveRecord::Schema.define do
  create_table :posts, force: true do |t|
    t.string :uuid
  end
end

class Post < ActiveRecord::Base
  extend PublicPrimaryKey::ActiveRecordMixin

  STRING_LENGTH = 7

  public_primary_key :uuid, generator: :urlsafe_base64, length: STRING_LENGTH
end
