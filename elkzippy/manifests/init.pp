class elkzippy
{
if $::osfamily == 'RedHat' {
include java
exec {'epel-ralease':
	command => '/usr/bin/yum install -y epel-release'
}
exec {'net-tools':
        command => '/usr/bin/yum install -y net-tools'
}
exec {'wget':
        command => '/usr/bin/yum install -y wget'
}
exec {'key':
        command => '/usr/bin/rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch'
}
exec {'elasticsearch':
        command => '/usr/bin/wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-6.2.4.rpm'
}
exec {'elasticsearchextrat':
        command => '/usr/bin/rpm -ivh elasticsearch-6.2.4.rpm'
}
exec {'kibanainstall':
        command => '/usr/bin/wget https://artifacts.elastic.co/downloads/kibana/kibana-6.2.4-x86_64.rpm'
}
exec {'kibanextract':
        command => '/usr/bin/rpm -ivh kibana-6.2.4-x86_64.rpm'
}
include centos
exec {'daemon':
        command => '/usr/bin/systemctl daemon-reload'
}
exec {'enable':
        command => '/usr/bin/systemctl enable elasticsearch'
}
exec {'start':
        command => '/usr/bin/systemctl start elasticsearch'
}
exec {'restart':
        command => '/usr/bin/systemctl restart elasticsearch'
}

exec {'kibanenable':
        command => '/usr/bin/systemctl enable kibana'
}

exec {'kibanstart':
        command => '/usr/bin/systemctl start kibana'
}
exec {'kibanrestart':
        command => '/usr/bin/systemctl restart kibana'
}
exec {'logstash':
        command => '/usr/bin/wget https://artifacts.elastic.co/downloads/logstash/logstash-6.2.4.rpm'
}
exec {'logstashextract':
        command => '/usr/bin/rpm -ivh logstash-6.2.4.rpm'
}
exec {'logenable':
        command => '/usr/bin/systemctl enable logstash'
}
exec {'logstart':
        command => '/usr/bin/systemctl start logstash'
}
exec {'logrestart':
        command => '/usr/bin/systemctl restart logstash'
}
}



if $::osfamily == 'Debian' {
include java
exec::multi {'ubuntuRun':
             commands => ['wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -','echo "deb https://artifacts.elastic.co/packages/6.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-6.x.list','sudo apt -y update','sudo apt install -y elasticsearch']
 }
 exec::multi {'ubuntukibana':
       commands => ['sudo apt install -y kibana','sudo apt install -y logstash'],
}
include centos
 exec::multi {'ubuntukibanastart':
       commands => ['sudo systemctl start elasticsearch','sudo systemctl enable elasticsearch','sudo systemctl restart elasticsearch'],
}
exec::multi {'kibanadash':
       commands => ['sudo systemctl start kiban','sudo systemctl enable kibana','sudo systemctl restart kibana'],

}
}




if $::osfamily == 'windows' {
 include chocolatey
# $powershell = 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe -NoProfile -NoLogo -NonInteractive'
#exec { 'test1':
#  command => 'powershell -Command Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))',
#}
#exec { 'test12':
#  command => 'C:/Windows/System32/WindowsPowerShell/v1.0/powershell.exe - file C:\Users\Administrator\Documents\WindowsPowerShell\newinstall.ps1',
#  path    => 'C:/WINDOWS/Sytems32/WindowsPowerShell/v1.0'
#  }
package { 'chocolatey':
  ensure   => latest,
}
file { "C:/ProgramData/chocolatey/install.ps1":
      mode   => "0644",
      owner  => 'Administrator',
      group  => 'Administrator',
      source => 'puppet:///modules/windows/install.ps1',
}
exec { 'chocolatey_service':
  command => 'C:/ProgramData/chocolatey/install.ps1',
}

exec { 'jdk_install':
  command => 'choco install -y jdk8',
  path    => $::path
  }
exec { 'elasticsearch_install':
  command => 'choco install -y elasticsearch --version 6.2.4 ',
  path    => $::path
   }
exec { 'kiban_install':
  command => 'choco install -y kibana',
  path    => $::path
   }
exec { 'logstach_install':
  command => 'choco install -y logstash ',
  path    => $::path
   }
file { "C:/ProgramData/chocolatey/lib/elasticsearch/tools/elasticsearch-6.2.4/config/elasticsearch.yml":
      ensure  => 'file',
      mode   => "0644",
      owner  => 'Administrator',
      group  => 'Administrator',
      source => 'puppet:///modules/windows/elasticsearch.yml',
}
file { "C:/ProgramData/chocolatey/lib/kibana/tools/kibana-6.2.4-windows-x86_64/config/kibana.yml":
      ensure  => 'file',
      mode   => "0644",
      owner  => 'Administrator',
      group  => 'Administrator',
      source => 'puppet:///modules/windows/kibana.yml',
}

exec { 'elasticsearch_service':
  command => 'C:\ProgramData\chocolatey\lib\elasticsearch\tools\elasticsearch-6.2.4\bin\elasticsearch.bat',
}
exec { 'kibana_service':
  command => 'C:\ProgramData\chocolatey\lib\kibana\tools\kibana-6.2.4-windows-x86_64\bin\kibana.bat',
}
exec { 'logstash_service':
  command => 'C:\ProgramData\chocolatey\lib\logstash\tools\logstash-6.2.4\bin\logstash.bat',
}
}

}	
