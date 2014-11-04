require 'rails_helper'

RSpec.describe DummyObject, :type => :model do
  xit { expect(subject.notifly).to be_a NotiflyModelOptions }
  it { is_expected.to have_many(:posts) }
end
