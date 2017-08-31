# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative "vmfactory"

Vagrant.configure("2") do |config|
  spec = YAML.load_file("cluster-spec.yml")
  groups = {}
  host_vars = {}
  spec["cluster"]["groups"].each do |group, _|
    groups[group] = []
    (0..spec["cluster"]["groups"][group]["nodes"]-1).each do |id|
      create_vm(config, spec, groups, host_vars, group, id)
    end
  end
end
