#import "@preview/diagraph:0.1.0": *
#import "@local/docs/assets/formatting.typ": *

#let project-name = "Demo PCB"
#let project-subtitle = "Heart Rate Monitor Demo"
#let project-version = "1.0.0"
#let project-status = "Draft"
#let project-date = datetime.today().display("[year]-[month]-[day]")

#show: project-template.with(
  title: project-name,
  subtitle: project-subtitle,
  version: project-version,
  status: project-status,
  date: project-date,
)

= Overview

The Demo project is a compact electronic device featuring a heart rate sensor connected to an RP2040 microcontroller. It includes a USB Type-C connector for power and communication, along with a 3.3V power supply system. The device is designed for biometric monitoring applications with a simple and modular architecture.

== Features

- RP2040 microcontroller for processing and control
- MAX30102 heart rate and pulse oximeter sensor
- USB Type-C connectivity for power and data
- 3.3V regulated power supply (RT9013-33GB)
- I2C communication between microcontroller and sensor
- Tactile boot button (KMR211NGLFS)
- Modular design with clear separation of functions

== Block Diagram

#align(center)[
  #diagram(
    spacing: 1cm,
    node-stroke: 0.5pt,
    node-fill: rgb("#f5f5f5"),
    edge-stroke: 0.5pt,
    node((0, 0), [USB-C\nConnector], shape: "rectangle", width: 3cm, height: 1.5cm),
    node((5, 0), [3.3V Power\nSupply], shape: "rectangle", width: 3cm, height: 1.5cm),
    node((2.5, -3), [RP2040\nMicrocontroller], shape: "rectangle", width: 3cm, height: 1.5cm),
    node((7.5, -3), [MAX30102\nHeart Rate Sensor], shape: "rectangle", width: 3cm, height: 1.5cm),
    edge((1.5, 0), (3.5, 0), [5V]),
    edge((6.5, 0), (4, -2.25), [3.3V]),
    edge((1, -0.75), (2, -2.25), [USB]),
    edge((4, -3), (6, -3), [I2C]),
  )
]

= Technical Specifications

== System Components

#table(
  columns: (auto, 1fr, 1fr),
  [*Component*], [*Description*], [*Function*],
  [RP2040Kit], [Raspberry Pi RP2040 microcontroller module], [Main processing unit],
  [MAX30102EFD+T], [Heart rate and pulse oximeter sensor], [Biometric sensing],
  [RT9013-33GB], [3.3V linear voltage regulator], [Power management],
  [KH-TYPE-C-16P], [USB Type-C connector], [Power input and data],
  [KMR211NGLFS], [Tactile switch], [Boot mode selection],
)

== Power Requirements

- Input voltage: 5V from USB
- Operating voltage: 3.3V (internally regulated)
- Power path: USB → 5V → 3.3V regulator → Microcontroller and sensors

== Communication Interfaces

- USB 2.0 for host communication
- I2C for sensor interface

= Module Documentation

== USB Connector Module

The USB Connector module provides USB 2.0 communication and 5V power from a USB Type-C connector.

=== Interfaces
- USB 2.0 data interface
- 5V power output

== Power Supply Module

The Power Supply module converts the 5V input from USB to a regulated 3.3V output for the microcontroller and sensors.

=== Interfaces
- 5V input from USB
- 3.3V regulated output

== Microcontroller Module

The Microcontroller module uses an RP2040 to process sensor data and communicate with a host device.

=== Interfaces
- 3.3V power input
- I2C master interface
- USB 2.0 device interface
- Boot button interface

== Heart Rate Sensor Module

The Heart Rate Sensor module uses the MAX30102 sensor to measure pulse and blood oxygen levels.

=== Interfaces
- I2C slave interface
- Integrated biometric sensing

= Design Guidelines

== Power Supply Recommendations

The power supply is based on the RT9013-33GB linear regulator, which provides a stable 3.3V output from the 5V USB input. For battery-powered applications, it's recommended to:

1. Add a battery management system
2. Consider a more efficient switching regulator
3. Implement power saving modes

== PCB Layout

- Keep I2C traces short and with consistent impedance
- Place decoupling capacitors close to power pins
- Ensure good thermal dissipation for the regulator
- Isolate analog and digital ground planes where appropriate
- Place the sensor away from heat-generating components

= Application Examples

== Health Monitoring

This design can be integrated into wearable health monitoring devices to track heart rate and blood oxygen levels.

== Educational Use

The modular design makes this project ideal for educational purposes, demonstrating:
- Microcontroller programming
- Sensor integration
- Power management
- Digital communication protocols

= References

- RP2040 datasheet
- MAX30102 datasheet
- RT9013-33GB datasheet
- USB Type-C specifications 