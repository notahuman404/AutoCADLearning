# Starbie

Starbie is a small motion-controlled digital pet built around a Seeed Studio XIAO ESP32-C3. It draws a one-bit pet on a 128×64 OLED, uses an MPU6050 to read tilt and shaking, and offers a four-way action menu. A DHT11 can provide temperature and humidity readings.

## Project images

<table>
  <tr>
    <td align="center"><strong>Concept render</strong><br><img src="assests/ConceptRender.png" alt="Starbie concept render" width="420"></td>
    <td align="center"><strong>3D PCB render</strong><br><img src="assests/3dRender.png" alt="Starbie PCB 3D render" width="420"></td>
  </tr>
  <tr>
    <td align="center"><strong>PCB layout</strong><br><img src="assests/PCB.png" alt="KiCad PCB layout" width="420"></td>
    <td align="center"><strong>Schematic</strong><br><img src="assests/Schematic.png" alt="KiCad schematic" width="420"></td>
  </tr>
</table>

## Features

- Animated pet with nap, play, feed, and pet actions.
- Tilt-controlled radial menu, using the MPU6050 as a simple air mouse.
- Shake reaction that wakes Starbie and changes its stats.
- Stats screen for joy, energy, fullness, and available sensor readings.
- Joy, energy, and fullness are saved using the ESP32 Preferences storage; stats do not drain while idle.

## Hardware

| Part | Role |
| --- | --- |
| Seeed Studio XIAO ESP32-C3 | Controller and firmware target |
| 0.96-inch 128×64 I²C OLED, SSD1306-compatible | Pet display |
| MPU6050 / GY-521 module | Tilt and shake sensing |
| DHT11 | Optional temperature and humidity sensing |
| 2 Cherry MX-compatible 1U switches | Menu/action and stats controls |
| 10 kΩ through-hole resistor | Listed as R1 in the schematic |
| Custom PCB | KiCad design in the starbie directory |

See BOM.csv for the current parts list. The schematic shows the MPU6050 connection through J2, a generic 1x08 connector: pins 1-4 carry +3.3V, GND, SCL, and SDA. BOM.csv lists the MPU6050/GY-521 breakout separately from the board-mounted J2 header because the exact module part number is not specified.

## Wiring

The firmware pin assignments are in Firmware/Starbie/Starbie.ino. OLED and MPU6050 share I²C.

| Device | XIAO connection | Notes |
| --- | --- | --- |
| OLED SDA | D4 / GPIO6 | I²C address defaults to 0x3C |
| OLED SCL | D5 / GPIO7 | Shared I²C bus |
| MPU6050 SDA | D4 / GPIO6 | I²C address defaults to 0x68 |
| MPU6050 SCL | D5 / GPIO7 | Shared I²C bus |
| DHT11 data | D1 / GPIO3 | Optional; set USE_DHT11 to false if not fitted |
| Button 1 | D2 / GPIO4 | Opens the menu; confirms the selected action |
| Button 2 | D3 / GPIO5 | Shows or hides the stats screen |

Connect module power and ground according to the module labels and the schematic. Verify voltage and pin order before powering the board.

## Firmware setup

1. Install Arduino IDE and add the Espressif ESP32 board package URL: https://espressif.github.io/arduino-esp32/package_esp32_index.json
2. Install the ESP32 board package by Espressif Systems and select XIAO_ESP32C3 under Tools → Board → esp32.
3. Install Adafruit GFX Library, Adafruit SSD1306, Adafruit MPU6050, and DHT sensor library. Accept the IDE's dependency prompts.
4. Open Firmware/Starbie/Starbie.ino, check the beginner settings and pin assignments, then upload to the XIAO ESP32-C3.

Button 1 opens the four-way menu. Tilt toward top for NAP, right for PLAY, bottom for FEED, or left for PET; press Button 1 again to confirm. Button 2 toggles stats. Shaking Starbie gives it a reaction and wakes it from a nap. The DHT11 can be disabled with USE_DHT11 if that sensor is not installed.

## Repository layout

- Firmware/Starbie/Starbie.ino — Arduino firmware.
- starbie/ — KiCad schematic, board, and project files.
- assests/ — project renders, schematic, and PCB images (the directory name is intentionally kept as it exists in the repository).
- 3D Models/ — STEP models for the display, switches, sensor module, and controller.
- Imported Parts.pretty/ — custom KiCad footprints.

## Reference

This project follows the [Starbie Week 1 guide](https://github.com/SharKingStudios/Starbie/blob/main/Week%201%20Guide.md).
