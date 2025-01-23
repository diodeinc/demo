---
name: create_board
type: task
version: 1.0.0
author: atopile
agent: CodeActAgent
description: Guide for creating new circuit boards in Atopile
inputs:
  - name: BOARD_PATH
    description: "Path where the board should be created"
    required: true
triggers:
  - board
  - boards
  - create board
  - new board
---

# Guide to Implementing Boards in Atopile

This guide outlines the process of creating a new board in Atopile.

A board is an atopile project that uses component drivers to create a complete board.

## 0. Workspace Structure 

ALWAYS Understand the workspace structure by running `ls -R` or `tree -L 2`.

```bash
# List the workspace structure
tree -L 2
```

## 1. Planning

The first step is to plan the board. This includes:

- Deciding on the components to use
- Deciding on the power requirements
- Deciding on the electrical requirements

## 2. Component Driver Selection

Once you have a plan, you can start selecting components. You should not use components directly, but instead you should create drivers for them. Refer to the drivers/txs0108e/txs0108e.ato and drivers/drv8833/drv8833.ato to see how to implement a new driver.  

If a driver does not exist, you should create a new driver. Refer to the drivers/txs0108e/txs0108e.ato and drivers/drv8833/drv8833.ato to see how to implement a new driver. Instructions for creating a new driver are in the `prompts/new_driver.md` file.

## 3. Board schematic

Once you have selected the components, you can start creating the board schematic. 

