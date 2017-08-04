RSpec.describe Subject, type: :model do
  describe '#all' do
    it 'возвращает список всех предметов' do
      subjects = Subject.all
      expect(subjects.count).to eq(4)

      subject = subjects.first
      expect(subject).to be_an_instance_of(Subject)
      expect(subject.code).to eq('math')
      expect(subject.name).to eq('Математика')
    end
  end
end
