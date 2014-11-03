require 'rails_helper'

describe NotiflyModelOptions do
  describe '#assign' do
    context 'when assigning default values' do
      it 'should set default values' do
        subject.assign(options: { default_values: { sender: :self, receiver: :foo, 
          template: 1, target: nil }})

        expect(subject.sender).to eql :self
        expect(subject.receiver).to eql :foo
        expect(subject.template).to eql 1
        expect(subject.target).to eql nil
      end
    end
  end
end