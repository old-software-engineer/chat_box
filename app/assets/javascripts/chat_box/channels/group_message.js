App.chat_box_group_message = App.cable.subscriptions.create({channel:"ChatBox::GroupMessageChannel"},{
    connected: function() {},
    disconnected: function() {},
    received: function(data) {
        var conversation = $('#chat-box-container').find("[data-group-conversation-id='" + data['group_id'] + "']");

        if (data['window'] !== undefined) {
            var conversation_visible = conversation.is(':visible');

            if (conversation_visible) {
                var messages_visible = (conversation).find('.panel-body').is(':visible');

                if (!messages_visible) {
                    conversation.removeClass('panel-default').addClass('panel-success');
                }
                conversation.find('.messages-list').find('ul').append(data['message']);
            }
            else {
                $('#chat-box-container').append(data['window']);
                conversation = $('#chat-box-container').find("[data-group-conversation-id='" + data['group_id'] + "']");
                conversation.find('.panel-body').toggle();
            }
        }
        else {
            conversation.find('ul').append(data['message']);
        }

        var messages_list = conversation.find('.messages-list');
        var height = messages_list[0].scrollHeight;
        messages_list.scrollTop(height);
    },
    speak: function(message) {
        return this.perform('speak', {
            message: message
        });
    }
});

$(document).on('submit', '.group_message', function(e) {
    e.preventDefault();
    var values = $(this).serializeArray();
    App.chat_box_group_message.speak(values);
    $(this).trigger('reset');
});