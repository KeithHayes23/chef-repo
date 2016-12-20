#
# Cookbook Name:: dotnetcore
# Recipe:: _platform
#
# Copyright (C) 2016 Andrew Cornies
#
# All rights reserved - Do Not Redistribute
#

case node['platform']
when 'windows'
    include_recipe 'dotnetcore::_windows'
when 'debian', 'ubuntu'
    include_recipe 'dotnetcore::_ubuntu'
else
    fail 'This cookbook currently only supports Debian/Ubuntu and Windows.'
end