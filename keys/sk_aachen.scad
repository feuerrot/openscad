//Seite mit Hebel
a=12.5;		// 25/2 in x außen
b=9;		// 18/2 in x innen
c=129;		// 129 in z
d=112;		// 112 in y

//Seite ohne Hebel
e=12;		// 24/2 in x außen
f=10;		// 20/2 in x innen
g=c;		// c in z
h=-75.5;	// -75.5 in y

//Feinheit der Zylinder
feinheit=20;

//Tiefe - Put ur own magic values here
sb = [3,2,1,4,5,4,6];

//Stützen zum Druck
s=false;

difference(){
	union(){
		translate([0,0,600]) scale([55,250,250]) cube(1, center=true); // Griff
		cylinder(h=500, r=55/2, $fn=feinheit); // Zentralzylinder
		difference(){ // Schließbart
			polyhedron(
				points=[
					[b,0,0],[-b,0,0],[a,d,0],[-a,d,0],
					[b,0,c],[-b,0,c],[a,d,c],[-a,d,c]
				],
				faces=[
					[0,1,3],[0,3,2],[5,3,1],[5,7,3],
					[3,7,2],[7,6,2],[4,7,5],[4,6,7],
					[4,5,0],[5,1,0],[6,4,0],[6,0,2]
				]
			);
			for (i=[0:6]){
				translate([-15,d-sb[i]*10,15*(i)+24])
				scale([30,sb[i]*10,15])
				cube(1);
			}
		}
		difference(){ // Gegenbart
			polyhedron(
				points=[
					[f,0,0],[-f,0,0],[e,h,0],[-e,h,0],
					[f,0,g],[-f,0,g],[e,h,g],[-e,h,g]
				],
				faces=[
					[0,1,3],[0,3,2],[5,3,1],[5,7,3],
					[3,7,2],[7,6,2],[4,7,5],[4,6,7],
					[4,5,0],[5,1,0],[6,4,0],[6,0,2]
				]
			);
			translate([-15,0,0]) scale([30,h,24]) cube(1);
			for (i=[0:6]){
				translate([-15,h,15*(i)+24])
				scale([30,(6-sb[i])*10,15])
				cube(1);
			}
		}
		stuetze();
	}
	translate([0,0,-1]){
		cylinder(h=350, r=40/2, $fn=feinheit); // Negativzylinder
	}
}

module stuetze(){
	if (s==true){
		for(i=[2:5]){
			translate([-8,-15*i+4,0]) scale([-20,2,c]) cube(1);
		}
		for(i=[2:7]){
			translate([-8,15*i+2,0]) scale([-20,2,c]) cube(1);
		}
	}
}
