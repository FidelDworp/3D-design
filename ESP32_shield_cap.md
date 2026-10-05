# ESP32-shield-kapje – ontwerpdocumentatie

| | |
|---|---|
| **Onderdeel** | 3D-geprint afdekkapje voor de ESP32-C6 ZARLAR shield v2.0 (iTroniX) |
| **Versie** | v1.4 – 2026-10-05 |
| **Bronbestand** | `ESP32_shield_cap.scad` (OpenSCAD, volledig parametrisch) |
| **Logo** | `itronix_logo.svg` (moet naast het `.scad`-bestand staan) |
| **Printbestand** | `ESP32_shield_cap.stl` (logo zit er al in) |
| **PCB-referentie** | Eagle `ESP32 shield v2.0.brd` (export `ESP32_shield_v2.0_BRD.pdf`, afgedrukt op f = 2.00 → maten ÷ 2) |

## 1. Beschrijving

Het kapje is een rechthoekige doos zonder bodem. Het dekt de ESP32-C6 ZARLAR shield af, die met 4 hoekschroeven rechtstreeks op een plankje vastzit. De rand van het kapje zakt tot op het plankje. Het kapje klikt vast met taps toelopende klemnokjes op de PCB-rand en heeft geen eigen schroeven nodig.

- **Doorvoeren:** alle doorvoeren voor kabels zitten in de **zijwanden**, als sleuven die **onderaan open** zijn. Je kunt het kapje dus over de aangesloten kabels schuiven.
- **Antenne:** de antenne van de ESP32 steekt door een sleuf in de bovenwand naar buiten, zodat de behuizing het signaal niet hindert.
- **Dak:** het dak is dicht, met het **iTroniX-logo** en de naam 0,6 mm verzonken.

### Onderdelen op de PCB die het kapje bedient

| Onderdeel | Functie in het kapje |
|---|---|
| ESP32-C6 DevKitC-1 (op headers) | Vrije hoogte 19,5 mm (module + USB-C-stekker = 18 mm). Antennesleuf in de bovenwand. |
| RJ45 ROOMSENSE | Uitsparing in de rechterwand |
| RJ45 OPTIONAL | Uitsparing in de rechterwand (voor latere bestukking) |
| Power IN (schroefklem 2p) | Sleuf in de linkerwand |
| PIXEL-LINE (4p) | Sleuf in de onderwand, voor een WS2812-stick of een reep powerpixels |
| SPI/IO-header (11p) | Lange sleuf in de linkerwand |
| I2C (5p) | Sleuf in de rechterwand |
| UART (4p) | Sleuf in de bovenwand |
| T-BUS (3p) | Sleuf in de bovenwand |
| 4 hoekschroeven | Binnenhoeken krap afgerond (r 0,5 mm), zodat de schroefkoppen vrij blijven |

## 2. Assenstelsel

- **Oorsprong:** linkeronderhoek van de PCB.
- **Oriëntatie:** de tekst "ESP32-C6 ZARLAR shield" staat onderaan, de RJ45-connectoren zitten rechts en de antenne wijst naar boven.
- **z = 0:** het plankje, dus de onderkant van de PCB.

| Wand | Ligt aan | Positie langs de wand |
|---|---|---|
| Links (L) | X = 0 | Y |
| Rechts (R) | X = 79,7 | Y |
| Onder (B) | Y = 0 | X |
| Boven (T) | Y = 81,2 | X |

## 3. Afmetingen

### 3.1 PCB (uit Eagle, gemeten)

| Item | Waarde |
|---|---|
| PCB | 79,7 × 81,2 mm, dikte 1,6 mm |
| Montagegaten Ø 3,2 | (2,8 ; 2,8), (3,0 ; 78,3), (76,8 ; 2,8), (76,8 ; 78,3) |
| ESP32-C6 DevKitC-1 | 2 × 16 pins, rijen op X 17,1 en 40,0, Y 40,8 … 78,9 |
| Antenne ESP32 | X 19,6 … 37,6, steekt tot Y 86,8 (5,6 mm buiten de PCB-rand), 12–17 mm boven de PCB |
| Hoogte ESP32 + USB-C-stekker | 18 mm boven de PCB-bovenkant |
| RJ45 ROOMSENSE | Y 56,0 … 72,2 (midden 64,1), steekt 0,5 mm buiten de rechterrand |
| RJ45 OPTIONAL | Y 36,9 … 53,2 (midden 45,05) |
| RJ45-breedte / -hoogte | 16,2 mm / ±14,25 mm boven de PCB (aanname, zie §5) |
| Power IN (schroefklem, steek 5 mm) | X 6,7, Y 11,8 (+) en 16,8 (−) |
| PIXEL-LINE (GND, DO/33 Ω, 5V, 5V) | Y 3,8, X 8,9 … 16,5 |
| SPI/IO (3V3, 0, 8, 15, 23, 22, 21, 20, 9, GND + SPI CS/MOSI/MISO/SCK) | X 4,4, Y 22,5 … 53,3 |
| I2C (SCL, SDA, GND, 3V3, VCC_5V) | X 75,5, Y 14,6 … 24,8 |
| UART (GND, TX, RX, 3V3) | X 48,5, Y 71,1 … 78,8 |
| T-BUS (3V3, GND, sig) | Y 78,1, X 66,7 … 71,7 |

### 3.2 Kapje

| Item | Waarde | Parameter |
|---|---|---|
| Binnenmaat | 80,3 × 81,8 mm (PCB + 2 × 0,3 mm) | `pcb_w`, `pcb_l`, `clr` |
| Buitenmaat | **84,3 × 85,8 × 23,1 mm** | – |
| Wand- en dakdikte | 2,0 mm | `wall` |
| Speling | 0,3 mm | `clr` |
| Vrije hoogte boven PCB | 19,5 mm | `in_h` |
| Afronding buiten / binnen | r 3 mm / r 0,5 mm | `r_out`, `r_in` |
| Antennesleuf (bovenwand) | X 19,3 … 37,9, 12–17 mm boven de PCB | `ant_x`, `ant_z` |
| RJ45-uitsparingen (rechterwand) | 16,8 mm breed rond Y 64,1 en 45,05, open van onderaan tot 14,55 mm boven de PCB. Tussen beide blijft een stijltje van 2,2 mm. | `rj_yc`, `rj_w`, `rj_h` |

### 3.3 Wandsleuven

Alle sleuven zijn **onderaan open** en lopen van het plankje tot **4 mm boven de PCB-bovenkant** (parameter `slot_h`).

| Sleuf | Wand | Bereik |
|---|---|---|
| Power IN | links | Y 8,5 … 19,6 |
| SPI/IO (11p) | links | Y 21,6 … 55,1 (stijltje van 2 mm t.o.v. Power IN) |
| I2C (5p) | rechts | Y 12,8 … 26,6 |
| PIXEL-LINE (4p) | onder | X 7,4 … 18,0 |
| UART (4p) | boven | X 43,4 … 53,6 |
| T-BUS (3p) | boven | X 64,9 … 73,5 |

Je past de sleuven aan in de lijst `wall_slots` als `["wand", van, tot]`.

### 3.4 Bevestiging (klemnokjes)

| Item | Waarde | Parameter |
|---|---|---|
| Aantal | 12 (3 per wand) | – |
| Links | Y 4, 62, 75 | `clips_left` |
| Rechts | Y 6, 31, 78 | `clips_right` |
| Onder | X 30, 50, 70 | `clips_bottom` |
| Boven | X 10, 40, 59 | `clips_top` |
| Profiel | Driehoekig (crush rib): voet 2,0 mm, punt 0,4 mm | `clip_w`, `clip_tip` |
| Indrukking in de PCB-rand | 0,35 mm | `clip_interf` |
| Invoerschuinte | 1,2 mm vanaf de onderrand | `clip_lead` |
| Hoogte nokje | tot 1,5 mm boven de PCB | `clip_top` |

De nokjes vallen nergens in een sleuf of uitsparing.

**Montage:** sluit eerst alle kabels aan. Schuif daarna het kapje recht van bovenaf over de shield tot de rand op het plankje staat. De kabels glijden daarbij in de open sleuven.

### 3.5 Logo

| Item | Waarde | Parameter |
|---|---|---|
| Bestand | `itronix_logo.svg`, uit het originele Illustrator-bestand `iTroniX Logo.ai` (1200 dpi gerenderd en overgetrokken) | `logo_file` |
| Breedte × hoogte | 60 × ±51 mm | `logo_w` |
| Diepte gravure | 0,6 mm (3 lagen van 0,2 mm). Het dak blijft daaronder 1,4 mm. | `logo_depth` |
| Positie | Midden van het dak | `logo_pos` |
| Aan / uit | `true` | `logo_on` |

## 4. Printen

| Instelling | Advies |
|---|---|
| Materiaal | PETG of PLA(+), zwart |
| Nozzle | 0,4 mm |
| Laaghoogte | 0,2 mm |
| Oriëntatie | **Dak op het bed** (ondersteboven). Het verzonken logo komt dan scherp uit. |
| Support | Normaal niet nodig. De bovenkant van de antennesleuf en van de RJ45-uitsparingen zijn korte bruggen (≤ 19 mm). |

## 5. Te controleren bij de proefprint

1. **Klemkracht:** zit het kapje te stroef, verlaag `clip_interf` (bv. 0,2). Zit het te los, verhoog die waarde.
2. **RJ45-hoogte:** de aanname is 14,25 mm boven de PCB, zoals bij de RoomSense-PCB. Meet je eigen connector na.
3. **Antenne:** steekt die vrij door de sleuf van 12–17 mm?
4. **Logo:** de fijnste punten van de bliksemschichten zijn smaller dan 0,5 mm. Zijn ze dichtgelopen, verhoog dan `logo_w` naar bv. 70 mm.

## 6. Aanpassen en exporteren

1. Zet `ESP32_shield_cap.scad` en `itronix_logo.svg` in dezelfde map.
2. Open het `.scad`-bestand in OpenSCAD en pas de parameters bovenaan aan.
3. Render met **F6** en exporteer met **File → Export → STL**.

Of via de commandoregel:

```bash
openscad -o ESP32_shield_cap.stl ESP32_shield_cap.scad
```

Werk bij elke wijziging de versiekop in het `.scad`-bestand bij, en ook de versietabel hieronder.

## 7. Versiegeschiedenis

| Versie | Datum | Wijziging |
|---|---|---|
| v1.0 | 2026-10-05 | Eerste versie: doos zonder bodem, klemnokjes op 4 zijden, antennesleuf, 2 × RJ45, L-vensters voor Power IN en PIXEL-LINE, sleuven in het dak |
| v1.1 | 2026-10-05 | Alle doorvoeren naar de zijwanden verplaatst, dak volledig dicht, klemnokjes verplaatst |
| v1.2 | 2026-10-05 | Wandsleuven onderaan open, zodat het kapje over de aangesloten kabels schuift |
| v1.3 | 2026-10-05 | iTroniX-logo + naam 0,6 mm verzonken in het dak (overgetrokken van een JPG) |
| v1.4 | 2026-10-05 | Logo vervangen door een versie uit het originele `.ai`-bestand, met scherpere contouren |
