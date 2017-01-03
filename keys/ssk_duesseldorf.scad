//Feinheit der Zylinder
feinheit=20;

//Tiefe - Put ur own magic values here
sb  = [0,8.5,1,2,3,4,5,6,7];

// more magic values
sbc= [0,45,16,16,16,16,16,16,16];

//Stützen zum Druck
s=false;

function sbd(n) = n > 0 ? sbc[n] + sbd(n-1) : sbc[0];

scale([0.1,0.1,0.1]) translate([725,125,25]) rotate([0,-90,0]) key();

module key(){
	difference(){
		union(){
			translate([0,0,600]) scale([52,250,250]) cube(1, center=true); // Griff
			cylinder(h=500, r=52/2, $fn=feinheit); // Zentralzylinder
			//translate([0,0,156/2]) cube([28,240,156], center=true);
			bart();
			if (s==true){
				intersection(){
					stuetze();
					translate([-20,0,0]) bart();
					}
			}
		}
		translate([0,0,-1]){
			cylinder(h=265, r=40/2, $fn=feinheit); // Negativzylinder
		}
	}
}

module stuetze(){
	for(i=[1,3,4,5,6]){
		translate([-15,-10*i-23,0]) scale([-10,2,sbd(8)]) cube(1);
	}
	for(i=[1,3,4,5,6,8,8.7]){
		translate([-15,10*i+23,0]) scale([-10,2,sbd(8)]) cube(1);
	}
}

module bart(){
	intersection(){
		translate([0,0,156/2]) cube([28,240,156], center=true); // Platte
		union(){
			for (i=[2:8]){
				translate([-29/2,(25+sb[i]*10)-140, sbd(i-1)])
				scale([29,140,sbc[i]])
				cube(1);
			}
			translate([0,(sb[1])*5+2,sbc[1]/2]) cube([28,(sb[1]+4)*10,sbc[1]], center=true);
		}
	}
}
