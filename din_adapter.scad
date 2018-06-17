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


module din_adapter(height=40, outer_r=50/2) {
    inner_r = outer_r - thickness;
        
    difference() {
        cylinder(h=height, r=outer_r);
        // hole out
        translate([0,0,-iota/2])
            cylinder(h=height+iota, r=inner_r);
    }
}

module reducer(from_r=64/2, to_r=50/2, height=64/2-50/2) {
    difference() {
        cylinder(h=height, r1=from_r, r2=to_r);
        // hole out
        translate([0,0,-iota/2])
            cylinder(h=height+iota, r1=from_r - thickness, r2=to_r - thickness);
    }
}
    
module mounting_flange(inner_r=64/2, angle=45, width=20, height=4) {

    difference() {
        cylinder(h=height, r=inner_r+width);
        
        translate([0, 0, -iota/2])
            cylinder(h=height+iota, r1=inner_r, r2=inner_r-(height/tan(angle)));
        
        for (zangle=[-180:45:+180]) {
            rotate([0,0,zangle])
                translate([inner_r+width/2,0, height+iota]) 
                    mounting_hole(m=3, h=2);
        }
    }
}

module din_adapter_with_flange(height=30, outer_r=64/2, din_r=50/2, flange_width=20, flange_height=4, rim_height=2) {
    
    reducer(height=12);
    translate([0,0,12])
        din_adapter(height=height, outer_r=din_r);
            
    mounting_flange(inner_r=outer_r, width=flange_width, height=flange_height, rim_height=rim_height);
}

//hose_adapter();
//mounting_flange();
din_adapter_with_flange();