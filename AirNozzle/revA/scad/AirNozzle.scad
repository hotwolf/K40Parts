//###############################################################################
//# Air Nozzle                                                                  #
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
//#   Air nozzle for a K40 laser cutter clone.                                  #
//#                                                                             #
//###############################################################################
//# Version History:                                                            #
//#   April 30, 2023                                                            #
//#      - Initial release                                                      #
//#                                                                             #
//###############################################################################
$pp1_colour = "Orange";
include <../../../lib/NopSCADlib/lib.scad>

//Hose fitting
//Reused Paul Tibble's design -> https://www.thingiverse.com/Paul_Tibble/about
module hoseFitting() {
   $fn = 100;

   //Outer Diameter (bottom)
   outer_diameter = 5.5;
   //Wall Thickness (bottom)
   wall_thickness = 1;
   //Rib Thickness (bottom), set to Zero to remove
   barb_size = 0.5;
   //Length (bottom)
   length = 10;

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

function shorten(path, count) = [for (i=[0:len(path)-count-1]) path[i]];


//Air flow
module airFlow(width=4,shorten=0) {
   color("LightBlue") {
      $fn=24;
      diagA=45;
      nozA=60;
      bendR=10;
      step=5;
      focusX=0;
      focusY=0;
      focusZ=-21-50.8;


      
      path=
           bezier_path(
           rounded_path([[25,-25,-4],
                         [25,-25,-20], 20,
                         [focusX,focusY-20,focusZ+12], 10,
                         [focusX,focusY,focusZ]]),100);
      spath=shorten(path,shorten); 
//      echo(path);
//      echo(spath);
       
      sweep(spath,circle_points(width/2, $fn = 64));
//        show_path(path);   
   }
}
//airFlow();

//Air nozzle
module AirNozzle_stl() {
   stl("AirNozzle");   
   color(pp1_colour)  {
      translate([25,-25,5]) hoseFitting();
        
      difference() {
         union() {
           hull() {  
              airFlow(width=5.5,shorten=9);
//              airFlow(width=8,shorten=7);
//              airFlow(width=10,shorten=8);
               translate([25,-25,-7])    cylinder(h=12,d=5.5,$fn=24);            
               translate([22,-25,-7])    cylinder(h=12,d=5.5,$fn=24);            
           }
             
           hull() {
               translate([25,10,-7])     cylinder(h=12,d=10,$fn=24);            
               translate([25,-10,-7])    cylinder(h=12,d=10,$fn=24);            
               translate([15,10,-7])     cylinder(h=12,d=10,$fn=24);            
               translate([15,-10,-7])    cylinder(h=12,d=10,$fn=24);            
               translate([25,-25,-7])    cylinder(h=12,d=5.5,$fn=24);            
               translate([22,-25,-7])    cylinder(h=12,d=5.5,$fn=24);            
             }          
         }
         union() {
           airFlow(width=4);
           translate([0,0,-21])     poly_cylinder(h=30,r=14);    
           translate([25,10,-10])   poly_cylinder(h=20,r=screw_clearance_radius(M3_cap_screw));
           translate([25,10,2])     poly_cylinder(h=20,r=screw_boss_diameter(M3_cap_screw)/2-0.5);            
           translate([25,-10,-10])  poly_cylinder(h=20,r=screw_clearance_radius(M3_cap_screw));
           translate([25,-10,2])    poly_cylinder(h=20,r=screw_boss_diameter(M3_cap_screw)/2-0.5);
           translate([25,-25,-4])   cylinder(h=20,r=5,$fn=66);
           translate([-15,-16,-20]) cube([46,31,20]);
           translate([-15,-40,5]) cube([46,60,10]);
             
           *translate([0,0,-21-50.8+-5+4]) cube([100,100,10],center=true);
          
         }
      }
   }
}

//! Attatch the air nozzle at the screws of the laser pointer mount
module main_assembly()
assembly("main") {

  AirNozzle_stl();

      translate([25,10,3]) screw_and_washer(M3_cap_screw,12);
      translate([25,-10,3]) screw_and_washer(M3_cap_screw,12);
    
}

//Model of the lense holder coin
if ($preview) {
   
  //Lense holder  
  color("Silver")  
  translate([0,0,-21]) cylinder(h=30,d=26);    
   
  //Mount  
  color("Darkgray")
  difference() {
    translate([-15,-15,-2.2]) cube([45,30,2.2]);
    union() {
      translate([25,10,-10]) cylinder(h=20,d=4);
      translate([25,-10,-10]) cylinder(h=20,d=4);
    }
  }  
    
  //Focal point  
  color("Red")
  translate([0,0,-21-50.8]) sphere(4); 

  //Table  
  color("BurlyWood")
  translate([0,0,-21.5-50.8]) cube([100,100,1],center=true);

  main_assembly();
  
}
