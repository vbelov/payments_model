RSpec::Matchers.define :contain do |expected|
  match do |actual|
    actual.contains?(expected)
  end
end
