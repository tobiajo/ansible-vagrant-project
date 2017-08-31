def create_vm(config, spec, group, id)
  hostname = "%s%d" % [group, id]
  offset = spec["cluster"]["groups"][group]["offset"]
  ip = spec["cluster"]["network"]["ip"] + "#{offset+id}"
  config.vm.define hostname do |vm|
    vm.vm.hostname = hostname
    vm.vm.network "private_network", ip: ip
    vm.vm.provider "virtualbox" do |vb|
      resources = spec["virtualbox"]["groups"][group]
      vb.cpus = resources["cpus"]
      vb.memory = resources["memory"]
    end
  end
  return hostname, ip
end
