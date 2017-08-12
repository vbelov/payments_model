RSpec.describe Segment, type: :model do
  describe 'custom segment class' do
    let(:klass) do
      klass = Class.new(Segment) do
        segment_attributes do
          attribute :amount, Integer
        end
      end
      name = "#{Faker::Lorem.word}_segment".classify
      Segments.const_set(name, klass)
      klass
    end

    let(:amount) { rand(100) }
    let(:new_amount) { rand(100) }
    let(:segment) { klass.create!(amount: amount) }

    it 'defines custom attribute getters' do
      expect(segment.amount).to eq(amount)
    end

    it 'defines custom attribute setters' do
      segment.update!(amount: new_amount)
      expect(segment.reload.amount).to eq(new_amount)
    end
  end
end
