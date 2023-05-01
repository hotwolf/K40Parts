//###############################################################################
//# Cooling Tube Connector Mounts                                               #
//###############################################################################
//#    Copyright 2023 Dirk Heisswolf                                            #
//#    This file is part of the DIY Laser Bed project.                          #
//#                                                                             #
//#    This project is free software: you can redistribute it and/or modify     #
//#    it under the terms of the GNU General Public License as published by     #
//#    the Free Software Foundation, either version 3 of the License, or        #
//#    (at your option) any later version.                                      #
//#                                                                             #
//#    This project is distributed in the hope that it will be useful,          #
//#    but WITHOUT ANY WARRANTY; without even the implied warranty of           #
//#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the            #
//#    GNU General Public License for more details.                             #
//#                                                                             #
//#    You should have received a copy of the GNU General Public License        #
//#    along with this project.  If not, see <http://www.gnu.org/licenses/>.    #
//#                                                                             #
//#    This project makes use of the NopSCADlib library                         #
//#    (see https://github.com/nophead/NopSCADlib).                             #
//#                                                                             #
//###############################################################################
//# Description:                                                                #
//#   Mounts for the cooling and air connectors.                                #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   May 1, 2023                                                               #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
$pp1_colour = "Orange";
include <../../../lib/NopSCADlib/lib.scad>

//Hose fitting
//Reused Paul Tibble's design -> https://www.thingiverse.com/Paul_Tibble/about
module hoseFitting(outer_diameter = 8.8,  //Outer Diameter (bottom)
                   wall_thickness = 1,    //Wall Thickness (bottom)
                   barb_size = 0.5,       //Rib Thickness (bottom), set to Zero to remove
                   length = 20) {         //Length (bottom)
   $fn = 100;

   //do not change these
   inner_diameter = outer_diameter - (wall_thickness*2);

   translate([0,0,-length])
   rotate_extrude(angle = 360, convexity = 10) {
      translate([inner_diameter/2,0])square([wall_thickness,length]);
      //rib 1
      translate([outer_diameter/2,(length),0])polygon(points=[[0,0],[0,-1*(length/5)],[barb_size,-1*(length/5)]]);
      //rib 2
      translate([outer_diameter/2,(length)-length*0.25,0])polygon(points=[[0,0],[0,-1*(length/5)],[barb_size,-1*(length/5)]]);
      //rib 3
      translate([outer_diameter/2,(length)-length*0.5,0])polygon(points=[[0,0],[0,-1*(length/5)],[barb_size,-1*(length/5)]]);
   }
}
//hoseFitting();
//%translate([0,0,-20]) cylinder(h=20,d=6.3,$fn=24);

//Connector model
module connector() {
   vitamin(str("connector(): G1/4 tube connector"));
   
   color("Gold") {
      translate([0,0,23.5]) hoseFitting();
      translate([0,0,0])    cylinder(h=3.5,d=14.6,$fn=6);
      translate([0,0,-9])   cylinder(h=9,d=12.5);
   }
}

//Connector mount
module connector_mount(label="OUT") {

   difference() {
      union() {
         translate([0,0,0]) cylinder(h=2,d=30);
      }
      union() {
         translate([0,0,-9]) cylinder(h=10,d=16.9);
         translate([0,0,-3.5]) cylinder(h=10,d=8.8,$fn=64);
         translate([0,6,1.5]) linear_extrude(6) text(label,size=6,halign="center");
      }
   }

   difference() {
      union() {
         translate([0,0,-2.2]) cylinder(h=3.2,d=14.9);
         translate([0,0,-1.7]) rotate_extrude() translate([14.9/2,0,0]) circle(d=1);

      }
      union() {
         translate([0,0,-9]) cylinder(h=10,d=13.9);
         translate([0,0,-3.5]) cylinder(h=10,d=8.8,$fn=64);
         for (a=[0:72:180]) {
            rotate([0,0,a]) cube([1,40,40],center=true);
         } 
      }
  }
      
   difference() {
      union() {
         translate([0,0,-2.2]) cylinder(h=3.2,d=12.9);
      }
      union() {
         translate([0,0,-3.5]) cylinder(h=10,d=8.8,$fn=64);
      }
  }
}

//In connector mount
module water_in_mount_stl() {
    stl("water_in_mount");
    color(pp1_colour)
    connector_mount("IN");
} 

//Out connector mount
module water_out_mount_stl() {
    stl("water_out_mount");
    color(pp1_colour)
    connector_mount("OUT");
} 

//Air connector
module air_connector() {
    color(pp1_colour) {
                
       difference() {
          union() {
             translate([0,0,0]) cylinder(h=2,d=30);
          }
          union() {
             translate([0,0,-9])   cylinder(h=10,d=16.9);
             translate([0,0,-3.5]) cylinder(h=10,d=5,$fn=64);
             translate([0,6,1.5])  linear_extrude(6) text("AIR",size=6,halign="center");
          }
       }
      
       difference() {
          union() {
             translate([0,0,-2.2]) cylinder(h=3.2,d=14.9);
             translate([0,0,-1.7]) rotate_extrude() translate([14.9/2,0,0]) circle(d=1);
          }
          union() {
             translate([0,0,-9]) cylinder(h=10,d=13.9);
             translate([0,0,-3.5]) cylinder(h=10,d=5,$fn=64);
             for (a=[0:72:180]) {
                rotate([0,0,a]) cube([1,40,40],center=true);
             } 
          }
       } 

       difference() {
          union() {
             translate([0,0,-2.2]) cylinder(h=3.2,d=12.9);
          }
          union() {
             translate([0,0,-3.5]) cylinder(h=10,d=5,$fn=64);
          }
       }
     
       translate([0,0,18]) rotate([0,0,0])
       hoseFitting(outer_diameter = 6,   //Outer Diameter (bottom)
                   wall_thickness = 1,   //Wall Thickness (bottom)
                   barb_size = 0.5,      //Rib Thickness (bottom), set to Zero to remove
                   length = 20);         //Length (bottom)

       translate([0,0,-18]) rotate([180,0,0])
       hoseFitting(outer_diameter = 6,   //Outer Diameter (bottom)
                   wall_thickness = 1,   //Wall Thickness (bottom)
                   barb_size = 0.5,      //Rib Thickness (bottom), set to Zero to remove
                   length = 20);         //Length (bottom)

   }
} 

//Air connector
module air_connector_A_stl() {
    stl("air_connector_A");
    difference() {
       air_connector();
       #translate([0,0,-29.5]) cube(60,center=true);
    }
}

//Air connector
module air_connector_B_stl() {
    stl("air_connector_B");
    difference() {
       air_connector();
       translate([0,0,31.5]) cube(60,center=true);
    }
}


//! 
module main_assembly()
assembly("main") {

  //Water in
  translate([-40,0,-5.7]) connector();
  translate([-40,0,0]) water_in_mount_stl();
    
  //Water out
  translate([0,0,-5.7]) connector();
  translate([0,0,0]) water_out_mount_stl();
    
  //Air
  translate([40,0,0]) air_connector_A_stl();
  translate([40,0,0]) air_connector_B_stl();
}

//Model of the lense holder 
if ($preview) {
   
   //Enclosure wall
   color("DarkGray")
   difference() {
      translate([0,0,-0.6]) cube([120,40,1.2],center=true);
      union() {
         translate([-40,0,0]) cylinder(h=20,d=15,center=true);
         translate([0,0,0])   cylinder(h=20,d=15,center=true);
         translate([40,0,0])  cylinder(h=20,d=15,center=true);
      }
   }

   translate([0,0,0]) main_assembly();
  
}
 