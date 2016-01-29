def hostname
  `hostname -s`.strip
end

def start_node
  pid = spawn <<-STR
      erl -sname server@#{hostname} -setcookie qwerty -eval "compile:file('spec/test_module')"
  STR
  sleep(1)
  pid
end

def stop_node(pid)
  Process.kill("TERM", pid)
end

def connect_to_node()
  client = OtpSelf.new(SecureRandom.hex, "qwerty") 
  other  = OtpPeer.new("server@#{hostname}")
  client.connect(other)
end

def send_to_node(connection, method, args = OtpErlangList.new)
  connection.sendRPC("test_module", method.to_s, args)
  connection.receiveRPC
end
