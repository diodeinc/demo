---
name: pcb_command
type: knowledge
agent: CodeActAgent
description: Knowledge about the PCB command line tool and its usage
version: 1.0.0
triggers:
  - pcb
---

## Terminal Commands
- Search: `pcb search <COMPONENT_MPN> --json` (run in `components/` folder)
- Install: `pcb search --install <searched_component_id>`
- Create Library: `pcb new <path/to/library>`
- Add Dependency: `pcb add <path/to/component>`
- Build Project: `pcb build`
