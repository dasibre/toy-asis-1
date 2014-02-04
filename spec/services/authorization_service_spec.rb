require 'spec_helper'

describe AuthorizationService do
  let(:authors) { [] }
  let(:manuscript) { double('Manuscript', :authors => authors) }

  def accept?(name)
    AuthorizationService.accept?(manuscript, name)
  end

  it 'rejects nil author name' do
    authors << double('Author', :last_name => 'Jones')
    expect(accept?(nil)).to be_false
  end

  it 'rejects nil manuscript' do
    expect(AuthorizationService.accept?(nil, 'Smith')).to be_false
  end

  describe 'accepts match on first 3 authors' do
    example 'first author' do
      authors << double('Author', :last_name => 'Jones')
      expect(accept?('Jones')).to be_true
    end

    example 'second author' do
      %w(Jones Smith).each { |a| authors << double('Author', :last_name => a) }
      expect(accept?('Smith')).to be_true
    end

    example 'third author' do
      %w(Jones Smith Martin).each { |a| authors << double('Author', :last_name => a) }
      expect(accept?('Martin')).to be_true
    end

    it 'rejects fourth author' do
      %w(Jones Smith Martin Doe).each { |a| authors << double('Author', :last_name => a) }
      expect(accept?('Doe')).to be_false
    end
  end

  describe 'matching' do
    it 'ignores surrounding whitespace' do
      authors << double('Author', :last_name => '  Jones    ')
      expect(accept?(' Jones  ')).to be_true
    end

    it 'ignores case' do
      authors << double('Author', :last_name => 'Jones')
      expect(accept?('joNes')).to be_true
    end

    it 'accepts match on first 3 chars (e.g. Jon for Jones)' do
      authors << double('Author', :last_name => 'Jones')
      expect(accept?('Jon')).to be_true
    end

    it 'rejects mismatch on chars beyond 3 (e.g. reject Jonis for Jones)' do
      authors << double('Author', :last_name => 'Jones')
      expect(accept?('Jonis')).to be_false
    end

    it 'rejects match on less than 3 chars (e.g. Jo for Jones)' do
      authors << double('Author', :last_name => 'Jones')
      expect(accept?('Jo')).to be_false
    end

    it 'accepts exact match for 2 char author name (e.g. Li for Li)' do
      authors << double('Author', :last_name => 'Li')
      expect(accept?('Li')).to be_true
    end

    it 'rejects exact match on 1 char author name' do
      authors << double('Author', :last_name => 'L')
      expect(accept?('L')).to be_false
    end
  end
end
