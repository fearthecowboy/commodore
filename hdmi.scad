use <./lib/polyround.scad>;
use <./tools.scad>

$fa=1;
$fs=0.4;

tolerance = .2;

height=6.4+tolerance;
top_width=16.3+tolerance;
mid_point=((height/2)-4.9)+tolerance;
inside_bend = 13.1+tolerance;
bottom_width=10.6+tolerance;
depth = 6+tolerance;

module hdmi(scalex=1, scaley=1) {
  b = [
    [-top_width*scalex/2,height*scaley/2,1],
    [top_width*scalex/2,height*scaley/2,1],

    [top_width*scalex/2,mid_point*scaley,1],
    [inside_bend*scalex/2,mid_point*scaley,1],

    [bottom_width*scalex/2,-height*scaley/2,1],
    [-bottom_width*scalex/2,-height*scaley/2,1],
    [-inside_bend*scalex/2,mid_point,1],
    [-top_width*scalex/2,mid_point,1],
  ];

  // scale_about_pt(scale,[0,0,0]) {
    translate([0,depth/2,0]) rotate([90,0,0] ) linear_extrude(height=depth,false) polygon(polyRound(b,50));
  //
}

  hdmi();
