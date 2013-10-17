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
            <p class='sender-name'>#{submission.sender}</p>
            <p class='time'>#{submission.time}</p>
            </div>
          </div>
          """
    div

  names.forEach (submission) ->
    $body.append divIt(submission)
