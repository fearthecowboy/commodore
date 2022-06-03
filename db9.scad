use <./lib/polyround.scad>;
use <./lib/threads_v2p1.scad>

$fa=1;
$fs=0.4;

tolerance=.2;

h=9.3+tolerance;
tw=18.6+tolerance;
bw=16.3+tolerance;
holes=2.1;

module db9() {
  b = [
    [-tw/2,h/2,2],
    [tw/2,h/2,2],
    [bw/2,-h/2,2],
    [-bw/2,-h/2,2],
  ];

  rotate([90,0,90] ) linear_extrude(5) polygon(polyRound(b,50));
}

module db9_screws() {
  translate([-12,0]) circle(holes);
  translate([12,0]) circle(holes);
}

module db9_holes() {
  rotate([90,0,90] ) linear_extrude(2) translate([-12,0]) circle(holes);
  rotate([90,0,90] ) linear_extrude(2) translate([12,0]) circle(holes);
}

module db9_posts() {
   rotate([-90,0,90] ) translate([-12,0,-3.2]) RodEnd(5,3,3,2);
   rotate([-90,0,90] ) translate([12,0,-3.2]) RodEnd(5,3,3,2);
}

db9();

db9_posts();