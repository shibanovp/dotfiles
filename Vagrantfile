Vagrant.configure("2") do |config|
    config.vm.box = "generic/ubuntu2004"

    config.vm.define 'ubuntu'

    config.vm.provision "ansible" do |ansible|
        ansible.playbook = "dagger.yml"
    end

    # Prevent SharedFoldersEnableSymlinksCreate errors
    config.vm.synced_folder ".", "/vagrant", disabled: true
end
