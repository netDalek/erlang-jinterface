java_import "com.ericsson.otp.erlang.OtpSelf"
java_import "com.ericsson.otp.erlang.OtpPeer"

def start_node
  pid = spawn <<-STR
      erl -name server@a2p-dev.fun-box.ru -setcookie qwerty -eval "compile:file('spec/test_module')"
  STR
  sleep(1)
  pid
end

def stop_node(pid)
  Process.kill("TERM", pid)
end

def connect_to_node()
  client = OtpSelf.new("client@a2p-dev.fun-box.ru", "qwerty") 
  other  = OtpPeer.new("server@a2p-dev.fun-box.ru")
  client.connect(other)
end

def send_to_node(connection, method, args = OtpErlangList.new)
  connection.sendRPC("test_module", method.to_s, args)
  connection.receiveRPC
end
