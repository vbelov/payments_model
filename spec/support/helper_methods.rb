module HelperMethods
  def math_product
    Product.find_by_code('math')
  end

  def english_product
    Product.find_by_code('english')
  end

  def count_on_the_fly
    Product.find_by_code('count_on_the_fly')
  end

  def year_period
    SubscriptionPeriod.find_by_code('year')
  end

  def unlimited_period
    SubscriptionPeriod.find_by_code('unlimited')
  end

  def create_matching_student(segment)
    create(:student,
           region_id: segment.region_ids.any? ? segment.region_ids.sample : 1,
           level: segment.levels.any? ? segment.levels.sample : 1,
           b2what: segment.b2what || 'b2t'
    )
  end

  def create_non_matching_student(segment)
    create(:student, region_id: 1000, level: 1000)
  end
end

RSpec.configure do |c|
  c.include HelperMethods
end
