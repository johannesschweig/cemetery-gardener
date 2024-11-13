label house:
    show screen house
    $ renpy.pause(hard=True)
screen house:
    imagemap:
        ground "bg_house.jpg"
        hotspot(703, 721, 89, 41) action Jump("shovel")
        hotspot(587, 165, 262, 118) action [ToggleScreen("house"), Jump("overview")]
        textbutton "Inventory" action [ToggleScreen("house"), ToggleScreen("inventory")] xpos 0.75 ypos 0.01 text_style "textbutton_style"

label shovel:
    "This is a shovel"
    $ renpy.pause(hard=True)

