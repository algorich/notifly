require 'rails_helper'

RSpec.describe DummyObject, :type => :model do
  it { expect(subject.notifly).to be_a NotiflyModelOptions }
end
