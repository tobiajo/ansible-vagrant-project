def create_vm(config, spec, group, id)
  hostname = "%s%d" % [group, id]
  config.vm.define hostname do |vm|
    vm.vm.hostname = hostname
    vm.vm.provider :virtualbox do |vb|
      resources = spec["virtualbox"]["groups"][group]
      vb.cpus = resources["cpus"]
      vb.memory = resources["memory"]
    end
  end
end
