# Basic model spec
# Inspired by https://gist.github.com/kyletcarlson/6234923

require 'rails_helper'
#  rspec --tag 'image'
module Optimadmin
  RSpec.describe Image, type: :model, image: true do
    describe 'validations', :validation do
      let(:image) { create(:image) }
      it { should validate_presence_of(:name) }
      it { should validate_presence_of(:image) }
    end

    describe 'public instance methods' do
      let(:image) { create(:image) }

      context 'responds to its methods' do
        it { expect(image).to respond_to(:path) }
        it { expect(image).to respond_to(:size) }
        it { expect(image).to respond_to(:url) }
      end

      context 'executes methods correctly' do
        context '#path' do
          it 'returns its path' do
            expect(image.path).to eq(image.image.path)
          end
        end

        context '#size' do
          it 'returns its size' do
            expect(image.size).to eq((image.image.size.to_f / 1000).round(2))
          end
        end

        context '#url' do
          it 'returns its url' do
            expect(image.url).to eq(image.image.url)
          end
        end
      end
    end

    describe 'public class methods' do
      let(:image) { create(:image) }
      let(:page) { create(:page) }

      context 'responds to its methods' do
        it { expect(Optimadmin::Image).to respond_to(:store_image) }
      end

      context 'executes methods correctly' do
        context 'self.store_file' do
          it 'creates new image' do
            expect(Optimadmin::Image.store_image(page, image.image)).to eq(true)
          end
        end
      end
    end
  end
end
