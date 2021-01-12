// Adapter von IKEA VIDGA Rollen auf Moltonbahnen mit Ösen

// Allgemeiner Kram
wi = 3;
wa = 3;

// Gleiterhalterung
g_inner = 3;
g_height = 6;

// Moltonhalterung
m_inner = 5;
m_height = 11;
m_gap = 25;

// wat?
d_inner = (m_inner - g_inner)/2;
alpha = atan(d_inner/m_gap);
g_wa = cos(alpha)*wa;

$fn = 25;

union(){
	difference(){
		cube([2*wa+m_inner, m_height, wi]);
		translate([wa, wa, 0]) cube([m_inner, m_height - wa, wi]);
	}
	translate([d_inner, m_height + m_gap, 0]) difference(){
		cube([2*wa + g_inner, wa + g_height, wi]);
		translate([wa, 0, 0]) cube([g_inner, g_height - g_inner * 0.5, wi]);
		translate([wa + g_inner/2, g_height - g_inner * 0.5, 0]) cylinder(d=g_inner, h=wi);
		translate([0, g_height - g_inner/2, 0]) difference(){
			cube([2*wa + g_inner, wa + g_inner/2, wi]);
			translate([g_inner/2 + wa, 0, 0]) cylinder(r=g_inner/2 + wa, h=wi);
		}
	}
	translate([wa + m_inner + (wa - g_wa), m_height, 0]){
		ext = m_gap/cos(alpha) - m_gap;
		ext2 = sin(alpha)*wa;
		
		translate([g_wa, 0, 0]) rotate([0, 0, alpha])
		translate([-g_wa, 0, 0]) cube([g_wa, m_gap + ext + ext2, wi]);
	}
}