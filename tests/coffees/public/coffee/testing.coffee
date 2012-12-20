$(document).ready((ev) ->
    inpH = null
    $("#dd ul.dropdown-menu li a").bind('click', ->
       txt = $(this).text() 
       $("#dd button.btn span.text").text(txt) 

       if inpH
           inpH.remove()

       inpH = $('<input type="hidden" name="prio" />').val(txt)
       $(this).parents('form').append(inpH)
    )
    $("td.todo").live('swiperight', (e) ->
        $(".modal").modal('show')
        $.get('/todo/do', { id: $(this).attr('lid') }, (res) ->
            $('#todoRes').html(res)
            $(".modal").modal('hide')
        )
    )
)
