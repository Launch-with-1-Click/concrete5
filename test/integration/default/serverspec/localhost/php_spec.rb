require ::File.expand_path('../spec_helper', __FILE__)

describe 'PHP config parameters' do
  context  php_config('default_charset') do
    its(:value) { should eq 'UTF-8' }
  end

  context php_config('mbstring.language') do
    its(:value) { should eq 'neutral' }
  end

  context php_config('mbstring.internal_encoding') do
    its(:value) { should eq 'UTF-8' }
  end
end
