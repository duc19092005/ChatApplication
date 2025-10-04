import ws from "ws"
const wssConnection = new ws.Server({port : 8080})
const userConnection = new Map();

// Lắng nghe ở port 8080

wssConnection.on("connection" , function(ws : any, req : any) 
{
    console.log(req.url)
    const url = new URL(req.url , `http://${req.headers.host}`)
    // Lấy thông tin UserID , Hiện tại chưa có bước xác thực JWT
    const userId = url.searchParams.get('userId'); 

    if(userId)
    {
        userConnection.set(userId , ws)
    }else{
        ws.close(1008, 'Missing user ID for identification.'); 
        return;
    }

    /*
        Params để gửi có cấu trúc như sau

        {
            "to_user_id" : [
                "Mã User1",
                "Mã User2"
            ] ,
            "content" : "Tin Nhắn cần gửi"
        }
    */
     ws.on('message', function incoming(message : string) {
        try {
            const data = JSON.parse(message);
            
            if (data.to_user_id && data.content) {
                if(data.to_user_id.length > 1)
                {
                                    console.log("U has Pass this")

                    const targetWsArray : ws[] = []
                    const targetUserId : string [] = data.to_user_id;
                    targetUserId.forEach(element => {
                        const userWs =
                            userConnection.get(element)
                        if(userWs)
                        {
                            targetWsArray.push(userWs);
                        }else{
                            console.log("Error Can not Find User")
                        }
                    });

                    // Send Message To User

                    targetWsArray.forEach(wsUser => {
                        // Connect to user

                        const outgoingMessage = JSON.stringify({
                            type: 'INCOMING_MESSAGE',
                            from_user_id: userId, 
                            content: data.content
                        });

                        wsUser.send(outgoingMessage)
                    })

                    
                }else if(data.to_user_id.length == 1){
                     const targetWs = userConnection.get(data.to_user_id[0]);
                    if (targetWs && targetWs.readyState === WebSocket.OPEN) {
                    const outgoingMessage = JSON.stringify({
                        type: 'INCOMING_MESSAGE',
                        from_user_id: userId, 
                        content: data.content
                    });
                    
                    targetWs.send(outgoingMessage);
                    console.log(`➡️ Sent message from ${userId} to ${data.to_user_id}`);
                    } else {
                        // Đây là trong trường hợp nếu Connection Của người nhận Offline thì sẽ tiến hành 
                        // Lưu trong Database , DB là mongoDB
                    }
                }
            }
        } catch (e : any) {
            console.error('Error processing message:', e.message);
        }
    });

    // Nếu Client Đóng kết nối thì sẽ tiến hành ngắt kết nối và xóa map

    ws.on('close', function close() {
        if (userId) {
            // Tiến hành ngắt kết nối của Client
            userConnection.delete(userId);
            // Sau khi ngắt kết nối sẽ có Logic bộ đếm nó sẽ lưu trong bộ nhớ cached của Server
            // Nếu người dùng Connect lại thì sẽ ngắt biến đếm và sẽ set trạng thái isOnline = true
        }
    });
})
