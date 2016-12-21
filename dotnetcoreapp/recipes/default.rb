#
# Cookbook Name:: dotnetcoreapp
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'aws'
include_recipe 'zip'

directory "/var/aspdotnetcoreapps/" do
  mode 0755
  owner 'root'
  group 'root'
  action :create
end

aws_s3_file "/tmp/DotNetCoreLinux.zip" do
  bucket "hayesbucket"
  remote_path "DotNetCoreLinux.zip"
end

execute 'extract_stuff' do
	command 'unzip /tmp/DotNetCoreLinux.zip -d /var/aspdotnetcoreapps/'
end

execute 'cleanup_stuff' do
	command 'rm /tmp/DotNetCoreLinux.zip'
end

template '/etc/init.d/dotnetcoreapp' do
  source 'dotnetcoreapp.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/var/aspdotnetcoreapps/DotNetCoreLinux/wwwroot/index.html' do
  source 'index.html.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'dotnetcoreapp' do
  action [:enable, :restart]
end

