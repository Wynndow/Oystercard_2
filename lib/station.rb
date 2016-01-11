class Station

  attr_reader :name, :zone

  def initialize(options)
    @name = options[:name]
    @zone = options[:zone]
  end

end
