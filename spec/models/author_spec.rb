require 'spec_helper'

describe Author do
  describe '#last_name is derived from :publish_name' do
    example 'Smith from Smith,Joe' do
      subject.publish_name = 'Smith,Joe'
      expect(subject.last_name).to eql('Smith')
    end

    example 'Smith from Smith,Joe,M' do
      subject.publish_name = 'Smith,Joe,M'
      expect(subject.last_name).to eql('Smith')
    end
  end
end
