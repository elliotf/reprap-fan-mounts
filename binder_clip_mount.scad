da6 = 1 / cos(180 / 6) / 2;

fan_hole_distance = 50;
fan_angle = 10;
fan_side_trim_amount = 0.75;

finger_thickness = 3;
finger_width = 5; // width inside the binder/bulldog clip
finger_length = 20;
finger_gap = .75;
total_width = finger_thickness * 2 + finger_gap;

screw_size = 4;
wall_thickness = 2;

//angled_edges();
module angled_edges() {
  rotate([0,10,0])
    translate([-total_width,-finger_length,0])
      cube([total_width,finger_length*2, finger_length], center = true);
}

//fan_hole();
module fan_hole() {

  rotate([0,0,fan_angle]) {
    translate([0,0,screw_size/2 + wall_thickness*2]) {
      rotate([90])
        cylinder(r = da6 * screw_size, h = total_width * 2, $fn = 6, center= true);

    }

    //if (fan_angle > 88) assign(fan_side_trim_amount = 0);
    translate([-total_width*4,total_width/2 - fan_side_trim_amount,-total_width])
      cube([total_width*8,total_width,total_width*4]);

    translate([-total_width,0 - total_width * 1.5,0])
      cube([total_width*2,total_width,total_width* 2]);
  }
}

main();
module main() {
  difference() {
    union() {
      translate([-total_width / 2,-finger_length,0])
        cube([total_width, finger_length,finger_width]);

      translate([-total_width / 2,0,0])
        cube([total_width, total_width,finger_width + wall_thickness * 3 + screw_size]);
    }

    translate([-finger_gap / 2,-finger_length*2,-finger_width / 2])
      cube([finger_gap,finger_length * 2,finger_width * 2]);

    translate([0,total_width / 2,finger_width])
      fan_hole();

    /*
    translate([0,total_width / 2,finger_width + screw_size/2 + wall_thickness * 2])
      rotate([0,0,fan_angle]) {
        rotate([90])
          cylinder(r = da6 * screw_size, h = 100, $fn = 6, center= true);

        translate([-total_width/2])
          cube([]);
      }
    */
  }


/*
  translate([finger_gap / 2,-finger_length,0])
    cube([finger_thickness, finger_length, finger_width]);

  translate([-finger_thickness - finger_gap / 2,-finger_length,0])
    cube([finger_thickness, finger_length, finger_width]);

  mount_width = finger_thickness + finger_gap + finger_thickness;
  translate([-finger_thickness,0,0])
      cube([mount_width, mount_width, finger_width]);

  translate([-screw_size/2 - wall_thickness,0,0])
      cube([screw_size + wall_thickness * 2,screw_size + wall_thickness * 2,screw_size + wall_thickness * 3]);
      */

/*
  translate([])
    mounting_hole();
*/
}

//mounting_hole();
module mounting_hole() {
  difference() {
    translate([-screw_size/2 - wall_thickness,0,0])
        cube([screw_size + wall_thickness * 2,screw_size + wall_thickness * 2,screw_size + wall_thickness * 3]);

    translate([0,0,screw_size/2 + wall_thickness * 2])
      rotate([90])
        cylinder(r = da6 * screw_size, h = 100, $fn = 6, center= true);
  }
}


/*
bearing_outer = 10;
bearing_inner = 3;
bearing_width = 4;
nut_size = 6;

bearing_outer = 22;
bearing_inner = 8;
bearing_width = 7;
nut_size = 14; // printed 13.5

bearing_clearance = 2;

spool_width = 73;
spool_diam = 204;
spool_below = round(bearing_outer / 10) + 1;

length = 90;
thickness = 5;

screw_size = bearing_inner;
height = bearing_outer + bearing_clearance + spool_below;

total_width = spool_width + thickness * 2;

da8 = 1 / cos(180 / 8) / 2;
da12 = 1 / cos(180 / 12) / 2;

difference() {
  linear_extrude(height = height, convexity = 5) difference() {
    minkowski() {
      square([spool_width, length - thickness * 2], center = true);
      circle(thickness);
    }
    square([spool_width, length - thickness * 2], center = true);
  }
  for(end = [1, -1]) translate([0, end * (length / 2 - thickness - bearing_outer / 2 - 1), bearing_outer / 2 + spool_below]) rotate([90, 0, 90]) {
    cylinder(r = screw_size * da6, h = spool_width + thickness * 3,center = true, $fn = 6);
    for(side = [0, 1]) mirror([0, 0, side]) translate([0, 0, spool_width / 2 + thickness - 2]) cylinder(r = nut_size / 2, h = spool_width + thickness * 3,center = false, $fn = 6);    
  }

  translate([0,0,total_width / 2 + height]) rotate([90,0,0]) cylinder(r=total_width / 2 + bearing_outer / 2, h=length + 2, center= true);
  translate([-total_width / 2 - 1, 0, length / 2 + height]) rotate([0,90,0]) cylinder(r=length / 2 + bearing_outer / 2, h=total_width + 2);
}

% for(end = [1, -1]) translate([0, end * (length / 2 - thickness - bearing_outer / 2 - 1), bearing_outer / 2 + spool_below]) rotate([90, 0, 90]) {
  for(side = [0, 1])
    mirror([0, 0, side])
    translate([0, 0, spool_width / 2 + thickness - bearing_width - thickness - 1])
      difference() {
        cylinder(r = bearing_outer / 2, h=bearing_width);
        cylinder(r = bearing_inner / 2, h=bearing_width*4, center=true);
      }
}
*/
