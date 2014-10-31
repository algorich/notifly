require 'rails_helper'

describe NotiflyModelOptions do
  describe '#assign' do
    it 'should assign the default values' do
      subject.assign(default_values: { sender: :self, receiver: :foo })
      expect(subject.sender).to eql :self
      expect(subject.receiver).to eql :foo
    end
  end
end