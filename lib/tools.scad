//use <BOSL/transforms.scad>;

module rotate_about_pt(z, y, pt) {
    translate(pt)
        rotate([0, y, z])
            translate(-pt)
                children();   
}

module scale_about_pt(s, pt) {
    translate(pt)
        scale(s)
            translate(-pt)
                children();   
}

module line_2d(length, start=[0,0], center=false) {
  // linear_extrude(height = .03) translate(start) resize([.03,length]) square(.01);
  if( center ){
    //translate([start[0]+length/2,start[1],0]) 
    rotate([0,-90,0]) cylinder(r=.02, h=length, center=true);
  } else {
    translate([start[0]+length,start[1],0]) 
    rotate([0,-90,0]) cylinder(r=.02, h=length, center=false);
  }
}
roll(90)
line_2d(5,center = false);

module measure_2d(x,y,length) {
  start = [x,y];
// module measure_2d(length,start=[0,0]) {
  rot = [0,0,90];
  % rotate_about_pt(-90,90,start) color("black",.450) {
    translate([start[0]+.055,start[1]-.16]) linear_extrude(height = .03) scale([.3,1.5]) rotate(rot) text("3", size=.3, font="Webdings");
    translate([start[0]+.055,start[1]+length-.42]) linear_extrude(height = .03) scale([.3,1.5]) rotate(rot) text("4", size=.3, font="Webdings");
    line_2d(length-.2, [start[0],start[1]+.1]);
    rotate_about_pt(90,0,start) line_2d(1,[start[0],start[1]-.3]);
    rotate_about_pt(90,0,start) line_2d(1,[start[0]+length,start[1]-.3]);
    translate([start[0]-.25,start[1]+length/2]) linear_extrude(height = .03) rotate(rot) text(str(length),size=.3,font="Arial");
  }
}



module measure_2da(length) {
  start = [-length/2,0];
  rot = [0,0,90];
  % 
    
    //rotate_about_pt(-90,90,start) 
    color("black",.450) {
    translate([start[0]+.055,start[1]-.16]) linear_extrude(height = .03) scale([.3,1.5]) rotate(rot) text("3", size=.3, font="Webdings");
    translate([start[0]+.055,start[1]+length-.42]) linear_extrude(height = .03) scale([.3,1.5]) rotate(rot) text("4", size=.3, font="Webdings");
    line_2d(length-.2, [start[0],start[1]+.1]);
    rotate_about_pt(90,0,start) line_2d(1,[start[0],start[1]-.3]);
    rotate_about_pt(90,0,start) line_2d(1,[start[0]+length,start[1]-.3]);
    translate([start[0]-.25,start[1]+length/2]) linear_extrude(height = .03) rotate(rot) text(str(length),size=.3,font="Arial");
  }
}


module roll(angle, pt) {
  if( is_num(pt) ) {
    translate([pt,0,0]) rotate([0,angle,0]) translate([-pt,0,0])  children(); 
    //translate([0,0,0]) rotate([0,angle,0]) translate([0,0,-pt]) children();   
  } else {
    rotate([0,angle,0]) children();   
  }
}

module up(n) {
  translate([0,0,n]) children();
}

module down(n) {
  translate([0,0,-n]) children();
}

module left(n) {
  translate([-n,0,0]) children();
}

module right(n) {
  translate([n,0,0]) children();
}

module back(n) {
  translate([0,n,0]) children();
}

module forward(n) {
  translate([0,-n,0]) children();
}


//forward(3) up(3) 
// rotate_about_pt(0,90,[1,0,0])
//left(5) forward(3)
  //translate([3.5,0,0]) rotate([0,90,0]) translate([-3.5,0,0]) 
  //measure_2d(1,0,5);
  //measure_2d(1,0,5);

  //up(5) right(3)
  //translate([2.5,0,0]) rotate([0,90,0]) translate([-2.5,0,0]) 
  //measure_2d(0,0,5);

// rotate_about_pt(0,0,[5,1,0]) measure_2d(5,1,25);

// roll(90,2.5)
//translate([2.5,0,0]) rotate([0,90,0]) translate([-2.5,0,0]) 
//translate([2.5,0,0]) rotate([0,0,0]) translate([-2.5,0,0])
//roll(90,2.5)
 //measure_2da(5);

 


 // Find the unitary vector with direction v. Fails if v=[0,0,0].
function unit(v) = norm(v)>0 ? v/norm(v) : undef; 
// Find the transpose of a rectangular matrix
function transpose(m) = // m is any rectangular matrix of objects
  [ for(j=[0:len(m[0])-1]) [ for(i=[0:len(m)-1]) m[i][j] ] ];
// The identity matrix with dimension n
function identity(n) = [for(i=[0:n-1]) [for(j=[0:n-1]) i==j ? 1 : 0] ];

// computes the rotation with minimum angle that brings a to b
// the code fails if a and b are opposed to each other
function rotate_from_to(a,b) = 
    let( axis = unit(cross(a,b)) )
    axis*axis >= 0.99 ? 
        transpose([unit(b), axis, cross(axis, unit(b))]) * 
            [unit(a), axis, cross(axis, unit(a))] : 
        identity(3);


// An application of the minimum rotation
// Given to points p0 and p1, draw a thin cylinder with its
// bases at p0 and p1
module line(p0, p1, diameter=1) {
    v = p1-p0;
    translate(p0)
        // rotate the cylinder so its z axis is brought to direction v
        multmatrix(rotate_from_to([0,0,1],v))
            cylinder(d=diameter, h=norm(v), $fn=15);
}

rotate([0,-90,0]) line([0,0,0], [5,0,0], .05);

