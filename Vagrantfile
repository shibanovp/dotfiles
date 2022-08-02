Vagrant.configure("2") do |config|
    config.vm.box = "generic/ubuntu2004"

    config.vm.define 'ubuntu'
    config.vm.network "forwarded_port", guest: 1234, host: 1234

    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "buildkit.yml"
    end

    # Prevent SharedFoldersEnableSymlinksCreate errors
    config.vm.synced_folder ".", "/vagrant", disabled: true
end
