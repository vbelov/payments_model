class Subject
  include Virtus.model

  attribute :code, String
  attribute :name, String

  class << self
    def all
      return @all if @all

      country_code = 'russia' # read from env
      hash = YAML.load_file("config/countries/#{country_code}/subjects.yaml")
      @all = hash['subjects'].map do |subject_hash|
        Subject.new(subject_hash)
      end
    end

    def find_by_code(code)
      all.find { |s| s.code == code }
    end
  end
end
