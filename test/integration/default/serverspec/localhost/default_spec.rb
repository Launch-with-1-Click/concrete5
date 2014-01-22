require ::File.expand_path('../spec_helper', __FILE__)

describe command("wget -q http://localhost/ -O - | head -100 | grep generator") do
    it { should return_stdout /concrete5/i }
end

