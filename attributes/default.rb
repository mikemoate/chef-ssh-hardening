# encoding: utf-8
#
# Cookbook Name:: ssh-hardening
# Attributes:: default
#
# Copyright 2012, Dominik Richter
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Define the client package name
case node['platform']
when 'redhat', 'centos', 'fedora', 'amazon', 'oracle', 'scientific'
  default['ssh-hardening']['sshclient']['package'] = 'openssh-clients'
when 'debian', 'ubuntu'
  default['ssh-hardening']['sshclient']['package'] = 'openssh-client'
when 'arch', 'suse', 'opensuse', 'opensuseleap'
  default['ssh-hardening']['sshclient']['package'] = 'openssh'
else
  default['ssh-hardening']['sshclient']['package'] = 'openssh-client'
end

# Define the server package name
case node['platform']
when 'suse', 'opensuse', 'opensuseleap'
  default['ssh-hardening']['sshserver']['package'] = 'openssh'
else
  default['ssh-hardening']['sshserver']['package'] = 'openssh-server'
end

# Define the service name for sshd
case node['platform_family']
when 'rhel', 'fedora', 'suse', 'freebsd', 'gentoo'
  default['ssh-hardening']['sshserver']['service_name'] = 'sshd'
else
  default['ssh-hardening']['sshserver']['service_name'] = 'ssh'
end

# sshd + ssh client
default['ssh-hardening']['network']['ipv6']['enable']      = false
default['ssh-hardening']['config_disclaimer']              = '**Note:** This file was automatically created by Hardening Framework (dev-sec.io) configuration. If you use its automated setup, do not edit this file directly, but adjust the automation instead.'
default['ssh-hardening']['ssh']['ports']                   = [22]

# ssh client
default['ssh-hardening']['ssh']['client']['mac']           = nil     # nil = calculate best combination for client
default['ssh-hardening']['ssh']['client']['kex']           = nil     # nil = calculate best combination for client
default['ssh-hardening']['ssh']['client']['cipher']        = nil     # nil = calculate best combination for client
default['ssh-hardening']['ssh']['client']['cbc_required']  = false
default['ssh-hardening']['ssh']['client']['weak_hmac']     = false
default['ssh-hardening']['ssh']['client']['weak_kex']      = false
default['ssh-hardening']['ssh']['client']['remote_hosts']  = []
default['ssh-hardening']['ssh']['client']['password_authentication'] = false   # ssh
# http://undeadly.org/cgi?action=article&sid=20160114142733
default['ssh-hardening']['ssh']['client']['roaming']        = false

# sshd
default['ssh-hardening']['ssh']['server']['kex']                      = nil     # nil = calculate best combination for server version
default['ssh-hardening']['ssh']['server']['cipher']                   = nil     # nil = calculate best combination for server version
default['ssh-hardening']['ssh']['server']['mac']                      = nil     # nil = calculate best combination for server version
default['ssh-hardening']['ssh']['server']['cbc_required']             = false
default['ssh-hardening']['ssh']['server']['weak_hmac']                = false
default['ssh-hardening']['ssh']['server']['weak_kex']                 = false
default['ssh-hardening']['ssh']['server']['dh_min_prime_size']        = 2048
default['ssh-hardening']['ssh']['server']['dh_build_primes']          = false
default['ssh-hardening']['ssh']['server']['dh_build_primes_size']     = 4096
default['ssh-hardening']['ssh']['server']['host_key_files']           = ['/etc/ssh/ssh_host_rsa_key', '/etc/ssh/ssh_host_ecdsa_key']
default['ssh-hardening']['ssh']['server']['client_alive_interval']    = 600     # 10min
default['ssh-hardening']['ssh']['server']['client_alive_count']       = 3       # ~> 3 x interval
default['ssh-hardening']['ssh']['server']['allow_root_with_key']      = false
default['ssh-hardening']['ssh']['server']['allow_tcp_forwarding']     = false
default['ssh-hardening']['ssh']['server']['allow_agent_forwarding']   = false
default['ssh-hardening']['ssh']['server']['allow_x11_forwarding']     = false
default['ssh-hardening']['ssh']['server']['use_pam']                  = true
default['ssh-hardening']['ssh']['server']['challenge_response_authentication'] = false
default['ssh-hardening']['ssh']['server']['deny_users']               = []
default['ssh-hardening']['ssh']['server']['allow_users']              = []
default['ssh-hardening']['ssh']['server']['deny_groups']              = []
default['ssh-hardening']['ssh']['server']['allow_groups']             = []
default['ssh-hardening']['ssh']['server']['print_motd']               = false
default['ssh-hardening']['ssh']['server']['print_last_log']           = false
default['ssh-hardening']['ssh']['server']['banner']                   = nil     # set this to nil to disable banner or provide a path like '/etc/issue.net'
default['ssh-hardening']['ssh']['server']['os_banner']                = false   # (Debian OS family)
default['ssh-hardening']['ssh']['server']['use_dns']                  = nil     # set this to nil to let us use the default OpenSSH in case it's not set by the user
default['ssh-hardening']['ssh']['server']['use_privilege_separation'] = nil     # set this to nil to let us detect the attribute based on the node platform
default['ssh-hardening']['ssh']['server']['login_grace_time']         = '30s'
default['ssh-hardening']['ssh']['server']['max_auth_tries']           = 2
default['ssh-hardening']['ssh']['server']['max_sessions']             = 10
default['ssh-hardening']['ssh']['server']['password_authentication']  = false
default['ssh-hardening']['ssh']['server']['log_level']                = 'verbose'
# sshd sftp options
default['ssh-hardening']['ssh']['server']['sftp']['enable']           = false
default['ssh-hardening']['ssh']['server']['sftp']['group']            = 'sftponly'
default['ssh-hardening']['ssh']['server']['sftp']['chroot']           = '/home/%u'
