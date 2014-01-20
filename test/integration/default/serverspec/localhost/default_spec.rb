require 'serverspec'
include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.os = backend(Serverspec::Commands::Base).check_os
  end
  c.path = "/sbin:/user/sbin"
end

%w{apache2 php5 mysql-server}.each do |package_name|
  describe package(package_name) do
    it { should be_installed }
  end
end

%w{apache2 mysql}.each do |service_name|
    describe service(service_name) do
      it { should be_enabled }
      it { should be_running }
    end
end

describe port(80) do
  it { should be_listening }
end

describe command("wget -q http://localhost/sandbox -O - | head -100 | grep generator") do
  it { should return_stdout /concrete5/ }
end
