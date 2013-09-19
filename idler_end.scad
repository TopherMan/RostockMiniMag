include <configuration.scad>
use <bracket.scad>

h = idler_end_height; // Total height.
tilt = 1; // Tilt bearings upward (the timing belt is pulling pretty hard).
          // 2 degree tilt caused belts to slide off the bearings

module bearing_mount() {
  translate([0, 0, 2.3]) cylinder(r1=12, r2=9, h=1.1, center=true);
  translate([0, 0, -2.3]) cylinder(r1=9, r2=12, h=1.1, center=true);
}

x = 17.7; // Micro switch center.
y = 16; // Micro switch center.

module idler_end() {
  translate([0, 0, h/2]) 
  rotate([0,180,0]) difference() {
    union() {
      bracket(h);
      translate([0, 7.5, 0]) rotate([90 - tilt, 0, 0]) bearing_mount();
      // Micro switch placeholder.
      % translate([x, y, -h/2+4]) rotate([0, 0, 15])
          cube([19.6, 6.34, 10.2], center=true);
      difference() {
        translate([20, 11.88, -h/2+5])
          cube([28, 8, 10], center=true);
        translate([x, y, -h/2+4]) rotate([0, 0, 15])
          cube([30, 6.34, 20], center=true);
        translate([30, 12, -h/2+5])
          cylinder(r=3, h=20, center=true);
      }
    }
    translate([x, y, -h/2+6]) rotate([0, 0, 15]) {
      translate([-9.5/2, 0, 0]) rotate([90, 0, 0])
	cylinder(r=1.1, h=26, center=true, $fn=12);
      translate([9.5/2, 0, 0]) rotate([90, 0, 0])
	cylinder(r=1.1, h=26, center=true, $fn=12);
    }
    translate([0, 8, 0]) rotate([90 - tilt, 0, 0])
      cylinder(r=4, h=40, center=true);
    for (i = [-1, 1]) for (z = [-7, 7])
      translate([i, -1, z]) screws();
  }
//Added here/////////////////////////////////
translate([0,0,h/2]) for (x = [-42.5, 42.5]) {
        // Diagonal fins.
        translate([x, 32, 0]) rotate([0,0,-sign(x)*30]) intersection() {
          cube([5, 40, h], center=true);
          rotate([65, 0, 0]) translate([0, -45, 0])
            cube([20, 100, 100], center=true);
        }
        // Extra mounting screw holes.
        //translate([x, 47, 4-h/2]) difference() {
          //cylinder(r=5, h=8, center=true, $fn=24);
          //translate([0, 1, 0]) cylinder(r=1.9, h=9, center=true, $fn=12);
        //}

			//Spot for the rods.
			translate([sign(x)*59.2,37,-h/2+11]) rotate([0,0,sign(x)*60]) rodholder(l=20,s=11);
      }
}

idler_end();
