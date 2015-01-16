

  $(document).on('click', '.products .move-to-trash', function(){
    
    var items = []
    $('.selected:checked').each(function() {
      // alert($(this).val())
      items.push($(this).val())
    });

    if (items.length == 0) {
      return;
    }


    var answer = confirm ("是否把商品下架?");
    if (!answer) {
      return;
    }


    $.ajax({
      type: 'get',
      url: "/store/admin/products/move_to_trash",
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


  $(document).on('click', '.products .clear-selected-trash', function(){
    
    var items = []
    $('.selected:checked').each(function() {
      // alert($(this).val())
      items.push($(this).val())
    });

    if (items.length == 0) {
      return;
    }


    var answer = confirm ("是否永久删除?");
    if (!answer) {
      return;
    }


    $.ajax({
      type: 'get',
      url: "/store/admin/products/clear_selected_trash",
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



  $(document).on('click', '.products .restore-selected-trash', function(){
    
    var items = []
    $('.selected:checked').each(function() {
      // alert($(this).val())
      items.push($(this).val())
    });

    if (items.length == 0) {
      return;
    }


    var answer = confirm ("是否重新上架?");
    if (!answer) {
      return;
    }


    $.ajax({
      type: 'get',
      url: "/store/admin/products/restore_selected_trash",
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