#import "@preview/gentle-clues:0.6.0": warning, error
#import "@preview/cetz:0.1.2": canvas, plot

#import "assets/diode-ds.typ": datasheet
#import "revisions.typ": revisions
#import "notes.typ": notes

#let company = (
    name:           "Diode, Inc.",
    logo:           "./diode-logo.svg",
    website_url:    "https://github.com/somecompany",
)

#let metadata = (
    title: [Demo],
    product: "DD1234",
    product_url: "https://github.com/oldrev/tids",
    confidential: false,
)

#let features = [
    - Add features here
    - ...
]


#let applications = [

    Add application description here

    - Add Applications here
    - ...

    #figure(
        rect(image("./assets/diode-logo.svg"), stroke: 0.5pt), caption: "Typical Application"
    )
]

#let desc = [
    Add description here ...

    #figure(rect(height: 30%,
    canvas(length: 0.75cm, {
        plot.plot(size: (8, 6),
        x-tick-step: 1,
        x-ticks: ((-calc.pi, $-pi$), (0, $0$), (calc.pi, $pi$)),
        y-tick-step: 1,
        {
            plot.add(
            domain: (-calc.pi, calc.pi), x => calc.sin(x * 1rad))
        })
    })
    ), caption: [Example Plot])
]

#show: doc => datasheet(
    company: company,
    metadata: metadata,
    features: features,
    applications: applications,
    desc: desc,
    revisions: revisions,
    notes: notes,
    doc: doc
)

= Specifications

== Pin Configuration and Functions
<PinConfigAndFunctions>

#lorem(30)

#lorem(30)

== Specifications
<Specifications>

#table(
    columns: (1fr, auto, auto, auto, auto, auto, 1fr),
    align: (left,center,right,right,right,left,left,),

    table.header([Parameters], [Symbol], [Minimum], [Typical], [Maximum], [Unit], [Condition]),

    [Rated Voltage], [$V_(upright("IN"))$], [5], [—], [24], [V], [—],

    [Rated Current], [$I$], [100], [150], [1,000], [mA], [Using 5V Supply],

    [High-Level Voltage], [$V_(upright("OH"))$], [4.5], [—], [—], [V], [—],

    [Low-Level Voltage], [$V_(upright("OL"))$], [—], [—], [0.5], [V], [—],

    [Output High-Level Current], [$I_(upright("OH"))$], [—], [20], [—], [mA], [—],
)

== Absolute Maximum Ratings
<AbsoluteMaximumRatings>

#table(
    columns: (auto, auto, auto, auto, auto, 1fr),
    align: (left,center,right,right,center,left),

    table.header([Parameter], [Symbol], [Minimum Value], [Maximum Value], [Unit], [Note]),

    [Power Supply Voltage], [$V_(upright("IN"))$], [0], [30], [V],[],

    [Ambient Temperature], [$T_A$], [-25], [85], [°C],[],
)

#warning(title: "Warning")[
    This is a warning
]

#error(title: "Error")[
    This is an error
]

#pagebreak()

= Detailed Description
<DetailedDescription>

== Overview

#lorem(200)

#lorem(200)

== Functional Block Diagram

#lorem(200)

#pagebreak()

= Application and Implementation

=== Application Information

#lorem(200)

=== Typical Applications

#lorem(200)

=== Design Requirements

#lorem(200)

= Power Supply Recommendations

#lorem(200)

=== PCB Layout

#lorem(200)

#pagebreak()

= Device and Documentation Support

=== Device Support

=== Related Links

#lorem(200)

#pagebreak()
  
= Mechanical, Packaging, and Orderable Information

#lorem(30)

this is something that should wor