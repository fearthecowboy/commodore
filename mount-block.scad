
tolerance = .2;

module mountblock_punchout(innerW, innerH, depth) {
  translate([0,-1,1.22]) rotate([90,0,0] )  cube([innerW+tolerance, innerH+tolerance+2.5, depth+2+tolerance], center=true); 
  //translate([0,-1,0]) rotate([90,0,0] )  cube([innerW+tolerance, innerH+tolerance, depth+2+tolerance], center=true); 
}

module mountblock(innerW, innerH, depth) {
  difference() {
    rotate([90,0,0] ) cube([innerW+5, innerH+5, depth], center=true);
    mountblock_punchout(innerW,innerH,depth);
  }
}


mountblock(20.7,11.7,30);