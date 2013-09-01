da6 = 1 / cos(180 / 6) / 2;
da8 = 1 / cos(180 / 8) / 2;

thickness = 7;
thickness_diag = sqrt(thickness*thickness*2);

fan_hole_spacing = 50;
fan_screw_diam = 4.1;
fan_screw_nut_diam = 8;
//fan_offset = 16.55;
fan_offset = .2;
fan_angle_z = 65;
fan_angle_x = 15;
fan_pos_x = fan_offset*fan_hole_spacing/2;

fan_mount_thickness = 3;
fan_mount_height    = thickness*4;

motor_screw_diam = 3.1;
motor_screw_nut_diam = 7;
motor_screw_inset = 6;
motor_mount_screw_thickness = 4;

total_width = fan_hole_spacing+fan_screw_diam+thickness;

module fan_side() {
  difference() {
    union() {
      cube([total_width,fan_mount_thickness,thickness*2],center=true);
      translate([0,0,thickness*2]) cube([total_width,fan_mount_thickness,thickness*2],center=true);
    }

    // screw holes
    for(side=[-1,1]) {
      translate([fan_hole_spacing/2*side,0,0]) rotate([90,0,0]) rotate([0,0,90]) {
        cylinder(r=fan_screw_diam*da6,h=thickness*6,$fn=6,center=true);
        translate([0,0,-fan_mount_thickness/4-0.05]) cylinder(r=fan_screw_nut_diam*da6,h=fan_mount_thickness/2,$fn=6,center=true);
      }
    }

    // fan cutout
    translate([0,0,-fan_hole_spacing/2]) rotate([90,0,0])
      cylinder(r=(fan_hole_spacing+4)/2,h=thickness*6,center=true);
  }
}

module motor_side() {
  difference() {
    motor_side_body();
  }
}

module motor_side_body() {
  translate([0,thickness/2+fan_mount_thickness,thickness/2])
    cube([thickness*4,thickness*2,thickness*2],center=true);
}

module motor_side_holes() {
  # translate([0,thickness/2,0]) rotate([0,0,fan_angle_z]) translate([20,20,20-thickness/2]) {
    cube([40,40,55],center=true);
    translate([-20+motor_screw_inset,-20,-12]) rotate([90,0,0]) rotate([0,0,fan_angle_x/2]) {
      translate([0,0,motor_mount_screw_thickness]) cylinder(r=motor_screw_diam*da8,h=motor_mount_screw_thickness*2+0.1,$fn=8,center=true);
      translate([0,0,20+motor_mount_screw_thickness]) cylinder(r=motor_screw_nut_diam*da8,h=20*2,$fn=8,center=true);
    }
  }
}

module mount_body() {
  translate([fan_pos_x,0,-thickness/2])
    fan_side();

  translate([0,0,thickness/2])
    motor_side();
}

module mount_holes() {
  rotate([fan_angle_x,0,0]) motor_side_holes();

  // angled cuts
  translate([-23,0,thickness*2]) rotate([0,-20,0])
    cube([total_width*2,thickness*10,thickness*2],center=true);
  translate([33,0,thickness*2]) rotate([0,20,0])
    cube([total_width*2,thickness*10,thickness*2],center=true);

  translate([fan_pos_x+total_width/2+thickness/2-0.05,0,0])
    cube([thickness,thickness*5,total_width*2],center=true);
}

module assembly() {
  difference() {
    mount_body();
    mount_holes();
  }
}

module plate() {
  translate([0,0,fan_mount_thickness/2]) rotate([90,0,0]) assembly();
}

//assembly();
plate();
