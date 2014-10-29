module Multitenant
  module Mysql
    class DB
      class << self
        def configs
          @configs ||= Rails.configuration.database_configuration[Rails.env]
        end

        def configs=(configs)
          @configs = configs
        end

        def establish_connection_for(tenant_name, tenant_password=nil)
          @current_tenant_name = tenant_name
          config = configs
          username = "#{tenant_name}#{Multitenant::SQL.username_suffix}"
          config['username'] = tenant_name.blank? ? 'root' : username
          config['password'] = tenant_password if tenant_password.present?

          ActiveRecord::Base.establish_connection(config)
        end

        def connection
          ActiveRecord::Base.connection
        end

        def current_tenant_name
          @current_tenant_name
        end
      end
    end
  end
end
