#Backup of files and folders over btrfs
sftpnodes=search(:node,"role:backupserver AND backup:type AND type:master AND chef_environment:#{node.chef_environment}")
if not sftpnodes.empty? and node["backups"] and node["backups"]["btrfs"]
Chef::Log.warn("KEV btrfs backup")

  node["backups"]["btrfs"].each do |folder, backup|

    sabackup_btrfs "#{folder}" do
      backuplog=backup["backupparams"]["local"]["log"]
      retention=backup["backupparams"]["local"]["retention"]
      backupdir=backup["backupparams"]["local"]["localdir"]
      sftpusername=""
      search(:users, 'id:sa-backup') do |u|
        sftpusername=u["id"]

      end
      if backup["backupparams"]["local"]["cron"]["user"] == nil 
        cronuser=sftpusername
      else
        cronuser= backup["backupparams"]["local"]["cron"]["user"]
      end
      sftpnode=sftpnodes.first
      sftpip=(sftpnode["cloud"]) ? sftpnode["cloud"]["local_ipv4"] : sftpnode["ipaddress"]
      sftpport=backup["backupparams"]["remote"]["port"]
      sftppath=backup["backupparams"]["remote"]["dir"]
      cronmn=backup["backupparams"]["local"]["cron"]["minute"]
      cronhr=backup["backupparams"]["local"]["cron"]["hour"]
      cronday=backup["backupparams"]["local"]["cron"]["day"]
      cronmon=backup["backupparams"]["local"]["cron"]["month"]
      cronjr=backup["backupparams"]["local"]["cron"]["jour"]
      cronshell=backup["backupparams"]["local"]["cron"]["shell"]
      descr=backup["description"]
      remoteengine=backup["backupparams"]["remote"]["engine"]
      localengine=backup["backupparams"]["local"]["engine"]
      remoteretention=backup["backupparams"]["remote"]["retention"]
      localretention=backup["backupparams"]["local"]["retention"]
      sshkeypath=backup["backupparams"]["remote"]["sshkeypath"]

      if remoteengine == "rsync"
        remotersyncoptions=backup["backupparams"]["remote"]["rsyncoptions"]
      end
      if localengine == "rsync"
        localrsyncoptions=backup["backupparams"]["local"]["rsyncoptions"]
      end
      if remoteengine == "btrfs"
        remotersyncoptions=backup["backupparams"]["remote"]["btrfsoptions"]
      end
      if localengine == "btrfs"
        localrsyncoptions=backup["backupparams"]["local"]["btrfsoptions"]
      end
      doit=backup["action"]
      description "#{descr}"

      store_with({"engine" => "#{localengine}", "settings" => { "sftp.username" => "#{sftpusername}", "sftp.ip" => "#{sftpip}", "sftp.port" => "#{sftpport}", "sftp.path" => "#{sftppath}", "sftp.retention" => "#{remoteretention}","ssh.key" => "#{sshkeypath}" },"options" => {} })
      options( { "folder.name" => backup['foldername'],"folder.dir" => backup['folderpath'], "backup.log" => "#{backuplog}", "backup.retention" => "#{localretention}", "backup.pathdir" => "#{backupdir}" } )

      mailto "root"
      hour    "#{cronhr}"
      minute  "#{cronmn}"
      day	"#{cronday}"
      month	"#{cronmon}"
      weekday	"#{cronjr}"
      user    "#{cronuser}"
      shell	"#{cronshell}"
      action :"#{doit}"
    end

  end
end
