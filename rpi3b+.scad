use <./lib/threads_v2p1.scad>
use <./usbports.scad>
use <./hdmi.scad>
use <./rj45.scad>


$fa=1;
$fs=0.4;

board_width=85;
board_height=56;
board_thickness=1.6;
overhang=2.1;

p1_x=3.5;
p1_y=+3.5;

p2_x=p1_x+58;
p2_y=p1_y;

p3_x=p1_x;
p3_y=board_height-3.5;

p4_x=p2_x;
p4_y=p3_y;

post_height=7;

module posts(debug=false) {
  color("red") translate([p1_x,p1_y,0]) RodEnd(5,7,5,2);
  color("green") translate([p2_x,p2_y,0]) RodEnd(5,7,5,2);
  color("blue") translate([p3_x,p3_y,0]) RodEnd(5,7,5,2);
  translate([p4_x,p4_y,0]) RodEnd(5,7,5,2);
  if( debug ) {
    %translate([0,0,post_height] ) cube([85,56,board_thickness]);
    %ports();
    %back_ports();
  }
}
 
module ports(scale=1) {
  translate([board_width+1,2.3,post_height+board_thickness]) rotate([0,0,90])  rj45(scale);
  translate([board_width+1,21.8,post_height+board_thickness]) rotate([0,0,90]) usbBlock(scale);
  translate([board_width+1,39.8,post_height+board_thickness]) rotate([0,0,90]) usbBlock(scale);
  // color("cyan") translate([board_width+overhang,9.3,8.2]) rotate([-90,0,90] ) linear_extrude(height=17,false) usbBlock();
}

module back_ports() {
  
  translate([6.9,-1,post_height+board_thickness]) rotate([0,0,0]) usbPower();
  translate([24.1,-1,post_height+board_thickness]) rotate([0,0,0]) hdmi();

  translate([53.6,4,3.5+post_height+board_thickness]) rotate([90,0,0]) cylinder(7,4,4, center=false);
  translate([53.6,1.5,3.5+post_height+board_thickness]) rotate([90,0,0]) cylinder(7,6,6, center=false);

}


posts(true);
ports();
back_ports();

