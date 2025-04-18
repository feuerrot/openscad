// Sensor node containing a Sensirion SEN66, SPI 7segment display and probably some sort of ESP32
sen66 = [55, 25.5, 21.2];
display_pcb = [82.2, 15, 4];
digits = [60.8, 15, 7.5];
digits_offset = 12.2; // from left

depth_extra = 50;

wall = 2;   // wall width
fg = 1;     // buffer
border = 1; // for the sen66 cutout

esp_pcb = [49.5, 26, 2];
esp_usb = [7.5, 9, 3.5];
esp_usb_dy = 2.5;

module sen66(){
    union(){
        cube(sen66);
        translate([border, border, 0]) cube(sen66 + [-2*border, -2*border, wall]);
    }
}

module display(){
    union(){
        cube(display_pcb + [fg, fg, 0]);
        translate([digits_offset, fg/2, display_pcb.z]) cube(digits + [0, fg, 0]);
    }
}

module case(){
    difference(){
        union(){
            cube([display_pcb.x + 2*wall + fg, sen66.y + display_pcb.y + 2*wall + 2*fg, sen66.z + 2*wall + depth_extra]);
        }
        translate([display_pcb.x/2 + wall + fg/2 - sen66.x/2, wall, wall+depth_extra]) sen66();
        translate([(display_pcb.x+3*wall + fg)/2 - digits.x/2 - digits_offset, sen66.y + 2*wall + fg, sen66.z+2*wall+depth_extra - (digits.z+display_pcb.z)]) union() {
            display();
            translate([0, 0, -depth_extra]) cube(display_pcb + [fg, fg, depth_extra]);
        }
        translate([wall, wall, wall]) cube([display_pcb.x + fg, sen66.y + display_pcb.y + 2*wall + 2*fg, 2*wall + depth_extra + fg]);
    }
}

module wedge(){
    union(){
        cube([20, 20, 0.75]);
        cube([2, 20, 2.75]);
    }
}

module top(){
    difference(){
        union(){
            cube([display_pcb.x + 2*wall + fg, wall, sen66.z + 2*wall + depth_extra]);
            translate([wall, wall, wall]) cube([display_pcb.x + fg, 3*wall, sen66.z + depth_extra - digits.z]);
        }
        #translate([2*wall, wall, 2*wall]) cube([display_pcb.x + fg - 2*wall, 3*wall, sen66.z + depth_extra - wall - digits.z]);
        for (ix = [0:10]) {
            translate([2.25*wall + ix*(display_pcb.x + fg - 3*wall)/10, 0, 3*wall]) cube([wall/2, wall, sen66.z + depth_extra - 2*wall - digits.z - 2*wall]);
        }
    }

}

module esp(){
    difference(){
        cube(esp_pcb + [2*wall, 2*wall, 2*wall]);
        translate([2*wall, 0, 0]) cube(esp_pcb + [-2*wall, 2*wall, 2*wall]);
        translate([0, 2*wall, 0]) cube(esp_pcb + [2*wall, -2*wall, 2*wall]);
        translate([wall, wall, esp_pcb.z+wall/2]) cube(esp_pcb + [0, 0, 2*wall]);
    }
}

module espusb(){ // negative volume
    translate([wall, wall+esp_usb_dy, esp_pcb.z+wall/2]){
        translate([0, 0, 0]) cube(esp_usb + [0, 0, wall]);
        translate([-2*wall, -wall, -wall]) cube([2*wall, esp_usb.y + 2*wall, esp_usb.z + 2*wall]);
    }
}

module caseesp(){
    difference(){
        union(){
            case();
            translate([wall, wall, esp_pcb.y + wall + 2*wall]) rotate([-90, 0, 0]) esp();
        }

        translate([wall, wall, esp_pcb.y + wall + 2*wall]) rotate([-90, 0, 0]) espusb();
    }
}

caseesp();

translate([-(display_pcb.x + 2*wall + fg + 2*wall), 0, 0]) top();