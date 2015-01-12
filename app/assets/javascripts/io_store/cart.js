// $(document).ready(function() {
// $(document).on('ready page:load', function () {

  // $('.add-to-cart').click(function() {
  $(document).on('click', '.add-to-cart', function(){

    var cart = $('.shopping-cart');
    var imgtodrag = $(this).parent('p').parent('td').parent('tr').find("img").eq(0);
    if (imgtodrag) {
      var imgclone = imgtodrag.clone()
          .offset({
          top: imgtodrag.offset().top,
          left: imgtodrag.offset().left
      })
          .css({
          'opacity': '0.5',
              'position': 'absolute',
              'height': '150px',
              'width': '150px',
              'z-index': '100'
      })
          .appendTo($('body'))
          .animate({
          'top': cart.offset().top + 10,
              'left': cart.offset().left + 10,
              'width': 75,
              'height': 75
      }, 1000, 'easeInOutExpo');
      
      setTimeout(function () {
          cart.effect("shake", {
              times: 2
          }, 200);
      }, 1500);

      imgclone.animate({
          'width': 0,
              'height': 0
      }, function () {
          $(this).detach()
      });
    }




    id = $(this).data('id')

    // alert(id);

    $.ajax({
      type: 'get',
      url: "/store/carts/add",
      data: {
        id: id
      },
      success: function(data) {
        $('#cart-number').html('(' + data + ')')
      },
      error: function(data) {
      }
    });

  });



  // $('.remove-cart-item').click(function() {
  $(document).on('click', '.remove-cart-item', function(){
    var answer = confirm ("是否删除?");
    if (!answer) {
      return;
    }

    id = $(this).data('id')

    // alert(id);

    $.ajax({
      type: 'get',
      url: "/store/carts/remove_item",
      data: {
        id: id
      },
      success: function(data) {
        $('.ajax-file').html(data)
        // location.reload();
        // $('.cart-item-' + id).remove()
      },
      error: function(data) {
      }
    });

  });




  // $('.increase-quantity').click(function() {
  $(document).on('click', '.increase-quantity', function(){

    id = $(this).data('id')

    quantity = $('.quantity-' + id).html()
    new_quantity = parseInt(quantity) + 1



    // alert(id);

    $.ajax({
      type: 'get',
      url: "/store/carts/increase_quantity",
      data: {
        id: id,
        new_quantity: new_quantity
      },
      success: function(data) {
        // $('.ajax-file').html(data)
        $('.quantity-' + id).html(new_quantity)
        $('#total-amount').html(data['cart_amount'])
        $('#item-amount-' + id).html(data['item_amount'])
      },
      error: function(data) {
      }
    });

  });



  // $('.decrease-quantity').click(function() {
  $(document).on('click', '.decrease-quantity', function(){

    id = $(this).data('id')

    quantity = $('.quantity-' + id).html()
    new_quantity = parseInt(quantity) - 1

    if (new_quantity == 0) {
      return;
    }

    // alert(id);

    $.ajax({
      type: 'get',
      url: "/store/carts/decrease_quantity",
      data: {
        id: id,
        new_quantity: new_quantity
      },
      success: function(data) {
        // $('.ajax-file').html(data)
        $('.quantity-' + id).html(new_quantity)
        $('#total-amount').html(data['cart_amount'])
        $('#item-amount-' + id).html(data['item_amount'])
      },
      error: function(data) {
      }
    });

  });




  // $('.select-all').click(function() {
  $(document).on('click', '.select-all', function(){

    $('.selected').prop('checked', this.checked);

  });



  // $('.remove-selected').click(function() {
  $(document).on('click', '.remove-selected', function(){
    
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
      url: "/store/carts/remove_selected_items",
      data: {
        items: items,
      },
      success: function(data) {
        $('.ajax-file').html(data)
        // location.reload();
      },
      error: function(data) {
      }
    });

  });


// });

