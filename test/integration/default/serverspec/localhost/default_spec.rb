require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe command("wget -q http://localhost/ -O - | head -100 | grep generator") do
    it { should return_stdout /concrete5/i }
end

