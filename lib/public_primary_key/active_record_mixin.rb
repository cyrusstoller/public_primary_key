require "active_record"
require "securerandom"

module PublicPrimaryKey::ActiveRecordMixin
  extend ActiveSupport::Concern

  def public_primary_key(column_name, opts = {})
    before_validation on: :create do
      length = opts[:length] || 10
      generator = opts[:generator] || "urlsafe_base64"
      new_id = SecureRandom.send(generator, length)
      eval "self.#{column_name} = '#{new_id}'"
    end

    validates_uniqueness_of column_name
    validates_presence_of column_name
    validates_format_of column_name, :with => /\A[\w-]+\z/, :message => "cannot have whitespace"

    class_eval do
      eval %{
        def to_param
          self.#{column_name}
        end
      }
    end
  end
end
