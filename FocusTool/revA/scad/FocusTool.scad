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
    description = str("Neodym Magnet (D=4,H=1)");
    vitamin(str("magnet(): ", description));
    
    color("Silver"){ cylinder(h=1,d=4); }    
}

//Focus tool
module FocusTool_stl() {
   stl("FocusTool");   
   color(pp1_colour)  {
       
      difference() {
         union() {
           //Labels
           //50.8mm
           translate([3,46,2]) rotate([0,0,-90]) linear_extrude(2) text("50.8 mm", size=4, valign="center", halign="leftt"); 
           //48.8mm
           translate([9,44,2]) rotate([0,0,-90]) linear_extrude(2) text("-2 mm", size=4, valign="center", halign="left"); 
           //46.8mm
           translate([15,42,2]) rotate([0,0,-90]) linear_extrude(2) text("-4 mm", size=4, valign="center", halign="left"); 
           //44.8mm
           translate([21,40,2]) rotate([0,0,-90]) linear_extrude(2) text("-6 mm", size=4, valign="center", halign="left"); 
           //49.8mm
           translate([-3,45,2]) rotate([0,0,-90]) linear_extrude(2) text("-1 mm", size=4, valign="center", halign="left"); 
           //47.8mm
           translate([-9,43,2]) rotate([0,0,-90]) linear_extrude(2) text("-3 mm", size=4, valign="center", halign="left"); 
           //45.8mm
           translate([-15,41,2]) rotate([0,0,-90]) linear_extrude(2) text("-5 mm", size=4, valign="center", halign="left"); 
           //Stand
           #translate([-18,0,0]) cube([42,2,10]);
             
            difference() {
               union() {
                  //50.8mm
                  translate([0,0,0]) cube([6,50.8,4]);             
                  //48.8mm
                  translate([6,0,0]) cube([6,48.8,4]);
                  //46.8mm
                  translate([12,0,0]) cube([6,46.8,4]);
                  //44.8mm
                  translate([18,0,0]) cube([6,44.8,4]);
                  //49.8mm
                  translate([-6,0,0]) cube([6,49.8,4]);
                  //47.8mm
                  translate([-12,0,0]) cube([6,47.8,4]);
                  //45.8mm
                  translate([-18,0,0]) cube([6,45.8,4]);          
               } 
               union() {
                  //50.8mm
                  translate([2,2,2]) cube([2,46.8,4]);             
                  //48.8mm
                  translate([4,2,2]) cube([6,44.8,4]);
                  //46.8mm
                  translate([10,2,2]) cube([6,42.8,4]);
                  //44.8mm
                  translate([16,2,2]) cube([8,40.8,4]);
                  //49.8mm
                  translate([-4,2,2]) cube([6,45.8,4]);
                  //47.8mm
                  translate([-10,2,2]) cube([6,43.8,4]);
                  //45.8mm
                  translate([-18,2,2]) cube([8,41.8,4]);
               }
            }
         }
         union() {       
            //Magnets 
            translate([-14,4,-1])  cylinder(h=2,d=4,$fn=12); 
            translate([-14,4,-1])  cylinder(h=10,d=2,$fn=12); 
            translate([-14,42,-1]) cylinder(h=2,d=4,$fn=12); 
            translate([-14,42,-1]) cylinder(h=10,d=2,$fn=12); 
            translate([20,4,-1])   cylinder(h=2,d=4,$fn=12); 
            translate([20,4,-1])   cylinder(h=10,d=2,$fn=12); 
            translate([20,41,-1])  cylinder(h=2,d=4,$fn=12); 
            translate([20,41,-1])  cylinder(h=10,d=2,$fn=12); 
         }    
      }
   }
}

//! 1. Push the magnets into the holes
module main_assembly()
assembly("main") {

  //Focus tool
  FocusTool_stl();

  //Magnets 
  explode(-10) translate([-14,4,0])    magnet(); 
  explode(-10) translate([-14,42,0]) magnet(); 
  explode(-10) translate([20,4,0])   magnet(); 
  explode(-10) translate([20,41,0])  magnet();   
}

//Model of the lense holder coin
if ($preview) {
//  $explode=1; 
  main_assembly();
  
}
