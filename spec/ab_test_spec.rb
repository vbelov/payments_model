RSpec.describe AbTest, type: :model do
  let(:test) { create(:ab_test, groups_count: 2) }

  describe '#groups' do
    it 'возвращает список возможных групп AB-теста' do
      expect(test.groups).to eq(%w(a b))
    end
  end

  describe '#next_group' do
    it 'возвращает группу, в которую должен вступить следующий участник AB-теста' do
      6.times { |idx| expect(test.next_group).to eq(idx.even? ? 'a' : 'b') }
    end
  end
end
