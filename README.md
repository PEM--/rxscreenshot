# Reactive screenshots
Create reactively a PNG as a Buffer from elements within your Blaze template.

## Installation
```bash
meteor add pierreeric:rxscreenshot
```

## Example usages
### Simple DOM
In this example, a template named `textTest` screenshotted and its canvas
results is appended to the DOM.

Here's the template in Jade:
```jade
template(name='textTest')
  button Screenshot this
  div(data-role='screenshot')
    h1 Title test
    p Paragraph test
```

And its logic in CS:
```coffee
Template.textTest.events
  'click button': (e, t) ->
    console.log 'Screenshot', t
    selector = '[data-role=\'screenshot\']'
    screenshot = new RxScreenshot t, selector, null, 400
    t.autorun ->
      if screenshot.ready()
        console.log 'Screenshot added'
        (t.$ selector).parent().append screenshot.getCanvas()
```

### SVG specific case
For SVG, the case is different. If styles are declared in a CSS files, the
styles must be inlined within the SVG for the screenshot to work.

For this example, the SVG is created using [D3](http://d3js.org/).

In this example, a template named `svgTest` is filled with a bar graph. The
CSS styles are injected in the screenshot.

Here's the template in Jade:
```jade
template(name='svgTest')
  button Screenshot this
  br
  svg.chart
```

The CSS file is in Stylus:
```stylus
.chart
  rect
    fill steelblue
  text
    fill white
    font 10px sans-serif
    text-anchor middle
```

Here is the required logic in CS for creating the D3 chart, injecting the
styles into the screenshot and append the canvas to the DOM:
```coffee
Template.svgTest.onRendered ->
  console.log 'Set SVG scene'
  width = 400
  height = 200
  y = d3.scale.linear().range [height, 0]
  chart = d3.select('.chart').attr('width', width).attr 'height', height
  type = (d) ->
    d.value = +d.value
    # coerce to number
    d
  d3.tsv 'data.tsv', type, (error, data) ->
    y.domain [
      0
      d3.max data, (d) -> d.value
    ]
    barWidth = width / data.length
    bar = chart
      .selectAll 'g'
      .data data
      .enter()
      .append 'g'
      .attr 'transform', (d, i) ->
        'translate(' + i * barWidth + ',0)'
    bar
      .append 'rect'
      .attr 'y', (d) ->
        y d.value
      .attr 'height', (d) ->
        height - y(d.value)
      .attr 'width', barWidth - 1
    bar
      .append 'text'
      .attr 'x', barWidth / 2
      .attr 'y', (d) ->
        y(d.value) + 3
      .attr 'dy', '.75em'
      .text (d) -> d.value

Template.svgTest.events
  'click button': (e, t) ->
    console.log 'Screenshot', t
    selector = 'svg.chart'
    screenshot = new RxScreenshot t, selector
    ,
      rect: fill: 'steelblue'
      text:
        fill: 'white'
        font: '10px sans-serif'
        'text-anchor': 'middle'
    , 400
    t.autorun ->
      if screenshot.ready()
        console.log 'Screenshot added'
        (t.$ selector).parent().append screenshot.getCanvas()
```

## API
[API](doc/api.md)

## Links
* [Buffer](https://nodejs.org/api/buffer.html)
* [EventedMind's WaitList](https://www.eventedmind.com/feed/the-reactive-waitlist-data-structure)
* [WaitList](https://github.com/iron-meteor/iron-controller/blob/master/lib/wait_list.js)
* [html2canvas](http://html2canvas.hertzen.com/)
* [cangv](https://github.com/gabelerner/canvg)

## FAQ
### Contributions
Contributions are very welcomed. Feel free to PR for enhancing this package.

### Testing
A test application is provided in the `app` folder.

### Enhancing documentation
API's documentation uses [DocBlockr](https://atom.io/packages/docblockr) syntax.
Generates the API's documentation using [markdox](https://github.com/cbou/markdox).

```bash
markdox RxScreenshot.coffee -o doc/api.md
```
