  $(document).on('click', '.remove-selected-products', function(){
    
    var items = []
    $('.selected:checked').each(function() {
      // alert($(this).val())
      items.push($(this).val())
    });

    if (items.length == 0) {
      return;
    }


    var answer = confirm ("是否删除?");
    if (!answer) {
      return;
    }


    $.ajax({
      type: 'get',
      url: "/store/admin/products/remove_selected",
      data: {
        items: items,
      },
      success: function(data) {
        location.reload();
      },
      error: function(data) {
      }
    });

  });