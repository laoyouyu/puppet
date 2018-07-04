require 'spec_helper'
describe 'mediawiki' do
  context 'with default values for all parameters' do
    it { should contain_class('mediawiki') }
  end
end
