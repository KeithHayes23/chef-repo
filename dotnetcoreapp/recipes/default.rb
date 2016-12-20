#
# Cookbook Name:: dotnetcoreapp
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'aws'
include_recipe 'zipfile'

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

zipfile '/tmp/DotNetCoreLinux.zip' do
  into '/var/aspdotnetcoreapps'
end
