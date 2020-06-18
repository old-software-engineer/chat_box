App.chat_box_group_conversation = App.cable.subscriptions.create({channel:"ChatBox::GroupConversationChannel"},{
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
        let online = document.querySelector("#chat_box_online_users")
        if ( data['group-id'] !== undefined && $("[data-group-id='" + data['group-id'] +"']").length !== 1){
            online.insertAdjacentHTML('afterbegin', data.html)
        }
    }
});