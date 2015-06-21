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
   * @param  {Number}  width  Width's of the image, null for the viewport's
   *                          width.
  ###
  constructor: (tpl, el, width = null) ->
    super false
    blazeElement = tpl.find el
    html2canvas blazeElement,
      width: width
      onrendered: (canvas) =>
        @canvas = canvas
        @set true
        console.log 'Canvas', @canvas
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
  getBuffer: -> @canvas

###*
 * # Buffer
 *
 * Buffer is exposed in browser's global scope.
###
Meteor.startup ->
  window.Buffer = window.buffer.Buffer
