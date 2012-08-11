module ThymeOnRails
  class Persistence
    def add_activity_time_span(data)
      ActivityTimeSpan.create! data
    end

    def activity_time_entries_on(date)
      ActivityTimeSpan.where(:on_date => date).order(:from_time).map(&:attributes)
    end
  end
end
