# frozen_string_literal: true

module RailsErdViewer
  #  ERDGenerator
  class SchemaGenerator
    def self.generate
      file_path = Rails.root.join('tmp/application_schema.sql')
      File.open(file_path, 'w') do |file|
        ActiveRecord::Base.connection.tables.each do |table_name|
          columns = ActiveRecord::Base.connection.columns(table_name)

          add_table_to_file(file, table_name, columns)

          add_foreign_keys_to_file(file, table_name)
        end
      end
    end

    def self.add_table_to_file(file, table_name, columns)
      file.write "CREATE TABLE #{table_name} (\n"
      add_columns_to_file(file, columns)
      file.write "    PRIMARY KEY (id)\n" if columns.any? { |c| c.name == 'id' }
      file.write ");\n\n"
    end

    def self.add_foreign_keys_to_file(file, table_name)
      foreign_keys = ActiveRecord::Base.connection.foreign_keys(table_name)
      foreign_keys.each do |fk|
        file.write(
          "ALTER TABLE #{fk.from_table} ADD FOREIGN KEY (#{fk.column}) " \
          "REFERENCES #{fk.to_table} (#{fk.primary_key});\n"
        )
      end
    end

    def self.add_columns_to_file(file, columns)
      columns_count = columns.size
      columns.each_with_index do |column, index|
        column_end = index == columns_count - 1 ? '' : ','
        add_column_to_file(file, column, column_end)
      end
    end

    def self.add_column_to_file(file, column, column_end)
      type = get_column_type(column)

      null_constraint = column.null ? '' : ' NOT NULL'
      default_constraint = column.default.nil? ? '' : " DEFAULT #{column.default.inspect}"

      file.write "    #{column.name} #{type}#{null_constraint}#{default_constraint}#{column_end}\n"
    end

    def self.get_column_type(column)
      column_type_map[column.type] || 'unknown'
    end

    def self.column_type_map
      {
        string: 'varchar(255)', text: 'text', integer: 'integer(11)', float: 'float', decimal: 'decimal(10,2)',
        datetime: 'datetime', boolean: 'boolean', date: 'date', time: 'time'
      }
    end
  end
end
