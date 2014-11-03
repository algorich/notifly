require 'rails_helper'

describe Notifly::Base do
  it 'should add the method "ActiveRecord::Base.notifly"' do
    expect(ActiveRecord::Base).to respond_to :notifly
  end
end