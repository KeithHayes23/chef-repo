#
# Cookbook Name:: dotnetcoreapp
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'aws'

directory "/var/aspdotnetcoreapps/" do
  mode 0755
  owner 'root'
  group 'root'
  action :create
end

aws_s3_file "/var/aspdotnetcoreapps/DotNetCoreLinux.zip" do
  bucket "hayesbucket"
  remote_path "DotNetCoreLinux.zip"
end
