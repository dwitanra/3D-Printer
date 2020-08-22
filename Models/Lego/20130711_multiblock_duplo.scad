// DIMENSIONAL PARAMETERS
posstud=8.00; //7.85;  // stud position
rstud=4.85;            // stud outer radius
d=2.5; //2.75;         // width of internal ridges
rcyl=6.425; //6.625;   // radius of internal cylinder

// USAGE:
//
// brick(X POSITION, Y POSITION, NUMBER OF 2x2 UNITS COMBINED, posstud, rstud, d, rcyl, BRICK HEIGHT FACTOR)

brick(0,0,1,posstud,rstud,d,rcyl,1);
brick(40,0,1,posstud,rstud,d,rcyl,1);
brick(80,0,1,posstud,rstud,d,rcyl,1);
brick(120,0,1,posstud,rstud,d,rcyl,1);



brick(0,40,2,posstud,rstud,d,rcyl,1);
brick(70,40,2,posstud,rstud,d,rcyl,1);
brick(0,80,2,posstud,rstud,d,rcyl,1);
brick(70,80,2,posstud,rstud,d,rcyl,1);

brick(0,120,3,posstud,rstud,d,rcyl,1);
brick(110,120,1,posstud,rstud,d,rcyl,2);



module brick(x,y,n,posstud,rstud,d,rcyl,heightfact){
translate(v=[x,y,0]){

union() {
   difference() {
      cube([(n-1)*32+31.75,31.75,heightfact*19.25]);
      translate(v=[1.5,1.5,-1]) {
         cube([((n-1)*32+31.75-3),28.75,heightfact*19.25-0.5]);

      }
      

  }
 // studs
  for (i=[0:n-1]){
     stud(i*32+posstud,posstud,heightfact*19.25,rstud);
     stud(i*32+posstud,32-posstud,heightfact*19.25,rstud);
     stud(i*32+32-posstud,posstud,heightfact*19.25,rstud);
     stud(i*32+32-posstud,32-posstud,heightfact*19.25,rstud);
  }
 
  // interne cylinder

  for (i=[0:2*n-2]){
	  difference(){
		  translate(v=[i*16+31.75/2,31.75/2,heightfact*19.25/2]) {
		    difference() {      
		      cylinder(h=heightfact*19.25, r=rcyl, center=true);
		      cylinder(h=heightfact*20, r=rcyl-1.5, center=true);
		    }
		  }
	      translate(v=[i*16+31.75/2-15,31.75/2,-5]){
	         cube(size=[30,1,10],center=True); 
	      }
	      translate(v=[i*16+31.75/2,31.75/2-15,-5]){
	         cube(size=[1,30,10],center=True); 
	      }
	  }
  }

  // richels
  richelset(0,0,n,d,heightfact);
  richelset(0,180,n,d,heightfact);
  richelset(0,270,1,d,heightfact);
  richelset((n-2)*32+31.75,90,1,d,heightfact);

  // extra steunen
  for (i=[0:(2*n-2)]){
	  steun(5,(heightfact-1)*19.25+14.25,0,6,1.2,i*16+20,20,45);
	  steun(5,(heightfact-1)*19.25+14.25,0,6,1.2,i*16+20,20,-135);
	
	  steun(5,(heightfact-1)*19.25+14.25,0,6,1.2,i*16+11.75,11.75,45);
	  steun(5,(heightfact-1)*19.25+14.25,0,6,1.2,i*16+11.75,11.75,-135);
	
	  steun(5,(heightfact-1)*19.25+14.25,0,6,1.2,i*16+11.75,20,-45);
	  steun(5,(heightfact-1)*19.25+14.25,0,6,1.2,i*16+11.75,20,135);
	
	  steun(5,(heightfact-1)*19.25+14.25,0,6,1.2,i*16+20,11.75,-45);
	  steun(5,(heightfact-1)*19.25+14.25,0,6,1.2,i*16+20,11.75,135);
  }

  // steunrand bovenin
  translate(v=[0,0,(heightfact-1)*19.25+16])
  steun(0,2,0,2,31,1.45, 31.75/2,0);
  translate(v=[((n-1)*32+31.75)/2,0,(heightfact-1)*19.25+16])
  steun(0,2,0,2,n*32-1, 0, 1.45,90);
  translate(v=[(n-1)*32,0,(heightfact-1)*19.25+16])
  steun(0,2,0,2,31,31.75-1.45, 31.75/2,180);
  translate(v=[((n-1)*32+31.75)/2,0,(heightfact-1)*19.25+16])
  steun(0,2,0,2,n*32-1, 0, 31.75-1.45,270);

}
}
}

module stud(x,y,z,r){
  translate(v=[x,y,1.875+z]){
    difference(){
       cylinder(h=3.75, r=r, center=true);
       cylinder(h=4, r=r-1.5, center=true);
    }
  }
}

module  richelset(x,a,n,d,heightfact){
   for (i=[0:n-1]){
		translate(v=[x+32*i+31.75/2,31.75/2,0]){
		  rotate(a=a, v=[0,0,1]){
		    translate(v=[-31.75/2,-31.75/2,0]){
		  	// richels
			  translate(v=[8.45-1.2,0,0]){
			    cube([1.2,d,heightfact*19.25]);
             translate(v=[0,0,(heightfact-1)*19.25])
	          steun(0,19.25,0,10,1.2,0.6,0,90);
	
			  }
			  translate(v=[24.45-1.2,0,0]){
			    cube([1.2,d,heightfact*19.25]);
             translate(v=[0,0,(heightfact-1)*19.25])
	          steun(0,19.25,0,10,1.2,0.6,0,90);
			  }
			  translate(v=[16.45-1.2,0,0]){
             translate(v=[0,0,(heightfact-1)*19.25])
	            steun(0,19.25,0,10,1.2,0.6,0,90);
			  }	    
	        }
		  }
		}
   }
}

module steun(starth,endh,startd,endd,w,x,y,or){
   angle=atan2((endd-startd),(endh-starth));
   translate(v=[x,y,starth]){
	   rotate(a=or,v=[0,0,1]){
          difference(){
             translate(v=[startd,0,0])
             rotate(a=angle,v=[0,1,0])
             translate(v=[-100,-w/2,-100])
             cube(size=[100,w,200],center=False);
	         translate(v=[-300,-w,-300])
	         cube(size=[300,2*w,600],center=False);
	         translate(v=[-1,-w,endh])
	         cube(size=[300,2*w,600],center=False);	 
	         translate(v=[-1,-w,-300])
	         cube(size=[300,2*w,300],center=False);	 
          }	  

      }
   }
}