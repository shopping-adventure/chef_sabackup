actions :backup, :remove

attribute :base_dir, :kind_of => String, :default => "/srv/sa-backup"
attribute :options, :kind_of => Hash
attribute :description, :kind_of => String, :default => nil
attribute :store_with, :kind_of => Hash
attribute :hour, :kind_of => String, :default => "1"
attribute :minute, :kind_of => String, :default => "*"
attribute :shell, :kind_of => String, :default => "/bin/bash"
attribute :day, :kind_of => String, :default => "*"
attribute :month, :kind_of => String, :default => "*"
attribute :weekday, :kind_of => String, :default => "*"
attribute :mailto, :kind_of => String, :default => nil
attribute :user, :kind_of => String, :default => nil

def initialize(*args)
  super
  @action = :nothing
end
