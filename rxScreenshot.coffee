###*
 * # RxBufferDownload: A reactive binary asset downloader
 *
 * This class inherits from ReactiveVar.
 * Downloads are performed using the XMLHttpRequest v2 method with a type
 * set on 'arraybuffer'.
 *
 * It requires:
 *
 * - Buffer: The same NodeJS package for the browser).
 * - ArrayBufferToBuffer: A transformation function from ArrayBuffer
 *   into Buffer.
###
class @RxScreenshot extends ReactiveVar
  ###*
   * C-tor: Create a reactive object that will be ready once the DOM elements
   * have been rendered.
   * @param  {String}  url  URL of the requested ressources.
  ###
  constructor: (url) ->
    super false
    @req = new XMLHttpRequest
    @req.open 'GET', url, true
    @req.responseType = 'arraybuffer'
    @resp = null
    @req.onload = (e) =>
      @resp = @req.response
      @set true
    @req.send null
  ###*
   * Reactive function that returns the state of the downloaded asset.
   * @return {Boolean} true if asset has been downloaded, false otherwiser.
  ###
  ready: -> @get()
  ###*
   * Get the content of the downloaded asset as a Buffer (see NodeJS).
   * @return {Buffer} Content of the downloaded asset.
  ###
  getBuffer: -> ArrayBufferToBuffer @resp

###*
 * # Buffer
 *
 * Buffer is exposed in browser's global scope.
###
Meteor.startup ->
  window.Buffer = window.buffer.Buffer
