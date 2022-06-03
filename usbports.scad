use <./lib/polyround.scad>;
use <./lib/tools.scad>

$fa=1;
$fs=0.4;

tolerance = .2;

height=15.7+tolerance;
width=15.3+tolerance;
depth=17;


module usbBlock(scale=1) {
  b = [
    [-width/2,height/2,.5],
    [width/2,height/2,.5],

    [width/2,-height/2,.5],
    [-width/2,-height/2,.5]
  ];

scale_about_pt(scale,[0,0,0])
  translate([width/2,depth,height/2]) rotate([90,0,0] ) linear_extrude(height=depth,false) polygon(polyRound(b,50));
}


power_height = 3+tolerance;
power_width = 8+tolerance;
power_bottom = 6+tolerance;

module usbPower() { 
  b = [
      [-power_width/2,power_height/2,.5],
      [power_width/2,power_height/2,.5],

      [power_width/2,0,.5],

      [power_bottom/2,-power_height/2,.5],
      [-power_bottom/2,-power_height/2,.5],

      [-power_width/2,0,.5],
    ];

  translate([0,3,0]) rotate([90,0,0] ) linear_extrude(height=6,false)  polygon(polyRound(b,50));
  translate([0,3,0]) scale(1.5) rotate([90,0,0] ) linear_extrude(height=2,false)  polygon(polyRound(b,50));
}

usbPower();
//usbBlock();

