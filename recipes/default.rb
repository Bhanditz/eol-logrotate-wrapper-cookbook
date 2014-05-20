#
# Cookbook Name:: eol-logrotate-wrapper
# Recipe:: default
#

require 'ostruct'

include_recipe('logrotate')

def create_logrotate(name, data)
  logrotate_app name do
    cookbook 'logrotate'

    options ['missingok', 'copytruncate']
    path "%s/*.log" % data.path.strip.gsub("/$", '')
    rotate 20
    create '0600 root root'
    size '100k'
    frequency 'daily'
  end
end

logrotates = data_bag_item('eol-logrotate-wrapper', 'config') rescue {}

logrotates['logrotates'].each do |name, data|
  data = OpenStruct.new(data)
  if data.nodes.empty? || data.nodes.include?(node.name)
    create_logrotate(name, data) 
  end
end




