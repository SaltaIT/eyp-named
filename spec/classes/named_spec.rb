require 'spec_helper'

describe 'named', :type => 'class' do

context "RH family" do
	let :facts do
	{
		:osfamily => 'RedHat',
	}
	end

	it {
		should contain_package('bind')
		#should contain_service('named')
	}
	end

end

