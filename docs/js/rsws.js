window.fly_plane = function(args) {
  var scale = "scale(-1.4,1.4)"
  var start = null;
  var plane = d3.select("#plane")

  function step(timestamp) {
    if (!start) start = timestamp;
    var progress = timestamp - start - 1000;
    var x =  progress * args.v + 0.5 * progress ** 2 * args.a;
    console.log(progress)
    console.log(x)
    plane.attr('transform', 'translate(' + x + ',' + 200 +')' + scale)
    if (progress < 0) {
      plane.attr('transform', 'translate(' + 0 + ',' + 200 +')' + scale)
    }
    if (progress < 8000) {
      window.requestAnimationFrame(step);
    } else {
      //plane.attr('transform', 'translate(' + -400 + ',' + 200 +')' + scale)
    }
  }
  window.requestAnimationFrame(step);
}
