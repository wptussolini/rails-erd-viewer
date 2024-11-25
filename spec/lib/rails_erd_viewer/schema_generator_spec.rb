# frozen_string_literal: true

RSpec.describe RailsErdViewer::SchemaGenerator do
  let(:file) { StringIO.new }

  describe '.generate' do
    it 'writes the full schema to the file' do
      described_class.generate
      content = File.read('spec/dummy/tmp/application_schema.sql')
      expect(content).to include('CREATE TABLE')
      expect(content).to match(/id integer\(11\) NOT NULL/)
      expect(content).to match(/title varchar\(255\) NOT NULL/)
      expect(content).to match(/summary text/)
      expect(content).to match(/PRIMARY KEY \(id\)/)
    end
  end

  describe '.add_table_to_file' do
    let(:columns) do
      [
        instance_double(ActiveRecord::ConnectionAdapters::Column, name: 'id', type: :integer, null: false,
                                                                  default: nil),
        instance_double(ActiveRecord::ConnectionAdapters::Column, name: 'name', type: :string, null: false,
                                                                  default: nil),
        instance_double(ActiveRecord::ConnectionAdapters::Column, name: 'email', type: :string, null: true,
                                                                  default: nil)
      ]
    end

    it 'writes table structure with columns and primary key' do
      described_class.add_table_to_file(file, 'users', columns)
      expect(file.string).to include('CREATE TABLE users (')
      expect(file.string).to include('id integer(11) NOT NULL')
      expect(file.string).to include('name varchar(255) NOT NULL')
      expect(file.string).to include('email varchar(255)')
      expect(file.string).to include('PRIMARY KEY (id)')
    end
  end

  describe '.add_foreign_keys_to_file' do
    let(:foreign_key) do
      instance_double(ActiveRecord::ConnectionAdapters::ForeignKeyDefinition,
                      from_table: 'orders', column: 'user_id', to_table: 'users', primary_key: 'id')
    end

    before do
      allow(ActiveRecord::Base.connection).to receive(:foreign_keys).with('orders').and_return([foreign_key])
    end

    it 'writes foreign key constraints correctly' do
      described_class.add_foreign_keys_to_file(file, 'orders')
      expect(file.string).to include('ALTER TABLE orders ADD FOREIGN KEY (user_id) REFERENCES users (id);')
    end
  end

  describe '.add_columns_to_file' do
    let(:columns) do
      [
        instance_double(ActiveRecord::ConnectionAdapters::Column, name: 'id', type: :integer, null: false,
                                                                  default: nil),
        instance_double(ActiveRecord::ConnectionAdapters::Column, name: 'title', type: :string, null: false,
                                                                  default: nil),
        instance_double(ActiveRecord::ConnectionAdapters::Column, name: 'description', type: :text, null: true,
                                                                  default: nil)
      ]
    end

    it 'writes columns with correct types and constraints' do
      described_class.add_columns_to_file(file, columns)
      expect(file.string).to include('id integer(11) NOT NULL,')
      expect(file.string).to include('title varchar(255) NOT NULL,')
      expect(file.string).to include('description text')
    end
  end

  describe '.add_column_to_file' do
    context 'when column has NOT NULL constraint' do
      it 'writes column definition without default value' do
        column = instance_double(ActiveRecord::ConnectionAdapters::Column, name: 'title', type: :string, null: false,
                                                                           default: nil)
        described_class.add_column_to_file(file, column, ',')
        expect(file.string).to include('title varchar(255) NOT NULL,')
      end
    end

    context 'when column has a default value' do
      it 'writes column definition with default value' do
        column = instance_double(
          ActiveRecord::ConnectionAdapters::Column, name: 'status', type: :string, null: false, default: 'active'
        )
        described_class.add_column_to_file(file, column, ',')
        expect(file.string).to include('status varchar(255) NOT NULL DEFAULT "active",')
      end
    end
  end

  describe '.get_column_type' do
    it 'returns correct SQL type for supported ActiveRecord types' do
      integer_column = instance_double(
        ActiveRecord::ConnectionAdapters::Column, type: :integer
      )
      text_column = instance_double(
        ActiveRecord::ConnectionAdapters::Column, type: :text
      )
      expect(described_class.get_column_type(integer_column)).to eq('integer(11)')
      expect(described_class.get_column_type(text_column)).to eq('text')
    end

    it 'returns "unknown" for unsupported types' do
      unknown_column = instance_double(
        ActiveRecord::ConnectionAdapters::Column, type: :unknown
      )
      expect(described_class.get_column_type(unknown_column)).to eq('unknown')
    end
  end

  describe '.column_type_map' do
    it 'provides correct type mapping for supported ActiveRecord types' do
      expected_result = {
        string: 'varchar(255)',
        text: 'text',
        integer: 'integer(11)',
        float: 'float',
        decimal: 'decimal(10,2)',
        datetime: 'datetime',
        boolean: 'boolean',
        date: 'date',
        time: 'time'
      }
      expect(described_class.column_type_map).to eq(expected_result)
    end
  end
end
