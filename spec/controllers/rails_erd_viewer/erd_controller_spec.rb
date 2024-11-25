# frozen_string_literal: true

require 'rails_erd_viewer'

RSpec.describe RailsErdViewer::ErdController, type: :controller do
  describe '#index' do
    it 'assigns @schema' do
      allow(controller).to receive(:fetch_schema).and_return('mocked_schema_data')
      get :index
      expect(assigns(:schema)).to eq('mocked_schema_data')
    end
  end

  describe '#fetch_schema' do
    context 'when schema does not exists' do
      it 'raises error' do
        allow(File).to receive(:exist?).and_return(false)
        expect do
          controller.send(:fetch_schema)
        end.to raise_error(RailsErdViewer::MissingErdSchemaError)
      end
    end

    context 'when schema exists' do
      it 'returns the encoded schema data' do
        schema_file_path = Rails.root.join('tmp/application_schema.sql')

        schema_content = 'CREATE TABLE users (...);'

        allow(File).to receive(:exist?).and_return(true)
        allow(Rails.root).to receive(:join).with('tmp/application_schema.sql').and_return(schema_file_path)
        allow(File).to receive(:read).with(schema_file_path).and_return(schema_content)

        result = controller.send(:fetch_schema)

        expect(result).to eq(Base64.encode64(schema_content))
      end
    end
  end
end
