class HolidayFacade
  def initialize
  end

  def self.holidays
    data = HolidayService.holidays
    data.map do |holiday_data|
      Holiday.new(holiday_data)
    end
  end
end