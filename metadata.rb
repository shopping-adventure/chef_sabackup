maintainer       "Kevin Maziere"
maintainer_email "kevin@kbrwadventure.com"
license          "Apache 2.0"
description      "Installs/Configures backup"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.2"
%w{build-essential}.each do |cb|
  depends cb
end
