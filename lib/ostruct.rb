class OpenStruct
  def initialize(args = {})
    @table = {}
    args.each_pair do |key, value|
      key = key.to_sym
      @table[key] = value
      define_singleton_method(key) { @table[key] }
    end
  end

  def [](key)
    @table[key.to_sym]
  end

  def inspect
    fields = [self.class] + @table.map do |key, value|
      "#{key}=#{value.equal?(self) ? "#<#{self.class} ...>" : value.inspect}"
    end
    "#<#{fields.join(' ')}>"
  end
  alias to_s inspect
end
