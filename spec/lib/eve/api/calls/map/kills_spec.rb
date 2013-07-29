require 'spec_helper'

describe Eve::API::Services::Map do
  context "#kills" do
    subject { mock_service('map', 'kills').solar_systems }

    it "should behave like a Rowset" do
      subject.should behave_like_rowset("solarSystemID,shipKills,factionKills,podKills")
    end
  end
end
