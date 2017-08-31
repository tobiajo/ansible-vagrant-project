# -*- mode: ruby -*-
# vi: set ft=ruby :

require_relative "vmfactory"

Vagrant.configure("2") do |config|
  spec = YAML.load_file("cluster-spec.yml")
  config.vm.box = spec["cluster"]["default"]["box"]
  config.vm.box_url = spec["cluster"]["default"]["box_url"]
  groups = {}
  host_vars = {}
  spec["cluster"]["groups"].each do |group, _|
    groups[group] = []
    (0..spec["cluster"]["groups"][group]["nodes"]-1).each do |i|
      hostname, ip = create_vm(config, spec, group, i)
      groups[group].push(hostname)
      host_vars[hostname] = {}
      host_vars[hostname]["ip"] = ip
    end
  end
  config.vm.provision "ansible" do |ansible|
    ansible.limit = "all"
    ansible.playbook = "ansible/dummy.yml"
    ansible.groups = groups
    ansible.host_vars = host_vars
  end
end
