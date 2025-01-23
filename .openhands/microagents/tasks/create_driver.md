---
name: create_driver
type: task
version: 1.0.0
agent: CodeActAgent
description: Guide for creating new component drivers in Atopile
inputs:
  - name: COMPONENT_MPN
    description: "Manufacturer Part Number of the component"
    required: true
triggers:
  - driver
  - drivers
  - new driver
  - create driver
---

# Guide to Implementing Component Drivers in Atopile


## Steps to Create a Driver
1. **Install Component**

   - Navigate to components directory
   - Use `create_component` task to install
   - If multiple package variants are available:
     - Install all relevant package variants
     - Example: For TXS0108E, install both RGYR and ZXYR packages

2. **Create Driver Project**


   ```bash
   pcb new drivers/<driver_name>

   # After creating a new driver, always add the generics lib
   cd /absolute/path/to/drivers/<driver_name>
   pcb add ../../atopile/generics
   ```

3. **Add Dependencies**

   ```bash
   cd /absolute/path/to/drivers/<driver_name>
   pcb add ../../components/<component_name>
   ```

4. **Implement Driver Structure**
   Create `drivers/<driver_name>/<driver_name>.ato` with, after referencing the component datasheet in component/<component_name>/datasheet/<datasheet_name>.md

   ```atopile
   # Imports
   from "generics/interfaces.ato" import Power, GPIO
   from "<ComponentName>/<ComponentName>.ato" import ComponentName

   # Main module
   module DriverName:
       """Module description"""

       """Parameters"""
       v_min: voltage = 1.2V
       v_max: voltage = 3.6V

       """Interfaces"""
       power_in = new Power

       """Components"""
       driver = new _InternalDriver

       """Connections"""
       driver.vcc ~ power_in.vcc

   # Interface module
   module _Driver:
       """Internal signals"""
       signal vcc
       signal gnd

   # Package module
   module _SpecificPackage from _Driver:
       """Package implementation"""
       ic = new ComponentName
       vcc ~ ic.VCC
       gnd ~ ic.GND
   ```

## Example Implementation

<example>
from "generics/interfaces.ato" import Power, GPIO, DcMotor
from "generics/capacitors.ato" import Capacitor
from "generics/resistors.ato" import Resistor

from "DRV8833RTYT/DRV8833RTYT.ato" import DRV8833RTYT
from "DRV8833PWP/DRV8833PWP.ato" import DRV8833PWP
from "DRV8833PW/DRV8833PW.ato" import DRV8833PW

module Drv8833:
    """A dual H-bridge motor driver module based on the DRV8833RTYT.
    Capable of driving two DC motors or one stepper motor.
    Features:
    - 2.7V to 10.8V operating voltage
    - 1.5A RMS current per H-bridge (2A peak)
    - Low MOSFET On-Resistance: HS + LS 360 mΩ
    - PWM Winding Current Regulation and Current Limiting
    - Thermal Protection (150°C shutdown)
    - Sleep mode for power saving
    - Overcurrent Protection (2-3.3A trip)
    - Undervoltage Lockout (2.5V)
    """

    """Parameters"""
    # Current sense resistor value for current limiting
    # Using 0.2 ohm gives us a chopping current of 1A (200mV/0.2ohm)
    r_sense: resistance = 0.2ohm +/- 10%
    
    # Operating voltage range
    v_min: voltage = 2.7V
    v_max: voltage = 10.8V
    
    """Signals"""
    signal gnd
    
    """Interfaces"""
    # Power supply input (2.7V to 10.8V)
    power_in = new Power
    power_in.gnd ~ gnd
    
    # Motor outputs using DcMotor interface
    motor_a = new DcMotor
    motor_b = new DcMotor
    
    # Control inputs
    ain1 = new GPIO
    ain2 = new GPIO
    bin1 = new GPIO
    bin2 = new GPIO
    
    # Sleep control (active high)
    n_sleep = new GPIO
    
    # Fault output (active low, open-drain)
    n_fault = new GPIO
    
    """Components"""
    driver = new _DRV8833RTYT
    
    # Capacitors
    # VCP bypass capacitor (0.01µF, 16V min)
    vcp_cap = new Capacitor
    vcp_cap.value = 0.01uF +/- 10%
    vcp_cap.voltage = 16V
    vcp_cap.package = "0402"
    
    # VINT bypass capacitor (2.2µF, 6.3V min)
    vint_cap = new Capacitor
    vint_cap.value = 2.2uF +/- 10%
    vint_cap.voltage = 6.3V
    vint_cap.package = "0402"
    
    # Current sense resistors
    aisen_r = new Resistor
    aisen_r.value = r_sense
    aisen_r.power = 0.1W  # P = I²R = (1A)² * 0.2Ω = 0.2W, using 0.1W per resistor
    aisen_r.package = "0402"
    
    bisen_r = new Resistor
    bisen_r.value = r_sense
    bisen_r.power = 0.1W
    bisen_r.package = "0402"
    
    """Connections"""
    # Power connections
    driver.vm ~ power_in.vcc
    driver.gnd ~ gnd
    
    # Motor A connections
    driver.aout1 ~ motor_a.a
    driver.aout2 ~ motor_a.b
    
    # Motor B connections
    driver.bout1 ~ motor_b.a
    driver.bout2 ~ motor_b.b
    
    # Control connections
    driver.ain1 ~ ain1.io
    driver.ain2 ~ ain2.io
    driver.bin1 ~ bin1.io
    driver.bin2 ~ bin2.io
    
    # Sleep and fault
    driver.n_sleep ~ n_sleep.io
    driver.n_fault ~ n_fault.io
    
    # Current sense resistors
    driver.aisen ~ aisen_r.p1
    aisen_r.p2 ~ gnd
    
    driver.bisen ~ bisen_r.p1
    bisen_r.p2 ~ gnd
    
    # VCP capacitor connections
    driver.vcp ~ vcp_cap.p1
    driver.vm ~ vcp_cap.p2
    
    # VINT capacitor connections
    driver.vint ~ vint_cap.p1
    vint_cap.p2 ~ gnd

module _Driver:
    """Interface module for DRV8833 driver signals, used for generic driver."""
    signal gnd
    signal ain1
    signal ain2
    signal bin1
    signal bin2
    signal n_sleep
    signal n_fault
    signal aout1
    signal aout2
    signal bout1
    signal bout2
    signal aisen
    signal bisen
    signal vcp
    signal vint
    signal vm

module _DRV8833RTYT from _Driver:
    """Internal module for DRV8833RTYT."""
    ic = new DRV8833RTYT
    
    gnd ~ ic.GND_PPAD_1
    gnd ~ ic.GND_PPAD_2
    ain1 ~ ic.AIN1
    ain2 ~ ic.AIN2
    bin1 ~ ic.BIN1
    bin2 ~ ic.BIN2
    n_sleep ~ ic.NSLEEP
    n_fault ~ ic.NAFULT
    aout1 ~ ic.AOUT1
    aout2 ~ ic.AOUT2
    bout1 ~ ic.BOUT1
    bout2 ~ ic.BOUT2
    aisen ~ ic.AISEN
    bisen ~ ic.BISEN
    vcp ~ ic.VCP
    vint ~ ic.VINT
    vm ~ ic.VM

module _DRV8833PWP from _Driver:
    """Internal module for DRV8833PWP."""
    ic = new DRV8833PWP
    
    gnd ~ ic.GND_1
    gnd ~ ic.GND_2
    ain1 ~ ic.AIN1
    ain2 ~ ic.AIN2
    bin1 ~ ic.BIN1
    bin2 ~ ic.BIN2
    n_sleep ~ ic.NSLEEP
    n_fault ~ ic.NFAULT
    aout1 ~ ic.AOUT1
    aout2 ~ ic.AOUT2
    bout1 ~ ic.BOUT1
    bout2 ~ ic.BOUT2
    aisen ~ ic.AISEN
    bisen ~ ic.BISEN
    vcp ~ ic.VCP
    vint ~ ic.VINT
    vm ~ ic.VM

module _DRV8833PW from _Driver:
    """Internal module for DRV8833PW."""
    ic = new DRV8833PW
    
    gnd ~ ic.GND
    ain1 ~ ic.AIN1
    ain2 ~ ic.AIN2
    bin1 ~ ic.BIN1
    bin2 ~ ic.BIN2
    n_sleep ~ ic.NSLEEP
    n_fault ~ ic.NFAULT
    aout1 ~ ic.AOUT1
    aout2 ~ ic.AOUT2
    bout1 ~ ic.BOUT1
    bout2 ~ ic.BOUT2
    aisen ~ ic.AISEN
    bisen ~ ic.BISEN
    vcp ~ ic.VCP
    vint ~ ic.VINT
    vm ~ ic.VM
</example>

## IMPORTANT GUIDELINES

- NEVER create drivers manually, ALWAYS use the `pcb new` command
- ALWAYS read atopile/generics/interfaces.ato to see what interfaces are available
- ALWAYS connect all signals for the interfaces
- ALWAYS use the `pcb build` command to ensure the module compiles
- ALWAYS `pcb add ../atopile/generics` to make sure you have the right dependencies
- ALWAYS add tolerances to all resistor and capacitor values (default to 10% unless otherwise specified)

