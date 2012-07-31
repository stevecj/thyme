require_relative '../../lib/thyme'

describe Thyme do
  subject{ Thyme.new }

  describe '#dates_in_week_of' do
    it "returns correct range for a Monday date" do
      monday_date = Date.civil( 2012, 7, 30 )
      sunday_date = Date.civil( 2012, 8,  5 )
      subject.dates_in_week_of( monday_date ).should == (monday_date..sunday_date)
    end

    it "returns correct range for a Sunday date" do
      monday_date = Date.civil( 2011, 12, 26 )
      sunday_date = Date.civil( 2012,  1,  1 )
      subject.dates_in_week_of( sunday_date ).should == (monday_date..sunday_date)
    end
    it "returns correct range for a Monday date" do
      monday_date = Date.civil( 2012, 7, 30 )
      sunday_date = Date.civil( 2012, 8,  5 )
      subject.dates_in_week_of( monday_date ).should == (monday_date..sunday_date)
    end
  end
end
