
$fa=1;
$fs=0.1;

module CommodoreLogo() {
    translate( [-8.3,-8.2,2]) linear_extrude(height = 4, center = true, convexity = 10)  resize([6.2],true) polygon([[8.3,4.3],[8.3,6.7], [11.1,6.7], [13.5,4.3]]);
    translate( [-8.3,-8.6,2]) linear_extrude(height = 4, center = true, convexity = 10)  resize([6.2],true) polygon([[8.3,9.7],[8.3,7.3], [11.1,7.3], [13.5,9.7]]);

    difference() {
        translate( [0,0,0] ) cylinder(h=4,r=7.2);
        translate( [0,0,-1] ) cylinder(h=7,r=3.5);
        translate( [11.5,0,4] )cube(20, center = true);
    }
}

resize([28], auto = true) CommodoreLogo();
