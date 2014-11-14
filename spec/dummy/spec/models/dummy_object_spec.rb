require 'rails_helper'

RSpec.describe DummyObject, :type => :model do
  it { is_expected.to have_many(:posts) }
end
