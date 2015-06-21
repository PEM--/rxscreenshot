###*
 * # RxScreenshot: A reactive screenshot of your Blaze template.
 *
 * This class inherits from ReactiveVar.
###
class @RxScreenshot extends ReactiveVar
  ###*
   * C-tor: Create a reactive object that will be ready once the DOM elements
   * have been rendered.
   * @param  {Object}  tpl Blaze template.
   * @param  {String}  el  CSS selector of the element within the template.
   * @param  {Object}  styles A dictionary of styles to inline in the SVG
   *                          if the content is SVG based. It takes the form
   *                          of a CSS selector and a table of property to
   *                          inline.
   * @param  {Number}  width  Width's of the image, null for the viewport's
   *                          width.
  ###
  constructor: (tpl, el, styles = null, width = null) ->
    super false
    blazeElement = tpl.find el
    if blazeElement.nodeName is 'svg'
      # Create an off-screen canvas
      @canvas = document.createElement 'canvas'
      boundingBox = blazeElement.getBBox()
      @canvas.width = if width is null then boundingBox.width else width
      @canvas.height = boundingBox.height
      # Clone content that need to get drawn
      clone = (tpl.$ el).clone()
      # Inject styles
      unless styles is null
        for key, value of styles
          for cssAttr, cssVal of value
            (clone.find key).attr cssAttr, cssVal
      # Draw content on the off-screen canvas
      svg = clone[0].outerHTML
      canvg @canvas, svg,
        ignoreMouse: true
        ignoreAnimation: true
        renderCallback: => @set true
    else
      html2canvas blazeElement,
        width: width
        onrendered: (canvas) =>
          @canvas = canvas
          @set true
  ###*
   * Reactive function that returns the state of the screenshot.
   * @return {Boolean} true if screenshot has been rendered, false otherwise.
  ###
  ready: -> @get()
  ###*
   * Get the content of the screenshot as a Canvas.
   * @return {Canvas} Content of the screenshot.
  ###
  getCanvas: -> @canvas
  ###*
   * Get the content of the screenshot as a Buffer (see NodeJS).
   * @return {Buffer} Content of the screenshot.
  ###
  getBuffer: ->
    img = @canvas.toDataURL()
    data = img.replace /^data:image\/\w+;base64,/, ''
    new Buffer data, 'base64'

###*
 * # Buffer
 *
 * Buffer is exposed in browser's global scope.
###
Meteor.startup ->
  window.Buffer = window.buffer.Buffer
