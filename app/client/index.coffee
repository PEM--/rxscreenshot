Template.textTest.events
  'click button': (e, t) ->
    console.log 'Screenshot', t
    selector = '[data-role=\'screenshot\']'
    screenshot = new RxScreenshot t, selector, null, 400
    t.autorun ->
      if screenshot.ready()
        console.log 'Screenshot added'
        (t.$ selector).parent().append screenshot.getCanvas()

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
