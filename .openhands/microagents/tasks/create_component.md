---
name: create_component
type: task
version: 1.0.0
agent: CodeActAgent
description: Guide for creating new components in Atopile
inputs:
  - name: COMPONENT_MPN
    description: "Manufacturer Part Number of the component"
    required: true
triggers:
  - component
  - components
  - new component
  - create component
---

# Guide to Creating Components in Atopile

This guide outlines the process of creating a new component in Atopile.

A component is a direct representation of a physical part that can be purchased and placed on a PCB. Components are the building blocks used by drivers and boards.

## 1. [OPTIONAL] Navigate to Components Directory

Components MUST be created in the components directory, IF AND ONLY IF you are not in the components directory, then you must navigate to it:

```bash
cd /absolute/path/to/components/
```

## 2. Search for Component

```bash
pcb search <COMPONENT_MPN> --json
```

## 3. Install Component

```bash
pcb search --install <component_id>
```

## 4. Guidelines

- ALWAYS use the `pcb search` command to find the correct component
- ALWAYS use the `pcb search --install` command to install the component
- NEVER modify pcb.toml directly
- NEVER create new components manually
- If a component installation fails, try installing another variant of the component
