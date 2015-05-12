action :backup do
	cron "scheduled backup: " + new_resource.name do
		hour new_resource.hour || "1" 
		minute new_resource.minute || "*"
		day new_resource.day || "*"
		month new_resource.month || "*"
		weekday new_resource.weekday || "*"
		shell new_resource.shell || "/bin/bash"
		mailto new_resource.mailto 
		user new_resource.user || "root"
		command "#{new_resource.base_dir}/chef_backup_#{new_resource.name}.sh "
		path "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:#{new_resource.base_dir}"
		action :create
	end
	template "#{new_resource.base_dir}/chef_backup_#{new_resource.name}.sh" do
		mode 0700
		owner "sa-backup"
		group "root"
		source new_resource.options["source"] || "chef_backup.sh.erb"
		cookbook new_resource.options["cookbook"] || "sabackup"
		variables({
			:name => new_resource.name, 
			:options => new_resource.options,
			:base_dir => new_resource.base_dir,
			:description => new_resource.description,
			:store_with => new_resource.store_with,
			:compress_with => new_resource.compress_with,
			:ignore_files => new_resource.ignore_files
		})
		notifies :create, resources(:cron => "scheduled backup: " + new_resource.name), :immediately
	end
	new_resource.updated_by_last_action(true)
end

action :remove do
	file "#{new_resource.base_dir}/chef_backup_ #{new_resource.name}.sh " do
		action :delete
	end
	cron "scheduled backup: " + new_resource.name do
		hour new_resource.hour || "1" 
		minute new_resource.minute || "*"
		day new_resource.day || "*"
		month new_resource.month || "*"
		weekday new_resource.weekday || "*"
		shell new_resource.shell || "/bin/bash"
		mailto new_resource.mailto 
		user new_resource.user || "root"
		path "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:#{new_resource.base_dir}"
		command "#{new_resource.base_dir}/chef_backup_#{new_resource.name}.sh "
		action :delete
	end
	new_resource.updated_by_last_action(true)
end
