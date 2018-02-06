# Basic model spec
# Inspired by https://gist.github.com/kyletcarlson/6234923

require 'rails_helper'
#  rspec --tag 'document'
module Optimadmin
  RSpec.describe Document, type: :model, document: true do
    describe 'validations', :validation do
      let(:document) { create(:document) }
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:document) }
    end

    describe 'public instance methods' do
      let(:document) { create(:document) }

      context 'responds to its methods' do
        it { expect(document).to respond_to(:path) }
        it { expect(document).to respond_to(:size) }
        it { expect(document).to respond_to(:url) }
      end

      context 'executes methods correctly' do
        context '#path' do
          it 'returns its path' do
            expect(document.path).to eq(document.document.path)
          end
        end

        context '#size' do
          it 'returns its size' do
            expect(document.size).to eq((document.document.size.to_f / 1000).round(2))
          end
        end

        context '#url' do
          it 'returns its url' do
            expect(document.url).to eq(document.document.url)
          end
        end
      end
    end

    describe 'public class methods' do
      let(:document) { create(:document) }
      let(:page) { create(:page) }

      context 'responds to its methods' do
        it { expect(Optimadmin::Document).to respond_to(:store_file) }
      end

      context 'executes methods correctly' do
        context 'self.store_file' do
          it 'creates new document' do
            expect(Optimadmin::Document.store_file(page, document.document)).to eq(true)
          end
        end
      end
    end
  end
end
