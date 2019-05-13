class centos
{
if $::osfamily == 'RedHat' {
file { "/etc/elasticsearch/elasticsearch.yml":
       ensure   => 'file',
       mode     => "0644",
       owner    => 'root',
       group    => 'root',
       source   => 'puppet:///modules/elkzippy/elasticsearch.yml',
}
file { "/usr/lib/systemd/system/elasticsearch.service":
      ensure  => 'file',
       mode   => "0644",
       owner  => 'root',
       group  => 'root',
       source => 'puppet:///modules/elkzippy/elasticsearch.service',
}
file { "/etc/sysconfig/elasticsearch":
      ensure  => 'file',
       mode   => "0644",
       owner  => 'root',
       group  => 'root',
       source => 'puppet:///modules/elkzippy/elasticsearch',
}
file { "/etc/kibana/kibana.yml":
      ensure  => 'file',
       mode   => "0644",
       owner  => 'root',
       group  => 'root',
       source => 'puppet:///modules/elkzippy/kibana.yml',
}

}
if $::osfamily == 'Debian' {
file { "/etc/elasticsearch/elasticsearch.yml":
      ensure  => 'file',
      mode    => "0644",
      owner   => 'zippyops',
      group   => 'zippyops',
      source  => 'puppet:///modules/java/elasticsearch.yml',
}
file { "/etc/kibana/kibana.yml":
      ensure  => 'file',
      mode    => "0644",
      owner   => 'zippyops',
      group   => 'zippyops',
      source  => 'puppet:///modules/java/kibana.yml',
}
}
if $::osfamily == 'windows' {
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

}
}
