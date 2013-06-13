/*
 * Copy & paste this into your copy of the Libs.scad library (http://www.thingiverse.com/thing:6021)
 * 
 * Since the top is cut at radius height of the theoretical cylinder inside the teardrop, 
 * it might be a problem when the bridged part at top of the flat teardrop sags a bit during printing. 
 * This might happen when the bridge gets longer, i.e. on larger teardrops.
 * As a countermeasure itÕs possible to add a little bit height to the cut "for luck". 
 * To do so, set the value of the luck parameter to the additional height. 
 * However, the default value of this parameter is 0 and simply can be omitted in most cases.
 *
 * 2011 Eberhard Rensch, Pleasant Software
 * License, GPL v2 or later
 */
 
module flatteardrop(radius=5, length=10, angle=90, luck=0) {
	//$fn=resolution(radius); // This only works when inside Libs.scad
							// If you use this module separately, comment this line out
							// and/or set $fn to an absolute value (e.g. $fn = 36)
		
	sx1 = radius * sin(-45);
	sx2 = radius * -sin(-45);
	sy = radius * -cos(-45);
	ex = 0;
	ey = (sin(-135) + cos(-135)) * radius;
	
	dx= ex-sx1;
	dy = ey-sy;
	
	eys = -radius-luck;
	dys = eys-sy;
	ex1 = sy+dys*dx/dy;
	ex2 = -ex1;
		
	rotate([0, angle, 0]) union() {
		linear_extrude(height = length, center = true, convexity = radius, twist = 0)
			circle(r = radius, center = true);
		linear_extrude(height = length, center = true, convexity = radius, twist = 0)
			polygon(points = [
				[sy, sx1],
				[sy, sx2],
				[eys, ex2],
				[eys, ex1]], 
				paths = [[0, 1, 2, 3]]);
	}
}

$fa = 12;
$fs = 0.5;

w = 60; // Smooth rod distance (center to center)

module screws() {
  for (x = [-w/2, w/2]) {
    translate([x, 0, 0]) {
      // Push-through M3 screw hole.
      translate([0, -6, 0]) rotate([0, 90, 0])
	cylinder(r=1.65, h=20, center=true);
      // M3 nut holder.
      translate([-x/5, -6, 0])
	rotate([30, 0, 0]) rotate([0, 90, 0])
	cylinder(r=3.3, h=2.3, center=true, $fn=6);
    }
  }
}

module bracket(h) {
  difference() {
    union() {
      translate([0, -1, 0]) cube([w+12, 22, h], center=true);
      // Sandwich mount.
      translate([-w/2, 10, 0]) cylinder(r=6, h=h, center=true);
      translate([w/2, 10, 0]) cylinder(r=6, h=h, center=true);
    }
    // Sandwich mount.
    translate([-w/2, 12, 0]) cylinder(r=1.9, h=h+1, center=true);
    translate([w/2, 12, 0]) cylinder(r=1.9, h=h+1, center=true);
    // Smooth rod mounting slots.
    for (x = [-w/2, w/2]) {
      translate([x, 0, 0]) {
	cylinder(r=4.2, h=h+1, center=true);
	translate([0, -10, 0]) cube([2, 20, h+1], center=true);
      }
    }
    // Belt path.
    translate([0, -5, 0]) cube([w-20, 20, h+1], center=true);
    translate([0, -9, 0]) cube([w-12, 20, h+1], center=true);
    translate([-w/2+10, 1, 0]) cylinder(r=4, h=h+1, center=true);
    translate([w/2-10, 1, 0]) cylinder(r=4, h=h+1, center=true);
  }
}

module rodholder(l,s) {
	difference() {
		union() {
			translate([-l/2,0,0]) cube([l,s,s], center=false);
			translate([-l/2,0,-s]) cube([l,s,s], center=false);
			translate([-l/2,-s,-s]) cube([l,s,s], center=false);
			rotate([0,90,0]) cylinder(r = s,h=l, center=true);
		}
		flatteardrop(radius=9.6/2, length=l+1, angle=90, luck=0);
	}
}

//translate([0, 0, 10]) bracket(20);

rodholder(l=30,s=6);