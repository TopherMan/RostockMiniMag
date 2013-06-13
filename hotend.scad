
nut_w=7 + 0.5;     // nut width across flats 10 for M6, 8 for M5, 7 for M4
nut_t=3.2 + 0.5;   // nut thickness 5 fo M6, 4 for M5, 3.2 for M4
tube_od=4 + 0.25;  // dia of tube or pneumatic fitting

module bowden_clamp() difference() {
	linear_extrude(height=5+nut_t+2,convexity=30) difference() {
		// basic shape
		minkowski() {
			intersection() {
				square([60-2,22-4],center=true);
				circle(r=30-2,$fn=64);
			}
			// rounded corners
			circle(r=2,$fn=24);
		}
	}
	// M4 socket heads
	for(x=[-25,25]) translate([x,0,2])
		cylinder(r=4,h=12,$fn=32);

	// M4 Mounting holes
	for(x=[-25,25]) translate([x,0,-1])
		cylinder(r=2.4,h=2.8,$fn=32);

	// groove mount
	translate([0,0,-1]) cylinder(r=8.2,h=6,$fn=32);

	// captive nut
	cylinder(r=nut_w/sqrt(3),h=5+nut_t,$fn=6);

	// tube
	cylinder(r=tube_od/2,h=14,$fn=32);

	// unnecessary vents
	for(x=[-15,15]) translate([x,0,-1]) minkowski() {
		cube([4.2,8.2,13],center=true);
		cylinder(r=2.2,h=13,$fn=24);
	}
}

module wood_mount() difference() {
	// basic shape
	minkowski() {
		intersection() {
			square([60-1.8,22-3.6],center=true);
			circle(r=30-1.8,$fn=64);
		}
		// rounded corners
		circle(r=2,$fn=24);
	}
	// M4 Mounting holes
	for(x=[-25,25]) translate([x,0])
		circle(r=2,$fn=32);

	// groove mount
	circle(r=5.9,$fn=32);
	translate([0,-11]) square([11.8,22], center=true);

	// unnecessary vents
	for(x=[-15,15]) translate([x,0]) minkowski() {
		square([4,8],center=true);
		circle(r=2,$fn=24);
	}

}

%translate([0,0,-5]) linear_extrude(height=5,convexity=30) wood_mount();
bowden_clamp();

!translate([0,0,11]) rotate([180,0,0]) bowden_clamp();
*!wood_mount();

