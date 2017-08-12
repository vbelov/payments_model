RSpec.describe Segments::StudentIdWithinRange, type: :model do
  let(:subject) { described_class.create!(min_id: 10, max_id: 20) }
  let(:student_within_range) { create(:student, id: 15) }
  let(:student_outside_of_range) { create(:student, id: 30) }

  it { is_expected.to contain(student_within_range) }
  it { is_expected.not_to contain(student_outside_of_range) }
end
