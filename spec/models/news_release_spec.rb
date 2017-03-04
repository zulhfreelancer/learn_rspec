require 'rails_helper'

RSpec.describe NewsRelease do
  it { is_expected.to validate_presence_of :released_on }
  it { is_expected.to validate_presence_of :title }
  it { is_expected.to validate_presence_of :body }

  it "returns the formatted date and title as string" do
    news_release = NewsRelease.new(
                                    released_on: "2013-12-31",
                                    title:       "BigCo hires new CEO",
                                  )  
    expect(news_release.title_with_date).to eq "2013-12-31: BigCo hires new CEO"
  end
end
