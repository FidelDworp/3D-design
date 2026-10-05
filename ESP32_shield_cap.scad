// =====================================================================
// ESP32_shield_cap.scad  –  Kapje voor ESP32-C6 ZARLAR shield v2.0 (iTroniX)
// Versie : v1.4
// Datum  : 2026-10-05
// Auteur : FiDel / Claude
// Wijzigingen:
//   v1.0  Eerste versie: doos zonder bodem tot op het plankje, klemnokjes op
//         de PCB-rand (4 zijden), antennesleuf, 2x RJ45, L-vensters voor
//         Power IN en PIXEL-LINE, daksleuven voor T-BUS, UART, I2C, SPI/IO.
//   v1.1  Alle doorvoeren nu in de zijwanden (dak volledig dicht):
//         Power IN, PIXEL-LINE, T-BUS, UART, I2C en SPI/IO als sleuf
//         net boven de PCB tot slot_h hoog. Klemnokjes verplaatst.
//   v1.2  Wandsleuven onderaan open (tot op het plankje), zodat het kapje
//         over de aangesloten kabels schuift.
//   v1.3  iTroniX-logo + naam verzonken in het dak (bestand itronix_logo.svg).
//   v1.4  itronix_logo.svg vervangen door versie uit het originele .ai-bestand
//         (1200 dpi, scherpere contouren).
// ---------------------------------------------------------------------
// Assenstelsel: oorsprong = linkeronderhoek PCB (tekst "ESP32-C6 ZARLAR
//   shield" onderaan, RJ45 rechts, antenne boven), z = 0 = plankje.
//   Posities uit Eagle-layout "ESP32 shield v2.0.brd" (PDF f=2.00 -> /2).
// Printen: dak op het bed (ondersteboven), PLA/PETG, 0,4 mm nozzle.
// =====================================================================

$fn = 48;

/* [Algemeen] */
clr      = 0.3;     // speling
wall     = 2.0;     // wand- en dakdikte
pcb_w    = 79.7;    // PCB X
pcb_l    = 81.2;    // PCB Y
pcb_t    = 1.6;     // PCB dikte
in_h     = 19.5;    // vrije hoogte boven PCB (ESP32 + USB-C = 18 mm)
r_out    = 3;       // afronding buitenhoeken
r_in     = 0.5;     // afronding binnenhoeken (schroefkoppen in de hoeken!)

/* [Antenne ESP32] */
ant_x    = [19.6, 37.6];   // breedte antenne
ant_z    = [12, 17];       // sleuf boven PCB-bovenkant

/* [RJ45 rechts] */
rj_yc    = [64.1, 45.05];  // ROOMSENSE, OPTIONAL
rj_w     = 16.2;
rj_h     = 14.25;          // hoogte boven PCB

/* [Wandsleuven] */
// [wand, van, tot]  wand: "L","R","B"(onder),"T"(boven); van/tot = Y (L/R) of X (B/T)
slot_h   = 4.0;            // sleufhoogte boven PCB-bovenkant (sleuf open tot onderaan)
wall_slots = [
    ["L",  8.5, 19.6],     // Power IN (schroefklem)
    ["B",  7.4, 18.0],     // PIXEL-LINE 4p
    ["L", 21.6, 55.1],     // SPI/IO 11p (3V3 ... GND), 2 mm stijltje t.o.v. Power
    ["R", 12.8, 26.6],     // I2C 5p
    ["T", 43.4, 53.6],     // UART 4p
    ["T", 64.9, 73.5]      // T-BUS 3p
];

/* [Logo] */
logo_on    = true;
logo_file  = "itronix_logo.svg";   // moet naast dit .scad-bestand staan
logo_w     = 60;     // breedte logo in mm
logo_depth = 0.6;    // diepte gravure (3 lagen van 0,2 mm)
logo_pos   = [0, 0]; // verschuiving t.o.v. het midden van het dak

/* [Klemnokjes] */
clip_interf = 0.35;
clip_w      = 2.0;
clip_tip    = 0.4;
clip_lead   = 1.2;
clip_top    = pcb_t + 1.5;
clips_left   = [4, 62, 75];    // Y (vrij van Power IN en SPI/IO)
clips_right  = [6, 31, 78];    // Y (vrij van I2C en RJ45)
clips_bottom = [30, 50, 70];   // X (vrij van PIXEL-LINE)
clips_top    = [10, 40, 59];   // X (vrij van UART en T-BUS)

// ---------------------------------------------------------------------
pcb_top = pcb_t;
roof_z  = pcb_top + in_h;              // onderkant dak
H       = roof_z + wall;               // totale hoogte
ix0 = -clr; iy0 = -clr; ix1 = pcb_w + clr; iy1 = pcb_l + clr;   // binnenkant

module rbox(x0, y0, x1, y1, h, r)
    hull() for (x=[x0 + r, x1 - r], y=[y0 + r, y1 - r])
        translate([x, y, 0]) cylinder(r=r, h=h);

module shell()
    difference() {
        rbox(ix0 - wall, iy0 - wall, ix1 + wall, iy1 + wall, H, r_out);
        translate([0,0,-1]) rbox(ix0, iy0, ix1, iy1, roof_z + 1, r_in);
    }

// klemnokje: lokaal +X = naar binnen, op de binnenwand
module clip()
    hull() {
        translate([-0.2, -clip_w/2, 0]) cube([0.2, clip_w, clip_top]);
        translate([clr + clip_interf - 0.01, -clip_tip/2, clip_lead])
            cube([0.01, clip_tip, clip_top - clip_lead]);
    }
module clips() {
    for (y=clips_left)   translate([ix0, y, 0]) clip();
    for (y=clips_right)  translate([ix1, y, 0]) rotate([0,0,180]) clip();
    for (x=clips_bottom) translate([x, iy0, 0]) rotate([0,0,90]) clip();
    for (x=clips_top)    translate([x, iy1, 0]) rotate([0,0,-90]) clip();
}

module cutouts() {
    // antenne door bovenwand
    translate([ant_x[0] - clr, iy1 - 1, pcb_top + ant_z[0]])
        cube([ant_x[1] - ant_x[0] + 2*clr, wall + 2, ant_z[1] - ant_z[0]]);
    // RJ45 rechterwand
    for (yc=rj_yc) translate([ix1 - 1, yc - rj_w/2 - clr, -1])
        cube([wall + 2, rj_w + 2*clr, pcb_top + rj_h + clr + 1]);
    // wandsleuven, open van onderaan tot slot_h boven de PCB
    for (w=wall_slots) {
        z0 = -1; dz = pcb_top + slot_h + 1;
        if (w[0]=="L") translate([ix0 - wall - 1, w[1], z0]) cube([wall + 2, w[2] - w[1], dz]);
        if (w[0]=="R") translate([ix1 - 1,        w[1], z0]) cube([wall + 2, w[2] - w[1], dz]);
        if (w[0]=="B") translate([w[1], iy0 - wall - 1, z0]) cube([w[2] - w[1], wall + 2, dz]);
        if (w[0]=="T") translate([w[1], iy1 - 1,        z0]) cube([w[2] - w[1], wall + 2, dz]);
    }
}

module logo()
    translate([(ix0 + ix1)/2 + logo_pos[0], (iy0 + iy1)/2 + logo_pos[1], H - logo_depth])
        linear_extrude(logo_depth + 1)
            resize([logo_w, 0], auto=true) import(logo_file, center=true);

module cap() {
    difference() {
        union() { shell(); clips(); }
        cutouts();
        if (logo_on) logo();
    }
}

cap();
