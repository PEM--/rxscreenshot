Template.textTest.events
  'click button': (e, t) ->
    console.log 'Screenshot', t
    selector = '[data-role=\'screenshot\']'
    screenshot = new RxScreenshot t, selector, 400
    t.autorun ->
      if screenshot.ready()
        console.log 'Screenshot added'
        (t.$ selector).parent().append screenshot.getCanvas()
