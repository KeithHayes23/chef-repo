#
# Cookbook Name:: nginx
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
package 'nginx'

template '/etc/nginx/nginx.conf' do
  source 'nginx.conf.erb'
  notifies :reload, "service[nginx]", :delayed
end

service 'nginx' do
  action [:enable, :start]
end

