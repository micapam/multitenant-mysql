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

        def establish_connection_for tenant_name
          config = configs
          username = "#{tenant_name}#{Multitenant::SQL.username_suffix}"
          config['username'] = tenant_name.blank? ? 'root' : username
          ActiveRecord::Base.establish_connection(config)
        end

        def connection
          ActiveRecord::Base.connection
        end
      end
    end
  end
end
