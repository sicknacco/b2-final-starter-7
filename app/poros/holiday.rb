class Holiday
  attr_reader :date1,
              :name1,
              :date2,
              :name2,
              :date3,
              :name3
  def initialize(data)
    # @top_3 = data[0..2]
    @date1 = data.first[:date]
    @name1 = data.first[:name]
    @date2 = data.second[:date]
    @name2 = data.second[:name]
    @date3 = data.third[:date]
    @name3 = data.third[:name]
  end
end




