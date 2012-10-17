module KnowsTheDomain
  def application
    Application.new(persistence)
  end

  def persistence
    @persistence ||= Persistence.new
  end

  class Persistence
    def initialize
      @records = []
    end

    def save_new_activity_time_range(data)
      @records << data
    end

    def all_activity_time_ranges
      @records
    end
  end
end

class Application
  def initialize(persistence)
    @persistence = persistence
  end

  def record_activity_time_range(data)
    @persistence.save_new_activity_time_range data
  end

  def activity_time_ranges
    @persistence.all_activity_time_ranges
  end
end

World(KnowsTheDomain)
