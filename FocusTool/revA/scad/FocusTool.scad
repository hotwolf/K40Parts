//###############################################################################
//# Focus Tool                                                                  #
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
//#   K40 Focus tool with magnets.                                              #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   May 13, 2023                                                              #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
$pp1_colour = "Orange";
include <../../../lib/NopSCADlib/lib.scad>


module magnet() {
    description = str("Neodym Magnet (5mmx5mmx2mm)");
    vitamin(str("miniMagnet(): ", description));
    
    color("Silver") cube([5,5,2]);
}    

//Focus tool
module FocusTool_stl() {
   stl("FocusTool");   
   color(pp1_colour)  {
       
      difference() {
         union() {
           //Labels
           translate([3,20,10]) rotate([0,0,0]) linear_extrude(1) text("50.8 mm", size=7, valign="center", halign="center");
           //50.8mm
           translate([3,49,10]) rotate([0,0,0]) linear_extrude(1) text("0", size=6, valign="top", halign="center"); 
           //48.8mm
           translate([9,47,10]) rotate([0,0,0]) linear_extrude(1) text("2", size=6, valign="top", halign="center"); 
           //46.8mm
           translate([15,45,10]) rotate([0,0,0]) linear_extrude(1) text("4", size=6, valign="top", halign="center"); 
           //44.8mm
           translate([21,43,10]) rotate([0,0,0]) linear_extrude(1) text("6", size=6, valign="top", halign="center"); 
           //49.8mm
           translate([-3,48,10]) rotate([0,0,0]) linear_extrude(1) text("1", size=6, valign="top", halign="center"); 
           //47.8mm
           translate([-9,46,10]) rotate([0,0,0]) linear_extrude(1) text("3", size=6, valign="top", halign="center"); 
           //45.8mm
           translate([-15,44,10]) rotate([0,0,0]) linear_extrude(1) text("5", size=6, valign="top", halign="center"); 
                         
           //Block
           //50.8mm
           translate([0,0,0]) cube([6,50.8,10]);             
           //48.8mm
           translate([6,0,0]) cube([6,48.8,10]);
           //46.8mm
           translate([12,0,0]) cube([6,46.8,10]);
           //44.8mm
           translate([18,0,0]) cube([6,44.8,10]);
           //49.8mm
           translate([-6,0,0]) cube([6,49.8,10]);
           //47.8mm
           translate([-12,0,0]) cube([6,47.8,10]);
           //45.8mm
           translate([-18,0,0]) cube([6,45.8,10]);          
   
         }
         union() {       
            //Magnets 
             
             
            #translate([-2.55+20,1.95,0.2])  rotate([0,0,0])  cube([5.1,5.1,2.2]); 
            #translate([-2.55-14,1.95,0.2])  rotate([0,0,0])  cube([5.1,5.1,2.2]); 
            #translate([-2.55+20,37.95,0.2]) rotate([0,0,0])  cube([5.1,5.1,2.2]); 
            #translate([-2.55-14,38.95,0.2]) rotate([0,0,0])  cube([5.1,5.1,2.2]); 
         }    
      }
   }
}

//! 1. Insert the magnets 
module main_assembly()
assembly("main") {

  //Focus tool
  FocusTool_stl();

  //Magnets 
  explode(-10) translate([-2.5+20,2,0.2])  rotate([0,0,0]) magnet(); 
  explode(-10) translate([-2.5-14,2,0.2]) rotate([0,0,0]) magnet(); 
  explode(-10) translate([-2.5+20,38,0.2])   rotate([0,0,0]) magnet(); 
  explode(-10) translate([-2.5-14,39,0.2])  rotate([0,0,0]) magnet();   
}

//Model of the lense holder coin
if ($preview) {
//  $explode=1; 
  main_assembly();
  
}
