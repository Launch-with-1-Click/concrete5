require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

describe command("php -i | grep default_charset") do
    it { should return_stdout /utf\-8/i }
end

describe command("php -i | grep mbstring.language") do
    it { should return_stdout /neutral/i }
end

describe command("php -i | grep mbstring.internal_encoding") do
    it { should return_stdout /utf\-8/i }
end

