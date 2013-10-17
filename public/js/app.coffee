jQuery ($) ->
  names = window.bandnames
  $body = $('body')

  divIt = (submission) ->
    div = """
          <div class='name-container'>
            <div class='bandname'>
            #{submission.name}
            </div>
            <div class='sender'>
            <p class='bandname-focus'>#{submission.name}</p>
            <p class='sender-name'>#{submission.sender}</p>
            <p class='time'>#{submission.time}</p>
            </div>
          </div>
          """
    div

  names.forEach (submission) ->
    $body.append divIt(submission)

  $(document).on 'mouseenter', '.name-container', (e) ->
    $(@).find('.sender').fadeToggle(100)

  $(document).on 'mouseleave', '.name-container', (e) ->
    $(@).find('.sender').fadeToggle(100)
