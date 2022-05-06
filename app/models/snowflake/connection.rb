module Snowflake
  class Connection
    include Singleton

    attr_reader :connection

    def initialize
      @connection = Sequel.odbc('PredictDbAds', max_connections: 5)
    end

    def run(sql)
      puts sql
      connection.run(sql)
    end
  end
end
