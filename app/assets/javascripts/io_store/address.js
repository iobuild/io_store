  $(document).on('change', '#address_province', function(){

    name = $(this).val()

    $.ajax({
      type: 'get',
      url: "/store/addresses/get_cities",
      data: {
        name: name
      },
      success: function(data) {
        $('#address_city')
           .find('option').remove().end()

        $('#address_city').append($("<option>请选择市</option><option></option>"))

        $.each(data, function(key, value) {   
         $('#address_city')
           .append($("<option></option>")
           .attr("value", value)
           .text(value));
        });

        $('.cities').show()
      },
      error: function(data) {
      }
    });

  });


  $(document).on('change', '#address_city', function(){

    parent_name = $('#address_province').val()
    name = $(this).val()

    $.ajax({
      type: 'get',
      url: "/store/addresses/get_sub_cities",
      data: {
        parent_name: parent_name,
        name: name
      },
      success: function(data) {
        $('#address_sub_city')
           .find('option').remove().end()

        $('#address_sub_city').append($("<option>请选择县</option><option></option>"))

        $.each(data, function(key, value) {   
         $('#address_sub_city')
           .append($("<option></option>")
           .attr("value",key)
           .text(value));
        });

        $('.sub_cities').show()
      },
      error: function(data) {
      }
    });

  });



  $(document).on('click', '#address_tab a', function(e){
    e.preventDefault()
    $(this).tab('show')

    text = $(this).data('id')
    if (text == '1') {
      $('#select-address').show()
      $('#new-address').hide()
    }

    if (text == '2') {
      $('#select-address').hide()
      $('#new-address').show()
    }

  })


