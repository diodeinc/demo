---
name: stdlib
type: repo
agent: CodeActAgent
description: Knowledge about the PCB standard library repository
version: 1.0.0
---

# PCB Standard Library Repository

This repository is a library of modules and components for building PCBs. It provides a structured way to design and implement electronic circuits using Atopile.

## Repository Structure
- Atopile generics  are stored in the `atopile/generics` folder
- Components are stored in the `components/` folder and have no dependencies
- Drivers are stored in the `drivers/` folder and depend only on components
```
.
├── README.md
├── atopile
│   └── generics
├── components
|   ...
│   └── TXS0108EZXYR
└── drivers
    ...
    └── txs0108e
```

## Project Structure
- Project directories are identified by the presence of a `pcb.toml` file
- YOU CAN NEVER add dependencies to folders that DO NOT HAVE A `pcb.toml`
- Build artifacts and important information are stored in the `.ato/` folder:
  - Component datasheets can be found in `datasheet/*.md`
  - Reference these files when implementing circuits

## Atopile Syntax Guide
Key elements and their usage:
- Signals: `signal gnd`
- Instances: `new Power`
- Assignments: `vbat = new Power`
- Connections: `vbat.gnd ~ gnd`
- Sections: Marked with `"""`
- Comments: Start with `#`
- Imports: `from "generics/interfaces.ato" import Power`
- Modules: `module PowerSupply:`
- Components: `component ADS1299:`
- Units: Support for V, ohm, Hz, A, etc. (e.g., `vmax = 1000mV`)

## Generic Libraries
- interfaces.ato: `generics/interfaces.ato`
- capacitors.ato: `generics/capacitors.ato`
- resistors.ato: `generics/resistors.ato`

## Terminal Commands
Component Management:
- Search: `pcb search <COMPONENT_MPN> --json` (run in `components/` folder)
- Install: `pcb search --install <searched_component_id>`
- Create Library: `pcb new <path/to/library>`
- Add Dependency: `pcb add <path/to/component>`
- Build Project: `pcb build`

## IMPORTANT GUIDELINES
- ALWAYS `pcb add` for dependencies NEVER modify pcb.toml directly
- Prefer interfaces over signals
- Import interfaces from `generics/interfaces.ato`
- Consult component datasheets in `datasheet/<component>.md`
- NEVER create new components manually, always use `pcb search`
- NEVER create new modules manually, always use `pcb new`
- NEVER modify pcb.toml directly
- ALWAYS use the `pcb build` command to ensure the module compiles
- ALWAYS connect all signals for the interfaces
- NEVER create components for capacitors, resistors, or inductors, use the generics library instead
- ALWAYS use absolute paths when running `cd`
