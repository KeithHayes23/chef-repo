#
# Cookbook Name:: dotnetcoreapp
# Recipe:: default
#
# Copyright (c) 2016 Keith Hayes, All Rights Reserved.
include_recipe 'aws'
include_recipe 'zip'

# grab custom json
require 'json'
json = `opsworks-agent-cli get_json`
node = JSON.parse(json, symbolize_names: true)
S3Bucket = node[:S3Bucket]
S3BucketObject = node[:S3BucketObject]
AppName = File.basename(S3BucketObject, ".*")
log "S3Bucket: #{S3Bucket} S3BucketObject: #{S3BucketObject} AppName: #{AppName}"
BASE_PATH = "/var/aspdotnetcoreapps/"

directory BASE_PATH do
  mode 0755
  owner 'root'
  group 'root'
  action :create
end

directory "#{BASE_PATH}#{AppName}" do
  recursive true
  action :delete
end

aws_s3_file "/tmp/#{S3BucketObject}" do
  bucket S3Bucket
  remote_path S3BucketObject
end

execute 'extract_stuff' do
	command "unzip /tmp/#{S3BucketObject} -d #{BASE_PATH}"
end

execute 'cleanup_stuff' do
	command "rm /tmp/#{S3BucketObject}"
end

template '/etc/init.d/dotnetcoreapp' do
  source 'dotnetcoreapp.erb'
  variables ({
    :DAEMON_PATH => "#{BASE_PATH}#{AppName}",
    :AppName => "#{AppName}.dll"
  })
  owner 'root'
  group 'root'
  mode '0755'
end

template "/var/aspdotnetcoreapps/#{AppName}/wwwroot/index.html" do
  source 'index.html.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

service 'dotnetcoreapp' do
  action [:enable, :restart]
end

