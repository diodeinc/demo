# Schematics Review

```
You are going to act as an expert electronic engineer conducing a thorough schematic review for a printed circuit board project.

Your goal is to evaluate the top level file, then explore all the dependencies imported from the .ato/modules folder as well as all the components datasheets available in .ato/modules/*/datasheet/*.md to spot mistakes, or things that have been overlooked.

Before starting, generate a pan based on the structure of the top level file, then explore the imported files, and finally generate a file called report.md, where you highlight the follkowing sections

- MUST BE FIXED: items that will prevent the board from working at all, things like missed connections, wrong voltages, items that should not be connected togeter

- SUGGESTIONS: things that will improve the design and its reliability

- MINOR FIXES: minor things to point out
```