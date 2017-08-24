class AbTest < ApplicationRecord
  belongs_to :segment

  mattr_accessor(:possible_groups) { ('a'..'z').to_a }

  def groups
    possible_groups.take(groups_count)
  end

  def next_group
    with_lock do
      participants = groups.map { |g| [g, 0] }.to_h.merge(self.participants)
      group = participants.to_a.min_by(&:last).first
      participants[group] += 1
      update!(participants: participants)

      group
    end
  end
end
