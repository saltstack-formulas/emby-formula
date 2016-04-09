require "serverspec"

set :backend, :exec

describe service("emby-server") do
  it { should be_enabled }
  it { should be_running }
end

describe command("i=0; while [ $i -lt 200 -a -z \"$(grep 'HttpListener' /var/log/emby-server.log)\" ]; do i=$[$i+1] sleep 1s; done") do
  # let service start
  its(:exit_status) { should eq 0 }
end

describe port("8096") do
  it { should be_listening }
end

describe command("curl -L localhost:8096") do
  its(:stdout) { should match /Emby/ }
end
