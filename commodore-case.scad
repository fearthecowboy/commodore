
use <./rpi3b+.scad>
use <lib/boxes.scad>;
use <lib/screw.scad>;
use <lib\hollow.scad>;
use <lib\bezier.scad>;
use <c-logo.scad>;
use <db9.scad>;
use <hdmi.scad>;
use <mount-block.scad>;
use <usbports.scad>;
use <./lib/threads_v2p1.scad>
use <./mini-display.scad>

$fa = 3;
$fs = 0.3;

x=20.7;
y=11.7;


// Position of the Raspberry Pi 3B+ board 
RPI_X = 89;
RPI_Y = 80; // 174.5 at the back
RPI_Z = 2;
PUNCH_OUT_DEPTH = 4;

CASE_THICKNESS=3;
CASE_DEPTH=205;
CASE_WIDTH=180;
CASE_HEIGHT=60;
RIDGE_LENGTH=200;

MUCH_BIGGER = 300;

CONTROL_PORT_OFFSET = 35;
CONTROL_PORT_SPACING= 35;
CONTROL_PORT_Z = 12;

POST_FROM_SIDE = 18;
POST_FROM_FRONT = 16;
POST_FROM_BACK = 50;

DISPLAY_OFFSET = 30;

ROTATE_TO_TRUE = [0, 0, 180];
ROTATE_TO_BACK = [-90, 180, 0];
ROTATE_TO_RIGHT_SIDE= [-90, 180, -90];

RIDGES_START=CASE_DEPTH-40;
RIDGES_END=CASE_DEPTH-20;

module tube(od=1.5, id=1.5, h=1) {
  difference() {
    cylinder(h, d=od, center = true);
    translate([0,0,0.01]) cylinder(h+.03, d=id, center = true);
  }
}

module case () {
  difference() {

    // box
   difference() {
      translate([CASE_WIDTH, 0, CASE_HEIGHT]) rotate([0, 90, 90]) roundedCube(size = [60, CASE_WIDTH, CASE_DEPTH], r = 5, sidesonly = true);
      translate([CASE_WIDTH-CASE_THICKNESS, 0-CASE_THICKNESS, CASE_HEIGHT-CASE_THICKNESS]) rotate([0, 90, 90]) roundedCube(size = [54, CASE_WIDTH-6, CASE_DEPTH+5], r = 5, sidesonly = true);
    }

    for (i = [RIDGES_START:4:RIDGES_END]) {
      translate([0, i, CASE_HEIGHT-2]) cube([RIDGE_LENGTH, 2, 3]);  
    }
   
    // top logo 
    translate([86, 100, 55.5]) resize([30], auto = true)  CommodoreLogo();

    // cut out joystick jacks 
    translate([CASE_WIDTH-4, CONTROL_PORT_OFFSET, CONTROL_PORT_Z])  db9();
    translate([CASE_WIDTH-4, CONTROL_PORT_OFFSET+CONTROL_PORT_SPACING , CONTROL_PORT_Z])  db9();

    translate([CASE_WIDTH-4, CONTROL_PORT_OFFSET, CONTROL_PORT_Z]) db9_holes();
    translate([CASE_WIDTH-4,  CONTROL_PORT_OFFSET+CONTROL_PORT_SPACING, CONTROL_PORT_Z]) db9_holes();

    // cut out  side ports for RPI
    translate([RPI_X - PUNCH_OUT_DEPTH, RPI_Y, RPI_Z]) rotate(ROTATE_TO_TRUE) ports(1.05);

    // bottom foot holes
    translate([CASE_WIDTH-POST_FROM_SIDE, POST_FROM_FRONT, 0]) color("red") cylinder(3.5, d = 12, center = true);
    translate([POST_FROM_SIDE, CASE_DEPTH-POST_FROM_BACK, 0]) color("blue") cylinder(3.5, d = 12, center = true);
    translate([POST_FROM_SIDE, POST_FROM_FRONT, 0]) color("orange") cylinder(3.5, d = 12, center = true);
    translate([CASE_WIDTH-POST_FROM_SIDE, CASE_DEPTH-POST_FROM_BACK, 0]) color("yellow") cylinder(3.5, d = 12, center = true);

    // screw holes
    translate([CASE_WIDTH-POST_FROM_SIDE, POST_FROM_FRONT, 3]) color("green") cylinder(3.5, d = 4, center = true);
    translate([POST_FROM_SIDE, CASE_DEPTH-POST_FROM_BACK, 3]) color("green") cylinder(3.5, d = 4, center = true);
    translate([POST_FROM_SIDE, POST_FROM_FRONT, 3]) color("green") cylinder(3.5, d = 4, center = true);
    translate([CASE_WIDTH-POST_FROM_SIDE, CASE_DEPTH-POST_FROM_BACK, 3]) color("green") cylinder(3.5, d = 4, center = true);
    
    translate([CASE_WIDTH-DISPLAY_OFFSET,-1,16]) display_inset();
  }

  // rings on the top of the screw posts
  RING_Z = 18;
  translate([CASE_WIDTH-POST_FROM_SIDE, POST_FROM_FRONT, RING_Z]) color("cyan") tube( 14,12.5,3);
  translate([POST_FROM_SIDE, CASE_DEPTH-POST_FROM_BACK, RING_Z]) color("cyan") tube( 14,12.5,3);
  translate([POST_FROM_SIDE, POST_FROM_FRONT, RING_Z]) color("cyan") tube( 14,12.5,3);
  translate([CASE_WIDTH-POST_FROM_SIDE, CASE_DEPTH-POST_FROM_BACK,RING_Z]) color("cyan") tube( 14,12.5,3);

  // screw hole posts
  translate([CASE_WIDTH-POST_FROM_SIDE, POST_FROM_FRONT, 9.5]) color("white") tube( 14,4,14);
  translate([POST_FROM_SIDE, CASE_DEPTH-POST_FROM_BACK, 9.5]) color("white") tube( 14,4,14);
  translate([POST_FROM_SIDE, POST_FROM_FRONT, 9.5]) color("white") tube( 14,4,14);
  translate([CASE_WIDTH-POST_FROM_SIDE, CASE_DEPTH-POST_FROM_BACK,9.5]) color("white") tube( 14,4,14);

  // screw hole plate
  translate([CASE_WIDTH-POST_FROM_SIDE, POST_FROM_FRONT, 16.25]) color("pink") tube( 12,2,1);
  translate([POST_FROM_SIDE, CASE_DEPTH-POST_FROM_BACK, 16.25]) color("pink") tube( 12,2,1);
  translate([POST_FROM_SIDE, POST_FROM_FRONT, 16.25]) color("pink") tube( 12,2,1);
  translate([CASE_WIDTH-POST_FROM_SIDE, CASE_DEPTH-POST_FROM_BACK,16.25]) color("pink") tube( 12,2,1);

  // posts for the RPI board
  translate([RPI_X, RPI_Y, RPI_Z]) rotate(ROTATE_TO_TRUE)  posts(true);

  translate([CASE_WIDTH-PUNCH_OUT_DEPTH, CONTROL_PORT_OFFSET, CONTROL_PORT_Z]) db9_posts();
  translate([CASE_WIDTH-PUNCH_OUT_DEPTH, CONTROL_PORT_OFFSET+CONTROL_PORT_SPACING, CONTROL_PORT_Z]) db9_posts();

  // back panel
  
  difference() {
    translate([0, CASE_DEPTH-1, 0]) rotate([90, 0, 0]) roundedCube(size = [CASE_WIDTH, CASE_HEIGHT, CASE_THICKNESS], r = 5, sidesonly = true);
    // cut out the RPI back ports
    translate([RPI_X, RPI_Y + PUNCH_OUT_DEPTH, RPI_Z])  rotate(ROTATE_TO_TRUE)  back_ports();

    // hdmi jack
    translate([50, CASE_DEPTH-PUNCH_OUT_DEPTH, 13]) hdmi();

    // hdmi mount
    color("white") translate([50,CASE_DEPTH-17.5,13])  mountblock_punchout(20.7,11.7,30);
  }
  // back panel text
  color("green") translate([135, CASE_DEPTH-2, 24])  rotate(ROTATE_TO_BACK) linear_extrude(2.5)  text("POWER", size = 4, font = "MicrogrammaDBolExt:style=Regular");
  color("green") translate([66.6, CASE_DEPTH-2, 19])  rotate(ROTATE_TO_BACK) linear_extrude(2.5)  text("HDMI OUT", size = 4, font = "MicrogrammaDBolExt:style=Regular");
  color("green") translate([171, CASE_DEPTH-2, 27.75])  rotate(ROTATE_TO_BACK) linear_extrude(2.5)  text("ON", size = 3, font = "MicrogrammaDBolExt:style=Regular");

  // side panel text
  color("green") translate([178.5, CONTROL_PORT_OFFSET, CONTROL_PORT_Z+9])  rotate(ROTATE_TO_RIGHT_SIDE) linear_extrude(2.5)  text("Control", size = 3, font = "MicrogrammaDBolExt:style=Regular",halign="center");
  color("green") translate([178.5, CONTROL_PORT_OFFSET, CONTROL_PORT_Z+6])  rotate(ROTATE_TO_RIGHT_SIDE) linear_extrude(2.5)  text("Port 1", size = 3, font = "MicrogrammaDBolExt:style=Regular",halign="center");

  color("green") translate([178.5, CONTROL_PORT_OFFSET+CONTROL_PORT_SPACING, CONTROL_PORT_Z+9])  rotate(ROTATE_TO_RIGHT_SIDE) linear_extrude(2.5)  text("Control", size = 3, font = "MicrogrammaDBolExt:style=Regular",halign="center");
  color("green") translate([178.5, CONTROL_PORT_OFFSET+CONTROL_PORT_SPACING, CONTROL_PORT_Z+6])  rotate(ROTATE_TO_RIGHT_SIDE) linear_extrude(2.5)  text("Port 2", size = 3, font = "MicrogrammaDBolExt:style=Regular",halign="center");


  // front panel
  difference() {
    translate([0, 1, 0]) rotate([90, 0, 0]) roundedCube(size = [CASE_WIDTH, CASE_HEIGHT, CASE_THICKNESS], r = 5, sidesonly = true);
    translate([10, -2, 29]) cube([5, 5, 2]); //hole for light
    translate([0, -3, 29]) cube([MUCH_BIGGER, 2, 2]); // line down the center

    // cutout for name plate
    translate([10, -.5, 1]) rotate([90, 0, 0])  roundedCube(size = [51.75, 27.35, 2], r = 3.4, sidesonly = true);

    // screen
    //translate([CASE_WIDTH-DISPLAY_OFFSET,-1,16]) display_screen();
    //translate([CASE_WIDTH-DISPLAY_OFFSET,-1,16]) display_inset();
  }

  // front panel power text
  color("green") translate([3, -.5, 32.5])  rotate([90, 0, 0]) linear_extrude(2.5)  text("POWER", size = 3, font = "MicrogrammaDBolExt:style=Regular");
}



module bottom_case() {
  // split the case
  difference() {
    case ();
    translate([-5, -5, 31]) cube([MUCH_BIGGER, MUCH_BIGGER, MUCH_BIGGER]);
    
    // power switch hole.
    translate([160, CASE_DEPTH-5, 7]) cube([12.5, 10.5, 20.5]);
    
    translate([RPI_X - PUNCH_OUT_DEPTH, RPI_Y, RPI_Z]) rotate(ROTATE_TO_TRUE) ports(1.05);
    
    // power light hole
    translate([10, 0, 29]) cube([5, 6, 5]);

    translate([CASE_WIDTH-PUNCH_OUT_DEPTH, CONTROL_PORT_OFFSET, CONTROL_PORT_Z])  db9_holes();
    translate([CASE_WIDTH-PUNCH_OUT_DEPTH, CONTROL_PORT_OFFSET+CONTROL_PORT_SPACING, CONTROL_PORT_Z]) db9_holes();

    // power switch
    translate([160, 175, 7]) cube([12.5, 10.5, 20.5]);

    // display screen 
    translate([150,-1,16]) display_screen();
    translate([150,-1,16]) display_inset();

    // power supply cable cutout
    for( i=[117.75:.25:126.25]) {
      color("red") translate([i, CASE_DEPTH, 15.5]) rotate( [90,0,0] )  linear_extrude( 4.5)  circle(d=12);  
    }
  }

  // power supply mount 
  % translate([93,CASE_DEPTH-92,2]) cube([58,88,30]);
  translate([122,CASE_DEPTH-48,15])  mountblock(58.5,25,88);

  // hdmi mount 
  translate([50,CASE_DEPTH-17.5,13.1])  mountblock(20.7,11.7,30);
  translate([50,CASE_DEPTH-17.5,4]) rotate([90,0,0] ) cube([20.7+5, 2, 30], center=true);
}

module top_case() {
  difference() {
    case ();

    translate([-5, -5, -(MUCH_BIGGER - 31)]) cube([MUCH_BIGGER, MUCH_BIGGER, MUCH_BIGGER]);
    GAP=5; COUNT=4; S = (CASE_WIDTH-((COUNT+1)*GAP))/4;

    for (i = [0:1:COUNT]) { 
      translate([GAP+(S*i)+(GAP*i), RIDGES_START, CASE_HEIGHT-6]) cube([S, 22, 5]);  
    }
  }

  // top screw posts
  ROTATE_SCREW_POST = [180, 0, 0];
  translate([CASE_WIDTH-POST_FROM_SIDE, POST_FROM_FRONT, CASE_HEIGHT]) rotate(ROTATE_SCREW_POST)  RodEnd(12,43,7,2);
  translate([POST_FROM_SIDE, CASE_DEPTH-POST_FROM_BACK, CASE_HEIGHT]) rotate(ROTATE_SCREW_POST)  RodEnd(12,43,7,2);

  translate([POST_FROM_SIDE, POST_FROM_FRONT, CASE_HEIGHT]) rotate(ROTATE_SCREW_POST)  RodEnd(12,43,7,2);
  translate([CASE_WIDTH-POST_FROM_SIDE, CASE_DEPTH-POST_FROM_BACK, CASE_HEIGHT]) rotate(ROTATE_SCREW_POST)  RodEnd(12,43,7,2);

}
// show top case 
 translate([CASE_WIDTH+5, 5, CASE_HEIGHT]) rotate([0, 180, 0]) top_case();

// % translate([-MUCH_BIGGER, 5, 0]) top_case();
// show bottom case 
 translate([-(CASE_WIDTH+5),5,0]) bottom_case();

// whole
// case();

//difference() {
//  bottom_case();
//  translate([0,15,-5]) cube([MUCH_BIGGER, MUCH_BIGGER, MUCH_BIGGER]);
//}


// line up marks
// % translate([CASE_WIDTH*-1.5, 20, CASE_HEIGHT-42]) cube([CASE_WIDTH*3, .5, .5]);  
//% translate([CASE_WIDTH*-1.5, 20, -.5]) cube([CASE_WIDTH*3, .5, .5]);  
//% translate([CASE_WIDTH*-1.5, CASE_DEPTH+4, 7]) cube([CASE_WIDTH*3, .5, .5]);  
//% translate([CASE_WIDTH*-1.5, CASE_DEPTH+4, 9]) cube([CASE_WIDTH*3, .5, .5]);  