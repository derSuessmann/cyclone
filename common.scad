/** common modules used in the other part source files
*/

module tube(h, inner_r, outer_r) {
    difference() {
        cylinder(h=h, r=outer_r);
        translate([0,0,-iota/2])
            cylinder(h=h+iota, r=inner_r);
    }
}

din963 = [
//  size  P     DK    K     N    T min
    [2,   0.4,  3.8,  1.2,  0.5, 0.4],
    [2.5, 0.45, 4.7,  1.5,  0.6, 0.5],
    [3,   0.5,  5.6,  1.65, 0.8, 0.6],
    [3.5, 0.6,  6.5,  1.93, 0.8, 0.7],
    [4,   0.7,  7.5,  2.2,  1,   0.8],
    [5,   0.8,  9.2,  2.5,  1.2, 1],
    [6,   1,    11,   3,    1.6, 1.2],
    [8,   1.25, 14.5, 4,    2,   1.6],
    [10,  1.5,  18,   5,    2.5, 2],
    [12,  1.75, 22,   6,    3,   2.4]
];

/** Mounting hole for a countersunk screw.
    
    The origin of the screw hole is on top of the center of the head. 
    The screw length is along the negative z axis.
    If h > 0, there will be a channel above the head (e.g. for the screwdriver).

    The size is given in m (as number) for the M size and over all length in l.
    
    iota > 0 adds to the radius of the head and screw.
    */
module mounting_hole_countersunk(m=2, l=15, h=0, iota=0.1) {

    // get data for given size (m)
    result = search(m, din963);
    i = result[0];
   
    head_diameter = din963[i][2] + iota;
    head_length = din963[i][3] + iota;
    screw_diameter = m + iota; 
    
    union() {
    // screw body
    translate([0, 0, -l])
        cylinder(h=l, r=screw_diameter/2);
    
    // screw head
    translate([0,0,-head_length])
        cylinder(h=head_length, r2=head_diameter/2, r1=screw_diameter/2);
    
    // hole above head
    translate([0,0,-iota/2])
        cylinder(h=h+iota,r=head_diameter/2);
    }
}

module mounting_hole(m=2, l=15, h=0, iota=0.1) {

    // get data for given size (m)
    result = search(m, din963);
    i = result[0];
   
    head_diameter = din963[i][2] + iota;
    head_length = din963[i][3] + iota;
    screw_diameter = m + iota; 
    
    union() {
    // screw body
    translate([0, 0, -l])
        cylinder(h=l, r=screw_diameter/2);    
    }
}

mounting_hole_countersunk(h=5);