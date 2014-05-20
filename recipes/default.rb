#
# Cookbook Name:: eol-logrotate-wrapper
# Recipe:: default
#

require 'ostruct'

include_recipe('logrotate')

def create_logrotate(logrotate_config)
  l = logrotate_config
  logrotate_app l.name do
    cookbook 'logrotate'

    options ['missingok', 'copytruncate']
    path "%s/*.log" % l.path.strip.gsub("/$", '')
    rotate 10
    create '0600 root root'
    size '100k'
  end
end

logrotates = data_bag_item('eol-logrotate', 'config') rescue []

logrotates.each do |l|
  l = OpenStruct.new(l)
  create_logrotate(l) if l.nodes.empty? || l.nodes.include?(node.name)
end




