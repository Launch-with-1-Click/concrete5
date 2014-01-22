if node.has_key?('ec2')
  if ['t1.micro'].include?(node[:ec2][:instance_type])
    swap_resource = swap_file '/mnt/swap' do
      size      2048
      persist   true
    end

    swap_resource.run_action(:create)
  end
end
