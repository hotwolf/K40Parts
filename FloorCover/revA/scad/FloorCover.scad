//###############################################################################
//# Floor Cover                                                                 #
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
//#   Covers the underneath the laser bed                                       #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   May 1, 2023                                                               #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
$pp1_colour = "Orange";
include <../../../lib/NopSCADlib/lib.scad>

holeD=50; 

//Connector mount
module floorCover() {

   difference() {
      union() {
         translate([0,0,0]) cylinder(h=2,d=holeD+10);
      }
      union() {
         translate([0,0,-9]) cylinder(h=10,d=holeD);
      }
   }

   difference() {
      union() {
         translate([0,0,-2.2]) cylinder(h=3.2,d=holeD-0.1);
         translate([0,0,-1.7]) rotate_extrude() translate([holeD/2,0,0]) circle(d=1);

      }
      union() {
         translate([0,0,-9]) cylinder(h=10,d=holeD-1);
         for (a=[0:60:180]) {
            rotate([0,0,a]) cube([1,holeD+10,40],center=true);
         } 
      }
  }
      
   difference() {
      union() {
         translate([0,0,-2.2]) cylinder(h=3.2,d=holeD-3);
      }
      union() {
         translate([0,0,-0.2]) cylinder(h=0.2,d=holeD-5);
      }
  }
}

//In connector mount
module floorCover_stl() {
    stl("floorCover");
    color(pp1_colour)
    floorCover();
} 


//! Insert a layer of aluminum foil while printing.
module main_assembly()
assembly("main") {

  //Floor cover
  translate([0,0,0]) floorCover_stl();
}

//Preview 
if ($preview) {
 
   translate([0,0,0]) main_assembly();
  
}
 