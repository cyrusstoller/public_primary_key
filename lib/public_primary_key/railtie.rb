module PublicPrimaryKey
  class Railtie < Rails::Railtie
    initializer "public_primary_key.mixin" do
      ActiveSupport.on_load(:active_record) do
        extend PublicPrimaryKey::ActiveRecordMixin
      end
    end
  end
end
