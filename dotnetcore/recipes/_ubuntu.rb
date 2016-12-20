#
# Cookbook Name:: dotnetcore
# Recipe:: _ubuntu
#
# Copyright (C) 2016 Andrew Cornies
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt::default' do
    only_if { !node.has_recipe?('apt::default') }
end

apt_repository 'dotnetdev' do
    uri node['dotnetcore']['apt_package_source']
    components ['main']
    distribution 'trusty'
    arch 'amd64'
    key node['dotnetcore']['apt_package_source_key']
end

package "#{node['dotnetcore']['package']['name']}" do
    version node['dotnetcore']['package']['version']
    options '--force-yes'
end