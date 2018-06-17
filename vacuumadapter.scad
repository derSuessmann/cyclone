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


module hose_adapter(height=40, inner_r=58/2, outer_r=64/2) {
    // put notches for bayonett connector at
    notches_distance=18;

    module notches(width=7, depth=5.5, height=5.5) {
        module notch(width, depth, height) {
            cube([width,depth,height]);
        }
               
        for (zangle=[-180:180:+180]) {
            rotate([0,0,zangle]) 
                translate([inner_r,-depth/2,0]) 
                    notch(width,depth,height);
        }
    }
    
    difference() {
        union() {
            translate([0,0,height-notches_distance])
                notches();
            cylinder(h=height, r=outer_r);
        }
        // hole out
        translate([0,0,-iota/2])
            cylinder(h=height+iota, r2=inner_r+0.4, r1=inner_r-0.4);
    }
}

module mounting_flange(inner_r=64/2, width=20, height=4) {

    difference() {
        cylinder(h=height, r=inner_r+width);
        
        translate([0, 0, -iota/2])
            cylinder(h=height+iota, r=inner_r);
        
        for (zangle=[-180:45:+180]) {
            rotate([0,0,zangle])
                translate([inner_r+width/2,0, height]) 
                    mounting_hole_countersunk(m=3, h=2);
        }
    }
}

module hose_adapter_with_flange(height=50, inner_r=58/2, outer_r=64/2, flange_width=20, flange_height=4, rim_height=2) {

    hose_adapter(height=height, outer_r=outer_r, inner_r=inner_r);
            
    mounting_flange(inner_r=outer_r, width=flange_width, height=flange_height, rim_height=rim_height);
}

//hose_adapter();
//mounting_flange();
hose_adapter_with_flange();