require 'serverspec'
$LOAD_PATH.concat Dir.glob('/opt/chef/embedded/lib/ruby/gems/1.9.1/gems/*/lib')
require 'ohai'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  ENV['LANG'] = 'C'
end

ohai = Ohai::System.new
ohai.all_plugins
@@ohaidata = ohai.data
