# RoomSense-kapje – ontwerpdocumentatie

| | |
|---|---|
| **Onderdeel** | 3D-geprint afdekkapje voor de RoomSenseboX v3.0 PCB (iTroniX) |
| **Versie** | v1.1 – 2026-10-05 |
| **Bronbestand** | `RoomSense_cap.scad` (OpenSCAD, volledig parametrisch) |
| **Printbestand** | `RoomSense_cap.stl` |
| **PCB-referentie** | Eagle `RoomsenseboX-v3.0.brd` (export `RoomsenseboX-v3.0-brd-RD-dim.pdf`) |

## 1. Beschrijving

Het kapje dekt de RoomSenseboX-PCB af, die plat tegen het plafond of de muur geschroefd zit. De onderrand van het kapje valt samen met de onderkant van de PCB. Het kapje klemt op de PCB-rand en heeft geen eigen schroeven nodig.

Belangrijkste wijziging t.o.v. het oude (verloren) ontwerp: de grote 5 V **HC-SR501** PIR is vervangen door de kleine 3,3 V **AM312** PIR. Die zit excentrisch, vlak naast de RJ45-connector. Daardoor is de kegel **scheef**: de top met het PIR-plateau ligt boven de AM312. Aan de RJ45-kant loopt de kegel steil af, aan de overkant flauw.

### Onderdelen op de PCB die het kapje bedient

| Onderdeel | Functie in het kapje |
|---|---|
| AM312 PIR | Opening Ø 15 mm in het plateau. De lens steekt erdoor naar buiten. |
| LDR | Lichtopening Ø 10 mm |
| DS18B20-2 | Ventilatierooster Ø 10 mm erboven (luchttemperatuur) |
| DHT22 / AM2302 (T&H) | Eigen vak dat overgaat in de kegel, met een rooster van Ø 10 mm erboven |
| RJ45 | Open tunnel. De stekker blijft in de connector zitten. |
| 4 PCB-montageschroeven | Uitsparingen in de binnenrichel voor de schroefkoppen |

## 2. Assenstelsel

- **Oorsprong:** middelpunt van de PCB.
- **z = 0:** onderkant van de PCB, dus het plafond- of muurvlak.
- **Bovenaanzicht, hoeken (wijzerzin):**

| Hoek | Richting | Onderdeel |
|---|---|---|
| 0° | −Y (onder) | RJ45 |
| 90° | −X (links) | LDR |
| 270° | +X (rechts) | DHT22 |

In de code zet `upos(hoek, straal)` een hoek uit deze conventie om naar XY.

## 3. Afmetingen

### 3.1 PCB (gemeten / uit Eagle)

| Item | Waarde |
|---|---|
| PCB-diameter | 72,0 mm |
| PCB-dikte | 1,75 mm |
| Montagegaten PCB (Ø 3,2) | (27,4 ; 18,8), (−26,8 ; 18,2), (18,5 ; −27,0), (−17,9 ; −27,4), dus R ≈ 33,2 mm |
| RJ45-behuizing (Eagle) | X −8,6 … +7,0 / Y −20,0 … −38,6. Steekt 2,6 mm buiten de PCB-rand. |
| RJ45-breedte (gemeten) | 16,2 mm, midden op X = −0,8 mm |
| RJ45-hoogte incl. PCB | 16 mm |
| PIR-header (3-pin) | midden (−0,4 ; −12,0) |
| PIR-lens AM312 | Ø 12,13 mm, midden op 17,8 mm van het centrum richting RJ45 (staat schuin op de header) |
| LDR | (−26,1 ; 0), dus 90°, R 26,1 |
| DS18B20-2 | (−24,9 ; −16), dus ≈ 57°, R 29,7 |
| DHT22-header (TH) | Y −13, X 21,7 … 29,4 |
| DHT22-voetafdruk | 28 × 18 mm op 270°, symmetrisch t.o.v. de as. Binnenkant op R 15,2, buitenhoeken op de PCB-rand. |
| DHT22-hoogte incl. PCB | 10 mm |

### 3.2 Kapje

| Item | Waarde | Parameter |
|---|---|---|
| Buitendiameter | Ø 80 mm | `outer_d` |
| Wanddikte | 2,0 mm | `wall` |
| Speling (algemeen) | 0,3 mm | `clr` |
| Binnendiameter PCB-kamer | Ø 72,6 mm | `pcb_d + 2·clr` |
| Hoogte verticale rand | 7 mm vanaf onderkant PCB | `skirt_h` |
| Bovenkant plateau | 23 mm boven het PCB-oppervlak (24,75 mm vanaf onderkant) | `top_above` |
| Plateau rond PIR | Ø 21 mm, middelpunt (0 ; −17,8) | `plateau_d`, `pir_ecc` |
| PIR-opening | Ø 15 mm | `pir_hole_d` |
| LDR-opening | Ø 10 mm op 90°, R 26,1 | `ldr_hole_d`, `ldr_ang`, `ldr_r` |
| Rooster DS18B20 | Ø 10 mm op 57°, R 28 | `vent1_ang`, `vent1_r`, `vent_d` |
| Rooster DHT22 | Ø 10 mm op 270°, R 24,2 (midden van het DHT-vak) | `vent2_r` |
| Roostergaatjes | 1,2 × 1,2 mm, steek 2,0 mm | `g_hole`, `g_pitch`, `grille` |
| RJ45-tunnel, inwendig | 16,8 mm breed (16,2 + 2·0,3), 16,3 mm hoog vanaf onderkant PCB | `rj_w`, `rj_h`, `rj_off` |
| RJ45-tunnel, begin | 19,7 mm van het centrum (achterkant connector − speling) | `rj_back` |
| RJ45-tunnel, einde | Gelijk met de buitenrand van het kapje. Open naar buiten voor de stekker. | – |
| DHT22-vak, inwendig | 28,6 × radiaal tot de PCB-rand, 10,5 mm hoog vanaf onderkant PCB | `dht_len`, `dht_w`, `dht_h`, `dht_in` |
| DHT22-vak, buitenkant | Plat dak op 12,5 mm, gaat over in de kegel | – |

### 3.3 Bevestiging (klemmen zonder schroeven)

| Item | Waarde | Parameter |
|---|---|---|
| Binnenrichel | 1,5 mm breed × 1,5 mm hoog. Drukt de PCB tegen het plafond. | `ridge_w`, `ridge_h` |
| Uitsparing schroefkoppen | Ø 7 mm rond elk PCB-montagegat | `screw_head_d` |
| Klemnokjes (crush ribs) | 5 stuks op 55°, 90°, 160°, 200°, 305° | `clip_angles` |
| Profiel nokje | Driehoekig: voet 2,0 mm, punt 0,4 mm | `clip_w`, `clip_tip` |
| Indrukking in de PCB-rand | 0,35 mm | `clip_interf` |
| Invoerschuinte | 1,2 mm hoog vanaf de onderrand | `clip_lead` |

De nokjes vermijden de schroeven, de RJ45 en de hoeken van de DHT22.

**Montage:** schroef eerst de PCB vast met de 4 schroeven. Druk daarna het kapje recht over de PCB tot de rand tegen het plafond zit. De RJ45-stekker kan erin blijven zitten.

## 4. Printen

| Instelling | Advies |
|---|---|
| Materiaal | PETG of PLA(+), zwart |
| Nozzle | 0,4 mm |
| Laaghoogte | 0,2 mm |
| Oriëntatie | Rand op het bed (zoals gemodelleerd) |
| Support | Tree supports **binnenin**, voor de flauwe kegelzijde (±20°) |
| Gewicht / tijd (schatting) | ±15–20 g, ±1,5–2 u per stuk |

**Proefprint eerst!** Controleer:
1. **Klemkracht:** zit het kapje te stroef, verlaag `clip_interf` (bv. 0,2). Zit het te los, verhoog die waarde.
2. **PIR-lens:** past de schuine lens vrij door de opening van Ø 15 mm?
3. **Hoge componenten:** blijven de LDR en de DS18B20 vrij van de binnenkant van de kegel?

## 5. Aanpassen en exporteren

1. Open `RoomSense_cap.scad` in OpenSCAD.
2. Pas de parameters bovenaan het bestand aan.
3. Render met **F6** en exporteer met **File → Export → STL**.

Of via de commandoregel:

```bash
openscad -o RoomSense_cap.stl RoomSense_cap.scad
```

Werk bij elke wijziging de versiekop in het `.scad`-bestand bij, en ook de versietabel hieronder.

## 6. Versiegeschiedenis

| Versie | Datum | Wijziging |
|---|---|---|
| v1.0 | 2026-10-05 | Eerste versie: AM312 PIR (excentrisch, scheve kegel), Ø 80 mm zonder schroefgaten, klemribbels + binnenrichel, RJ45-tunnel, DHT22-vak, 2 roosters, verstevigingsringen rond LDR- en roostergat |
| v1.1 | 2026-10-05 | Verstevigingsringen verwijderd. Klemnokjes taps gemaakt: driehoekig profiel + invoerschuinte van 1,2 mm. |
