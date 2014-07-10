#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
#hostsfile_entry '127.0.1.1' do
#  action :remove
#end
hostsfile_entry '192.168.33.210' do
  hostname  '1xb001.devops.test'
  aliases   ['1xb001']
  action    :create_if_missing
end
hostsfile_entry '192.168.33.211' do
  hostname  '1xrm01.devops.test'
  aliases   ['1xrm01']
  action    :create_if_missing
end
