require 'spec_helper'
require 'vcr'
require './lib/smarty_streets_api'

RSpec.describe SmartyStreetsApi do
  describe 'happy path' do
    it 'will successfully get a response from the Smarty Streets API', :vcr do
      returned_address = SmartyStreetsApi.confirm_address('143 e Maine Street', 'Columbus', '43215')

      expect(returned_address).to be_an Array

      expect(returned_address[0][:delivery_line_1]).to eq('143 E Main St')
      expect(returned_address[0][:last_line]).to eq('Columbus OH 43215-5370')
    end
  end

  describe 'sad path' do
    it "will respond with an empty array when the address does not exist", :vcr do
      response = SmartyStreetsApi.confirm_address('1 Empora St', 'Title', '11111')

      expect(response).to eq([])
    end

    describe 'error handling' do
      it 'handles a connection error' do
        allow(SmartyStreetsApi).to receive(:conn).and_raise(Faraday::ConnectionFailed.new('Could not connect'))

        expect { SmartyStreetsApi.confirm_address('123 Main St', 'Anytown', '12345') }.to raise_error(Faraday::ConnectionFailed)
      end

      it 'handles a timeout error' do
        allow(SmartyStreetsApi).to receive(:conn).and_raise(Faraday::TimeoutError.new('Request timed out'))

        expect { SmartyStreetsApi.confirm_address('123 Main St', 'Anytown', '12345') }.to raise_error(Faraday::TimeoutError)
      end

      it 'handles an invalid JSON response' do
        allow_any_instance_of(Faraday::Response).to receive(:body).and_return('{"foo": "bar"') # Invalid JSON response

        expect { SmartyStreetsApi.confirm_address('123 Main St', 'Anytown', '12345') }.to raise_error(JSON::ParserError)
      end

      it 'handles 401 Unauthorized error for bad credentials correctly', :vcr do
        allow(ENV).to receive(:[]).and_call_original
        allow(ENV).to receive(:[]).with('SMARTY_AUTH_ID').and_return('invalid_id')
        allow(ENV).to receive(:[]).with('SMARTY_AUTH_TOKEN').and_return('invalid_token')

        expect { SmartyStreetsApi.confirm_address('123 Main St', 'Anytown', '12345') }.to raise_error(Faraday::UnauthorizedError) do |error|
          expect(error.response[:status]).to eq(401)
        end
      end

      it 'handles 402 Payment Required error' do
        allow(SmartyStreetsApi).to receive(:confirm_address).and_raise(Faraday::ClientError.new('Payment Required'))

        expect { SmartyStreetsApi.confirm_address('123 Main St', 'Anytown', '12345') }.to raise_error(Faraday::ClientError, 'Payment Required')
      end

      it 'handles 413 Request Entity Too Large error' do
        allow(SmartyStreetsApi).to receive(:confirm_address).and_raise(Faraday::ClientError.new('Request Entity Too Large'))

        expect { SmartyStreetsApi.confirm_address('123 Main St', 'Anytown', '12345') }.to raise_error(Faraday::ClientError, 'Request Entity Too Large')
      end

      it 'handles 400 Bad Request (Malformed Payload) error' do
        allow(SmartyStreetsApi).to receive(:confirm_address).and_raise(Faraday::BadRequestError.new('Bad Reqeust (Malformed Payload)'))

        expect { SmartyStreetsApi.confirm_address('123 Main St', 'Anytown', '12345') }.to raise_error(Faraday::BadRequestError, 'Bad Reqeust (Malformed Payload)')
      end

      it 'handles 429 Too Many Requests error' do
        allow(SmartyStreetsApi).to receive(:confirm_address).and_raise(Faraday::ClientError.new('Payment Required'))

        expect { SmartyStreetsApi.confirm_address('123 Main St', 'Anytown', '12345') }.to raise_error(Faraday::ClientError, 'Payment Required')
      end

      it 'handles a 500 server error' do
        allow(SmartyStreetsApi).to receive(:confirm_address).and_raise(Faraday::ServerError.new('Server error'))

        expect { SmartyStreetsApi.confirm_address('123 Main St', 'Anytown', '12345') }.to raise_error(Faraday::ServerError, 'Server error')
      end
    end
  end
end