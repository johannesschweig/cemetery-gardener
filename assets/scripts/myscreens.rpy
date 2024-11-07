# Define the custom style for textbuttons
style textbutton_style:
    size 24

label overview:
    show screen overview
    $ renpy.pause(hard=True)
# Overview
screen overview:
    imagemap:
        ground "bg_map.jpg"
        hotspot(418, 339, 236, 240) action [ToggleScreen("overview"), ToggleScreen("house")]
        hotspot(835, 379, 211, 169) action Jump("fountain")
        hotspot(1091, 370, 364, 282) action Jump("burialGround")
        hotspot(798, 3, 219, 302) action Jump("chapel")
        hotspot(832, 755, 218, 38) action Jump("parkingLot")
        hotspot(1004, 788, 123, 148) action Jump("policeCar")
        textbutton "Inventory" action [ToggleScreen("overview"), ToggleScreen("inventory")] xpos 0.75 ypos 0.01 text_style "textbutton_style"


label fountain:
    "It is an old stone fountain with a statue in the middle. It is completely frozen over. Under you can see a fist-sized rectangular object under the ice. You knock against the ice. It is several centimeters thick."
    $ renpy.pause(hard=True)
label burialGround:
    "On the burial ground there are neat rows of graves with headstones on the icy meadow."
    $ renpy.pause(hard=True)
# TODO
label chapel:
    "The chapel is a red brick building. The small chimney rises defiantly into the sky. Inside you will find a mourning hall with seating (38) and a lectern (39). Outside you will find a ramp that leads into the cellar of the chapel and ends in front of a large gate (16). The gate is locked. Place location marker 16 on the ramp."
    $ renpy.pause(hard=True)
label parkingLot:
    "A normal parking lot paved with gray concrete blocks. Next to your car there are there are two more cars. No one is sitting in them."
    $ renpy.pause(hard=True)
# TODO
label policeCar:
    "A VW Golf patrol car with green stripes on the side. You remember that you still have a hammer in the trunk. Maybe it could come in handy. Take card 24."
    $ renpy.pause(hard=True)


