(function() {
    $(document).on('click', '.toggle-window', function(e) {
        e.preventDefault();
        var panel = $(this).parent().parent();
        var messages_list = panel.find('.messages-list');

        panel.find('.panel-body').toggle();
        panel.attr('class', 'panel panel-default');

        if (panel.find('.panel-body').is(':visible')) {
            var height = messages_list[0].scrollHeight;
            messages_list.scrollTop(height);
        }
    });

    $(document).on('click','[data-select="user"]',function(e){
      var $user_input = $('[data-selected="user"]')
      var selected_ids = JSON.parse($user_input.val());
      if ($(this).prop("checked")) {
        selected_ids.push(this.value);
      }else{
        selected_ids.splice(selected_ids.indexOf(this.value),1);
      }
      $($user_input).val(JSON.stringify(selected_ids))
    })
})();