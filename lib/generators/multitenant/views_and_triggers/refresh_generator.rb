require 'rails/generators'

require_relative '../views/sql/create'
require_relative '../views/sql/drop'
require_relative '../triggers/sql/create'
require_relative '../triggers/sql/drop'

module Multitenant
  module ViewsAndTriggers
    class RefreshGenerator < Rails::Generators::Base
      desc "drops all views and triggers and creates new ones based on configs"

      def generate_mysql_views
        Multitenant::Mysql.configs.models.each do |m|

          # 'column_names' are set on first call; we are accessing it for each
          # model so the values are available after dropping the views - because
          # it will no longer be possible to look up the columns for each view.
          m.constantize.column_names
        end
        Multitenant::Views::SQL::Drop.run
        Multitenant::Views::SQL::Create.run
      end

      def generate_mysql_triggers
        Multitenant::Triggers::SQL::Drop.run
        Multitenant::Triggers::SQL::Create.run
      end
    end
  end
end
