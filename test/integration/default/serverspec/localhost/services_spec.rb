require ::File.expand_path('../spec_helper', __FILE__)

## Enable Services
case @@ohaidata[:platform]
when 'debian', 'ubuntu'
  enable_svcs = %w(apache2 cron mysql ssh)
when 'rhel', 'amazon', 'centos'
  enable_svcs = %w(httpd crond mysqld sshd)
end

enable_svcs.each do |svc|
  describe service(svc) do
    it { should be_enabled }
    it { should be_running }
  end
end
