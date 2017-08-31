def create_vm(config, spec, groups, host_vars, group, id)
  hostname = "%s%d" % [group, id]
  offset = spec["cluster"]["groups"][group]["offset"]
  ip = spec["cluster"]["network"]["ip"] + "#{offset+id}"
  groups[group].push(hostname)
  host_vars[hostname] = {}
  host_vars[hostname]["ip"] = ip
  config.vm.define hostname do |vm|
    vm.vm.box = spec["cluster"]["default"]["box"]
    vm.vm.box_url = spec["cluster"]["default"]["box_url"]
    vm.vm.hostname = hostname
    vm.vm.network "private_network", ip: ip
    vm.vm.provider "virtualbox" do |vb|
      resources = spec["virtualbox"]["groups"][group]
      vb.cpus = resources["cpus"]
      vb.memory = resources["memory"]
    end
    vm.vm.provision "ansible" do |ansible|
      ansible.limit = "all"
      ansible.playbook = "ansible/dummy.yml"
      ansible.groups = groups
      ansible.host_vars = host_vars
    end
  end
end
