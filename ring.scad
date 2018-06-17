$fn=360;
iota=0.1;

use <common.scad>;

// wall thickness
thickness=3;
// width of flange
flange=20;
flangeheight=flange/2;
// height of outer tube
outerheight=50;
// height of inner tube
innerheight=50;
// radius of inner tube
innerradius=25;

module ring(inner_r=64/2, width=20, height=4) {

    difference() {
        cylinder(h=height, r=inner_r+width);
        
        translate([0, 0, -iota/2])
            cylinder(h=height+iota, r=inner_r);
        
        for (zangle=[-180:45:+180]) {
            rotate([0,0,zangle])
                translate([inner_r+width/2,0, height+iota/2]) 
                    mounting_hole(m=3, h=height+iota);
        }
    }
}

ring(height=3);