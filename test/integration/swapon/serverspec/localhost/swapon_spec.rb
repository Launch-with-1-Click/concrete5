require ::File.expand_path('../spec_helper', __FILE__)

describe command('swapon -s') do
  its(:stdout) { should match /\/mnt\/swap/ }
end
