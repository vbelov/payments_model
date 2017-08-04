module AwesomeVirtus
  def self.included(base)
    base.send :alias_method, :cast_without_awesome_virtus, :cast
    base.send :alias_method, :cast, :cast_with_awesome_virtus
  end

  def cast_with_awesome_virtus(object, type)
    if object.is_a?(Virtus::Model::Core)
      :virtus_model_instance
    elsif object.is_a?(Class) && object.ancestors.include?(Virtus::Model::Core)
      :virtus_model_class
    else
      cast_without_awesome_virtus(object, type)
    end
  end

  private

  def awesome_virtus_model_instance(object)
    return object.inspect if !defined?(::ActiveSupport::OrderedHash)
    return awesome_object(object) if @options[:raw]

    data = object.instance_variables.inject(::ActiveSupport::OrderedHash.new) do |hash, name|
      name = name.to_s[1..-1].to_sym
      val = object.send(name)
      if val.is_a?(Array)
        val = '[ ... ]'
      end
      hash[name] = val
      hash
    end
    "#{object} " << awesome_hash(data)
  end

  def awesome_virtus_model_class(object)
    return object.inspect if !defined?(::ActiveSupport::OrderedHash)

    data = object.attribute_set.each.to_a.inject(::ActiveSupport::OrderedHash.new) do |hash, attribute|
      if attribute.is_a?(Virtus::Attribute::Collection)
        type = "#{attribute.type.primitive.to_s}[#{attribute.type.member_type.to_s}]"
      else
        type = attribute.type.primitive.to_s
      end

      hash[attribute.name] = type

      hash
    end
    "class #{object} < #{object.superclass} " << awesome_hash(data)
  end
end

AwesomePrint::Formatter.send(:include, AwesomeVirtus)
