

<!-- Start RxScreenshot.coffee -->

# RxScreenshot: A reactive screenshot of your Blaze template.

This class inherits from ReactiveVar.

## RxScreenshot(tpl, el, styles, width)

C-tor: Create a reactive object that will be ready once the DOM elements
have been rendered.

### Params:

* **Object** *tpl* Blaze template.
* **String** *el* CSS selector of the element within the template.
* **Object** *styles* A dictionary of styles to inline in the SVG                          if the content is SVG based. It takes the form
                         of a CSS selector and a table of property to
                         inline.
* **Number** *width* Width's of the image, null for the viewport's                          width.

## ready()

Reactive function that returns the state of the screenshot.

### Return:

* **Boolean** true if screenshot has been rendered, false otherwise.

## getCanvas()

Get the content of the screenshot as a Canvas.

### Return:

* **Canvas** Content of the screenshot.

## getBuffer()

Get the content of the screenshot as a Buffer (see NodeJS).

### Return:

* **Buffer** Content of the screenshot.

# Buffer

Buffer is exposed in browser's global scope.

<!-- End RxScreenshot.coffee -->

