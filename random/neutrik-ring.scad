// Nachbau der Kennzeichnungsringe für Neutrik-XLR-Stecker (~ Neutrik XXR)
// -------- 1.25
//    ==    1
// -------- 0.75
// ==    == 1.5
// -------- 0.75
//    ==    1
// -------- 1.25

// https://old.reddit.com/r/openscad/comments/j5v5pp/sumlist/mebwrsv/
function sum(vec) = vec * [for(i = [1 : len(vec)]) 1];
function layersum(vec, l) = [for (i = [0 : l]) vec[i]] * [for (i = [0:l]) 1];

$fn=256;
wall = 1;
ring = [20, 15, 5];
layer = [1.25, 1, 0.75, 1.5, 0.75, 1, 1.25];

module base(){
    difference(){
        cylinder(d=ring.x, h=sum(layer));
        cylinder(d=ring.x-2*wall, h=sum(layer));
    }
}

module rounded(z=1, helper=0){
    translate([-ring.x/2, z/2, z/2]) rotate([0, 90, 0]) difference(){
        union(){
            cylinder(d=z, h=ring.x);
            translate([-z/2, 0, 0]) cube([z, ring.x, ring.x]);
        }
        if (helper > 0) {
            translate([-z/2, 0, ring.x/2-helper/2]){
                cube([z, ring.x, helper]);
                rotate([-45, 0, 0]) translate([0, ring.x/3, 0]) cube([z, ring.x, helper]);
                rotate([45, 0, 0]) translate([0, ring.x/3, 0]) cube([z, ring.x, helper]);
            }
        }
    }
}

module roundedm(z=1, h=0, y=0){
    if (y >= 0) {
        translate([0, y, h]) rounded(z);
    } else {
        rotate([0, 0, 180]) translate([0, -y, h]) rounded(z);
    }
   
}

module ringdiff(z=1, y=(ring.x-wall)/2, zextra=0){
    translate([0, 0, -zextra/2]) rotate([0, 0, 45]) intersection(){
        difference(){
            cylinder(d=ring.x+wall, h=z+zextra);
            cylinder(d=ring.x-wall/2, h=z+zextra);
        }
        cube([ring.x, ring.x, z+zextra]);
    }
}

module ringdiffm(z=1, h=0, y=(ring.x-wall)/2, zextra=0){
    if (y >= 0){
        translate([0, 0, h]) ringdiff(z, y, zextra);
    } else {
        rotate([0, 0, 180]) translate([0, 0, h]) ringdiff(z, y, zextra);
    }
}

module full(){
    difference(){
        base();
        roundedm(z=layer[1], h=layersum(layer, 0), y=ring.z/2);
        roundedm(z=layer[1], h=layersum(layer, 0), y=-ring.z/2);
        rotate([0, 0, 90]){
            roundedm(z=layer[3], h=layersum(layer, 2), y=ring.y/2);
            roundedm(z=layer[3], h=layersum(layer, 2), y=-ring.y/2);
        }
        roundedm(z=layer[5], h=layersum(layer, 4), y=ring.z/2);
        roundedm(z=layer[5], h=layersum(layer, 4), y=-ring.z/2);

        ringdiffm(z=layer[3], h=layersum(layer, 2), y=(ring.x-wall)/2, zextra=0.75);
        ringdiffm(z=layer[3], h=layersum(layer, 2), y=-(ring.x-wall)/2, zextra=0.75);
    }
}

full();