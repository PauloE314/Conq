Levels = Conq::Levels

RSpec.describe Levels do
  let(:levels) { Levels.constants.map {|level_name| Levels.const_get(level_name) } }

  it "contains all required levels" do
    expected_levels = [:DEBUG, :INFO, :WARNING, :ERROR, :CRITICAL]

    expect(Levels.constants).to match_array(expected_levels)
  end

  it "have the correct importance order" do
    sorted_levels = levels.sort
    expected_sorted_levels = [
      Levels::DEBUG,
      Levels::INFO,
      Levels::WARNING,
      Levels::ERROR,
      Levels::CRITICAL
    ]

    expect(sorted_levels).to be_eql(expected_sorted_levels)
  end
end