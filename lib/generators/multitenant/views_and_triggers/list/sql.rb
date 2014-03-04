module Multitenant
  module SQL
    VIEWS = "SELECT TABLE_NAME FROM information_schema.`TABLES` WHERE TABLE_TYPE LIKE 'VIEW' AND TABLE_SCHEMA LIKE '#{Multitenant::Mysql::DB.configs['database']}';"
    TRIGGERS = "SELECT trigger_name FROM information_schema.TRIGGERS where trigger_schema = '#{Multitenant::Mysql::DB.configs['database']}';"

    mattr_writer :tenant_sql_fragment

    def self.tenant_sql_fragment
      @@tenant_sql_fragment ||= 'SUBSTRING_INDEX(USER(), \'@\', 1)'
    end
  end
end
