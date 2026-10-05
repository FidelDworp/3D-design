// =====================================================================
// RoomSense_cap.scad  –  Kapje voor RoomSenseboX v3.0 PCB (iTroniX)
// Versie : v1.4
// Datum  : 2026-10-05
// Auteur : FiDel / Claude
// Wijzigingen:
//   v1.0  Eerste versie: AM312 PIR (excentrisch), Ø80 zonder schroefgaten,
//         klemribbels + binnenrichel, RJ45-tunnel, DHT22-vak, 2 roosters.
//   v1.1  Verstevigingsringen rond LDR- en roostergat verwijderd.
//         Klemnokjes taps: driehoekig profiel (crush rib) + lange invoerschuinte.
//   v1.2  Ingebouwde wegbreekbare steunvinnen onder de flauwe kegelzijde
//         (radiaal vanuit de PIR-top, 0,3 mm spleet + dunne tandjes).
//   v1.3  Max. 10 steunvinnen (gelijk verdeeld), onderaan verbonden met een
//         dunne ring op het bed -> steunskelet komt in een stuk los.
//   v1.4  sup_n 10 -> 16: kortere overspanning tussen de vinnen (±15 mm).
// ---------------------------------------------------------------------
// Assenstelsel (bovenaanzicht):
//   oorsprong = middelpunt PCB, z = 0 = onderkant PCB (= plafond/wand)
//   Hoeken zoals afgesproken: 0° = RJ45 (-Y), 90° = LDR (-X),
//   270° = DHT22 (+X).  Posities uit Eagle-layout RoomsenseboX-v3.0.brd
// Printen: rand op het bed, PLA/PETG, 0,4 mm nozzle, ZONDER slicer-support:
//          de steunvinnen zitten in het model (sup_on). Na het printen wegbreken.
// =====================================================================

$fn = 120;

/* [Algemeen] */
clr        = 0.3;    // speling
wall       = 2.0;    // wanddikte
pcb_d      = 72;     // PCB diameter
pcb_t      = 1.75;   // PCB dikte
outer_d    = 80;     // buitendiameter kapje
skirt_h    = 7;      // hoogte verticale rand (vanaf onderkant PCB)
top_above  = 23;     // bovenkant plateau boven PCB-oppervlak
top_z      = pcb_t + top_above;

/* [PIR AM312] */
pir_ecc    = 17.8;   // afstand middelpunt lens tot PCB-middelpunt (richting RJ45)
pir_hole_d = 15;     // opening
plateau_d  = 21;     // vlak plateau rond de opening

/* [LDR] */
ldr_ang    = 90;
ldr_r      = 26.1;
ldr_hole_d = 10;

/* [RJ45] */
rj_w       = 16.2;   // breedte connector
rj_h       = 16;     // hoogte incl. PCB (vanaf onderkant PCB)
rj_off     = -0.8;   // zijdelingse verschuiving t.o.v. de 0°-as (Eagle: X -0,8)
rj_back    = 20.0;   // afstand middelpunt -> achterkant connector

/* [DHT22] */
dht_ang    = 270;
dht_len    = 28;     // langs de rand
dht_w      = 18;     // radiaal
dht_h      = 10;     // hoogte incl. PCB
dht_in     = 15.2;   // binnenkant blokje (radiaal), hoeken op PCB-rand

/* [Ventilatie] */
vent1_ang  = 57;     // boven DS18B20-2 (≈60°)
vent1_r    = 28;
vent2_r    = dht_in + dht_w/2;  // midden boven DHT22
vent_d     = 10;
grille     = true;   // true = rooster, false = één open gat
g_hole     = 1.2;    // vierkant gaatje rooster
g_pitch    = 2.0;

/* [Bevestiging] */
clip_angles = [55, 90, 160, 200, 305];  // klemribbels (vermijdt schroeven, RJ45, DHT)
clip_interf = 0.35;  // indrukking in PCB-rand (afstellen met proefprint)
clip_w      = 2.0;    // breedte voet van het nokje
clip_tip    = 0.4;    // breedte punt van het nokje (= 1 nozzle)
clip_lead   = 1.2;    // hoogte invoerschuinte vanaf onderrand
ridge_w     = 1.5;   // binnenrichel op PCB-bovenkant
ridge_h     = 1.5;
screws      = [[27.4,18.8],[-26.8,18.2],[18.5,-27.0],[-17.9,-27.4]]; // PCB-montagegaten
screw_head_d = 7;    // vrijloop rond schroefkop

/* [Wegbreekbare steunvinnen] */
sup_on     = true;
sup_t      = 0.8;    // dikte vin (2 perimeters)
sup_gap    = 0.3;    // spleet tussen vin en kegel
sup_tooth  = 0.8;    // lengte tandje (verbinding vin <-> kegel)
sup_pitch  = 5;      // afstand tussen tandjes langs de vin
sup_n      = 16;     // aantal vinnen (gelijk verdeeld over het hoekbereik)
sup_ring_r = 14;     // straal verbindingsring rond de PIR-top (raakt enkel de vinnen)
sup_ring_w = 1.2;    // breedte ring
sup_ring_h = 0.6;    // hoogte ring (3 lagen)
sup_from   = -40;    // hoekbereik (wiskundig, 0 = +X) ...
sup_to     = 220;    // ... steile RJ45-kant (-Y) blijft vrij
sup_r0     = 8;      // vinnen starten op deze straal rond de PIR-top
sup_rmax   = 34;     // max. straal t.o.v. PCB-midden (vrij van richel en klemnokjes)

// ---------------------------------------------------------------------
function upos(a, r) = [-r*sin(a), -r*cos(a)];   // gebruikershoek -> XY
module at_angle(a) rotate([0,0,270 - a]) children(); // lokale +X = radiaal naar buiten

R  = outer_d/2;
Rp = pcb_d/2 + clr;
inner_skirt_h = 5.6;           // geeft ±2 mm wand over de kegel

module disc(d, z) translate([0,0,z]) cylinder(d=d, h=0.01);

module outer_cone()
    hull() {
        cylinder(r=R, h=skirt_h);
        translate([0,-pir_ecc,0]) disc(plateau_d, top_z - 0.01);
    }

module inner_cone()
    hull() {
        translate([0,0,pcb_t + ridge_h]) cylinder(r=R - wall, h=inner_skirt_h - pcb_t - ridge_h);
        translate([0,-pir_ecc,0]) disc(plateau_d - 1, top_z - wall - 0.01);
    }

module inner_cavity() {
    inner_cone();
    translate([0,0,-1]) cylinder(r=Rp, h=1 + pcb_t + ridge_h + 0.01); // PCB-kamer
}

// --- RJ45 tunnel ---
module rj_outer()
    intersection() {
        cylinder(r=R, h=50);
        at_angle(0) translate([rj_back - clr - wall, rj_off - rj_w/2 - clr - wall, 0])
            cube([R, rj_w + 2*(clr + wall), rj_h + clr + wall]);
    }
module rj_channel()
    at_angle(0) translate([rj_back - clr, rj_off - rj_w/2 - clr, -1])
        cube([R + 5, rj_w + 2*clr, rj_h + clr + 1]);

// --- DHT22 vak ---
module dht_outer()
    intersection() {
        cylinder(r=R, h=50);
        at_angle(dht_ang) translate([dht_in - clr - wall, -dht_len/2 - clr - wall, 0])
            cube([R, dht_len + 2*(clr + wall), dht_h + 0.5 + wall]);
    }
module dht_cavity()
    intersection() {
        translate([0,0,-1]) cylinder(r=Rp, h=50);
        at_angle(dht_ang) translate([dht_in - clr, -dht_len/2 - clr, -1])
            cube([R, dht_len + 2*clr, dht_h + 0.5 + 1]);
    }

// --- roosters / gaten ---
module vent(p) translate([p[0], p[1], -1])
    if (grille)
        intersection() {
            cylinder(d=vent_d, h=60);
            for (x=[-vent_d/2 : g_pitch : vent_d/2], y=[-vent_d/2 : g_pitch : vent_d/2])
                translate([x - g_hole/2, y - g_hole/2, 0]) cube([g_hole, g_hole, 60]);
        }
    else cylinder(d=vent_d, h=60);

// --- richel en klemribbels ---
module ridge()
    difference() {
        translate([0,0,pcb_t + 0.05]) difference() {
            cylinder(r=Rp + 0.1, h=ridge_h - 0.05);
            translate([0,0,-1]) cylinder(r=Rp - ridge_w, h=ridge_h + 2);
        }
        for (s=screws) translate([s[0], s[1], -1]) cylinder(d=screw_head_d, h=20);
    }

module clips()
    for (a=clip_angles) at_angle(a)
        hull() {
            // voet, ingebed in de wand, over de volle hoogte
            translate([Rp, -clip_w/2, 0]) cube([0.2, clip_w, pcb_t + ridge_h]);
            // punt: volle indrukking pas boven de invoerschuinte
            translate([pcb_d/2 - clip_interf, -clip_tip/2, clip_lead])
                cube([0.01, clip_tip, pcb_t + ridge_h - clip_lead]);
        }

// =====================================================================
// --- wegbreekbare steunvinnen ---
module sup_slabs()
    translate([0, -pir_ecc, 0])
        for (i=[0 : sup_n - 1]) rotate([0,0, sup_from + i*(sup_to - sup_from)/(sup_n - 1)])
            translate([sup_r0, -sup_t/2, 0]) cube([70, sup_t, 40]);

module sup_keepout()   // gebied waar geen vinnen mogen komen
    union() {
        // DHT22-vak + wanden
        at_angle(dht_ang) translate([dht_in - clr - wall - sup_gap, -dht_len/2 - clr - wall - sup_gap, -1])
            cube([R, dht_len + 2*(clr + wall + sup_gap), 50]);
        // RJ45-tunnel
        at_angle(0) translate([rj_back - clr - wall - sup_gap, rj_off - rj_w/2 - clr - wall - sup_gap, -1])
            cube([R, rj_w + 2*(clr + wall + sup_gap), 50]);
    }

module sup_area()
    difference() { cylinder(r=sup_rmax, h=50); sup_keepout(); }

module sup_fins()
    intersection() {
        sup_slabs();
        sup_area();
        union() {
            translate([0,0,-sup_gap]) inner_cone();
            cylinder(r=sup_rmax, h=pcb_t + ridge_h);   // onderste deel tot op het bed
        }
    }

module sup_teeth()
    intersection() {
        sup_slabs();
        sup_area();
        difference() { inner_cone(); translate([0,0,-sup_gap - 0.01]) inner_cone(); }
        translate([0, -pir_ecc, 0])
            for (d=[sup_r0 + 2 : sup_pitch : 70])
                difference() { cylinder(r=d + sup_tooth/2, h=40); translate([0,0,-1]) cylinder(r=d - sup_tooth/2, h=42); }
    }

module sup_ring()
    translate([0, -pir_ecc, 0]) difference() {
        cylinder(r=sup_ring_r + sup_ring_w/2, h=sup_ring_h);
        translate([0,0,-1]) cylinder(r=sup_ring_r - sup_ring_w/2, h=sup_ring_h + 2);
    }

module supports() { sup_fins(); sup_teeth(); sup_ring(); }

module cap() {
    difference() {
        union() {
            difference() {
                union() { outer_cone(); rj_outer(); dht_outer(); }
                inner_cavity();
            }
            ridge();
            clips();
        }
        rj_channel();
        dht_cavity();
        translate([0,-pir_ecc,-1]) cylinder(d=pir_hole_d, h=60);
        let(p=upos(ldr_ang, ldr_r)) translate([p[0],p[1],-1]) cylinder(d=ldr_hole_d, h=60);
        vent(upos(vent1_ang, vent1_r));
        vent(upos(dht_ang, vent2_r));
    }
}

cap();
if (sup_on) difference() {   // steun niet in openingen laten uitsteken
    supports();
    translate([0,-pir_ecc,-1]) cylinder(d=pir_hole_d, h=60);
}
