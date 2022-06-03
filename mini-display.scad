use <./lib/threads_v2p1.scad>

post_distance = 22.5;

width=24.9;
height=14.4;

from_bottom=5.15;
from_top=4.20;

module display_posts() {
  rotate([0,90,90]) {
  color("red") translate([post_distance/2,post_distance/2,-.5]) RodEnd(3.5,3,3,1.9);
  color("red") translate([-post_distance/2,post_distance/2,-.5]) RodEnd(3.5,3,3,1.9);
  color("red") translate([post_distance/2,-post_distance/2,-.5]) RodEnd(3.5,3,3,1.9);
  color("red") translate([-post_distance/2,-post_distance/2,-.5]) RodEnd(3.5,3,3,1.9);
  }
  //%cube([26,1,26],center=true);
}

module display_screen() {
  //color("blue") translate([0,1,.9])  cube([width,8,height],center=true);
  color("blue") translate([0,1,.9+0.75])  cube([width,8,height],center=true);
}

module display_inset() {
  translate([0,5.1,-0.5]) cube([27,10,27.4],center=true);
}

display_posts();
display_screen();
display_inset();