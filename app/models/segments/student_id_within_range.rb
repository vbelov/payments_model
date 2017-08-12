module Segments
  class StudentIdWithinRange < Segment
    segment_attributes do
      attribute :min_id, Integer
      attribute :max_id, Integer
    end

    def contains?(student)
      (min_id..max_id).include?(student.id)
    end
  end
end
