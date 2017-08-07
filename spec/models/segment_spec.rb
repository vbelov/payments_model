RSpec.describe Segment, type: :model do
  describe '#contains?' do
    let(:segment) { create(:segment, region_ids: [1, 2], b2what: 'b2t', levels: [1, 2]) }

    context 'если все подходит' do
      let(:student) { create(:student, region_id: 1, b2what: 'b2t', level: 2) }

      it 'возвращает true' do
        expect(segment.contains?(student)).to be true
      end
    end

    context 'если не подходит регион' do
      let(:student) { create(:student, region_id: 3, b2what: 'b2t', level: 2) }

      it 'возвращает false' do
        expect(segment.contains?(student)).to be false
      end
    end

    context 'если не подходит класс' do
      let(:student) { create(:student, region_id: 1, b2what: 'b2t', level: 3) }

      it 'возвращает false' do
        expect(segment.contains?(student)).to be false
      end
    end

    context 'если не подходит b2what' do
      let(:student) { create(:student, region_id: 1, b2what: 'b2c', level: 2) }

      it 'возвращает false' do
        expect(segment.contains?(student)).to be false
      end
    end
  end
end
