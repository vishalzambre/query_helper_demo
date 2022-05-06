require 'active_record/connection_adapters/odbc_adapter'
require 'odbc_adapter/adapters/postgresql_odbc_adapter'

ODBCAdapter.register(/snowflake/, ODBCAdapter::Adapters::PostgreSQLODBCAdapter) do
  # Explicitly turning off prepared statements as they are not yet working with
  # snowflake + the ODBC ActiveRecord adapter
  def prepared_statements
    false
  end

  # Quoting needs to be changed for snowflake
  def quote_column_name(name)
    name.to_s
  end

  private

  # Override dbms_type_cast to get the values encoded in UTF-8
  def dbms_type_cast(columns, values)
    values.each do |row|
      row.each_index do |idx|
        row[idx] = row[idx].force_encoding('UTF-8') if row[idx].is_a?(String)
      end
    end
  end
end