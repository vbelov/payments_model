module Segments
  class SimpleSegment < Segment
    segment_attributes do
      attribute :region_ids, Array[Integer]
      attribute :b2what, String
      attribute :levels, Array[Integer]
      attribute :payments, Integer
      attribute :trials_count, Integer
    end


    def contains?(student)
      matches_region?(student) && matches_b2what?(student) && matches_level?(student)
    end

    def matches_region?(student)
      region_ids.blank? || region_ids.include?(student.region_id)
    end

    def matches_b2what?(student)
      (!b2what || b2what.include?(student.b2what))
    end

    def matches_level?(student)
      levels.blank? || levels.include?(student.level)
    end
  end
end
