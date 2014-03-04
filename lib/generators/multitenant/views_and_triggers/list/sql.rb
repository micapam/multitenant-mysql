module Multitenant
  module SQL
    VIEWS = "SELECT TABLE_NAME FROM information_schema.`TABLES` WHERE TABLE_TYPE LIKE 'VIEW' AND TABLE_SCHEMA LIKE '#{Multitenant::Mysql::DB.configs['database']}';"
    TRIGGERS = "SELECT trigger_name FROM information_schema.TRIGGERS where trigger_schema = '#{Multitenant::Mysql::DB.configs['database']}';"

    mattr_accessor :username_suffix

    def self.tenant_sql_fragment
      "SUBSTRING_INDEX(USER(), '#{username_suffix}@', 1)"
    end
  end
end
