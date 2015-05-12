# DESCRIPTION:

Providers and recipe for btrfs filesystem backup.   
Backup a VM and a Host.  

# REQUIREMENTS:
* btrfs recipe 
* btrfs-tools latest version from sources.

# WARNING:

You must use latest brtfs and btrfs-tools, not the one packaged by your distribution.

# ATTRIBUTES: 
    
      backuplog=backup["backupparams"]["local"]["log"]
      retention=backup["backupparams"]["local"]["retention"]
      backupdir=backup["backupparams"]["local"]["localdir"]
      sftpusername=u["id"]
      cronuser= backup["backupparams"]["local"]["cron"]["user"]
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
      remotersyncoptions=backup["backupparams"]["remote"]["btrfsoptions"]
      localrsyncoptions=backup["backupparams"]["local"]["btrfsoptions"]
      doit=backup["action"]
      

# USAGE:

Set attributes over node or roles.  
Create a recipe with all attributes.
Apply the recipe to a node.  
