use <./lib/polyround.scad>;
use <./tools.scad>

$fa=1;
$fs=0.4;
/*
tolerance = .2;

height=(14+tolerance)/2;
width=(16.3+tolerance)/2;
depth=21; 



module rj45() {
  b = [
    [-width,height,.5],
    [width,height,.5],

    [width,-height,.5],
    [-width,-height,.5]
  ];

//  scale_about_pt(1.1,[width,height,0]) translate([width,depth,height]) rotate([90,0,0] ) linear_extrude(height=depth,false) polygon(polyRound(b,50));
  translate([width,0,height]) color ("red",strue) cube([1,1,1]);

}

rotate_about_pt([0,90,0]) rj45();
*/

tolerance = .2;

height=(14+tolerance);
width=(16.3+tolerance);
depth=21; 

center_x=width/2;
center_y=height/2;

module rj45(scalefactor=1) {
  b = [
    [0,height,.5],
    [width,height,.5],

    [width,0,.5],
    [0,0,.5]
  ];

  scale_about_pt(scalefactor,[center_x,center_y,0]) translate([0,depth,0]) rotate([90,0,0] ) linear_extrude(height=depth,false) polygon(polyRound(b,50));
  translate([center_x,0,center_y]) color ("red",true) cube([1,1,1]);

}


rj45();