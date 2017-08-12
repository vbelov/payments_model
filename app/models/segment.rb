class Segment < ApplicationRecord
  class SegmentData
    include Virtus.model

    def self.dump(data)
      data.to_hash
    end

    def self.load(data)
      new(data)
    end

    def inspect_arrays?
      true
    end
  end

  def self.segment_attributes(&block)
    klass = Class.new(SegmentData)
    klass.class_eval(&block)
    const_set('Data', klass)
    serialize :data, klass

    klass.attribute_set.each do |attribute|
      name = attribute.name
      define_method(name) { data.send(name) }
      define_method("#{name}=") { |val| data.send("#{name}=", val) }
    end
  end
end
