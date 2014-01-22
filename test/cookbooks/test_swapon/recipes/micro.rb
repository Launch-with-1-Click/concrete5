#
# Cookbook Name:: test_swapon
# Recipe:: default
#
# Copyright 2014, HiganWorks LLC
#
# All rights reserved - Do Not Redistribute
#


node.set[:ec2] = Mash.new
node.set[:ec2][:instance_type] = 't1.micro'
