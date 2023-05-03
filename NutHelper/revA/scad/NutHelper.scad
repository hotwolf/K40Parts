//###############################################################################
//# Nut Helper                                                                  #
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
//#   New end stop mount to account for the air nozzle.                         #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   May 1, 2023                                                               #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
$pp1_colour = "Orange";
include <../../../lib/NopSCADlib/lib.scad>

//EndStopMount
module NutHelper_stl() {
   stl("NutHelper");   
   color(pp1_colour)  {
       
      difference() {
         union() {
            hull() {
               translate([0,0,0])  cylinder(h=6,d=14); 
               translate([-20,5,0])  cylinder(h=2,d=8); 
               translate([20,5,0])  cylinder(h=2,d=8);             
            } 
         } 
         union() {
            translate([0,0,-10])  poly_cylinder(h=20,r=screw_clearance_radius(M6_cap_screw)); 
            translate([0,0,1])  cylinder(h=10,r=nut_radius(M6_nut),$fn=6); 
         }    
      }
   }
}

//! 1. Push nit into NutHelper
module main_assembly()
assembly("main") {

  NutHelper_stl();

  translate([0,0,-8]) rotate([180,0,0]) screw_and_washer(M6_cap_screw,16);
  translate([0,0,1])  nut(M6_nut);
    
}

//Model of the lense holder coin
if ($preview) {
   
  main_assembly();
  
}
