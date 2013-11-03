jQuery ($) ->
  names = _.shuffle window.bandnames
  $body = $('body')

  divIt = (submission) ->
    div = """
          <div class='name-container'>
            <div class='bandname'>
            #{submission.name}
            </div>
            <div class='detail'>
            <p class='bandname-focus'>#{submission.name}</p>
            <p class='time'>#{submission.time} by #{submission.sender}</p>
            </div>
          </div>
          """
    div

  names.forEach (submission) ->
    $body.append divIt(submission)

  $(document).on 'mouseenter', '.name-container', (e) ->
    $deet = $(@).find('.detail')
    $deet.fadeToggle(100)
    console.log $deet.offset()

  $(document).on 'mouseleave', '.name-container', (e) ->
    $(@).find('.detail').fadeToggle(100)
