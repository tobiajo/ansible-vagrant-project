# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative "vmfactory"

Vagrant.configure("2") do |config|
  spec = YAML.load_file("cluster-spec.yml")
  config.vm.box = spec["cluster"]["default"]["box"]
  config.vm.box_url = spec["cluster"]["default"]["box_url"]
  spec["cluster"]["groups"].each do |group, _|
    (0..spec["cluster"]["groups"][group]["nodes"]-1).each do |i|
      create_vm(config, spec, group, i)
    end
  end
end
