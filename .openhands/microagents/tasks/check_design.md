---
name: check_design
type: task
version: 1.0.0
agent: CodeActAgent
description: Guide for reviewing Atopile modules and circuit designs
inputs:
  - name: MODULE_PATH
    description: "Path to the module to review"
    required: true
triggers:
  - review
  - check
  - verify
  - validate
---

# Guide to Reviewing Atopile Modules

This guide outlines the process of reviewing a module in Atopile.

## Common Electrical Engineering Issues to Check

IMPORTANT: When in doubt, always refer to the datasheet of the component, located in the .ato/modules/<component_name>/datasheet/<datasheet_name>.md file.

### Power Supply
- Verify voltage ratings match component requirements
  - Check absolute maximum ratings in datasheets
  - Ensure adequate voltage margins for noise/ripple
  - Verify minimum operating voltages are met
- Check bypass/decoupling capacitor values and placement
  - Appropriate capacitance values for frequency range
  - Low ESR capacitors where needed
  - Placed close to power pins

### Signal Integrity 
- Review I2C/SPI/UART routing
  - Keep traces short and matched lengths
  - Avoid crossing split planes
  - Use appropriate termination
- Check for adequate noise margins
  - Ground bounce mitigation
  - Cross-talk between signals
  - EMI/EMC considerations

### Component Selection
- Verify component ratings
  - Current handling capability
  - Power dissipation
  - Temperature range
- Check package sizes are appropriate
  - Adequate pad sizes for manufacturing
  - Thermal considerations
  - Component spacing/clearance

### Protection Circuits
- ESD protection on external connections
- Reverse polarity protection where needed
- Overvoltage/overcurrent protection
- Inrush current limiting

### Layout Considerations
- Component placement optimization
  - Minimize trace lengths
  - Group related components
  - Thermal management
- Power and ground planes
  - Adequate copper weight
  - Proper plane splits
  - Return path considerations
- Manufacturing constraints
  - DFM rules followed
  - Adequate test points
  - Fiducial marks if needed

### Documentation
- Verify pin assignments match datasheet
- Check power requirements are documented
- Interface specifications clearly defined
- Operating conditions specified

## Making sure the project compiles

Always run `pcb build` to make sure the project actually compiles, if it does not, check the files in .ato/modules for things like wrong spelling or syntax problems in the main file.

NEVER edit the files in the .ato folder, they are READ ONLY
