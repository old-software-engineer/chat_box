App.chat_box_online_users = App.cable.subscriptions.create({channel:"ChatBox::OnlineUsersChannel"},{
    connected: function() {
    },
    disconnected: function() {
    },
    received: function(data) {
        let online = document.querySelector("#chat_box_online_users")
        let el = online.querySelector(`[data-id='${data.id}']`)

        if (el != null) {
            el.remove()
            if (data.online){
                online.insertAdjacentHTML('afterbegin', data.html)
            }else {
                online.insertAdjacentHTML('beforeend', data.html)
            }
        }
    }
});
