define allItems = { "carKey": False, "code": True, "crematoriumKey": False, "hammer": True, "flyer": False, "characters": False, "mobilePhone": False, "spade": True, "newsArticle": False}
# define allItems = { "carKey": False, "code": False, "crematoriumKey": False, "hammer": False, "flyer": False, "characters": False, "mobilePhone": False, "spade": False, "newsArticle": False}
define foundItems = [item for item, found in allItems.items() if found]

label inventory:
    show screen inventory
    $ renpy.pause(hard=True)

screen inventory:
    add "bg_white.jpg"
    modal True
    vbox:
        textbutton "Back" action [ToggleScreen("overview"), ToggleScreen("inventory")] xpos 0.15 ypos 0.01 text_style "textbutton_style"
    if len(foundItems) == 0:
        text "You have no items in your inventory." xpos 0.2 ypos 0.5 size 24
    else:
        vbox:
            grid 5 5:
                for item in foundItems:
                            vbox:
                                add "{}.jpg".format(item)
            # hotspot(703, 721, 89, 41) action Jump("shovel")
            # hotspot(8, 11, 179, 938) action [ToggleScreen("inventory"), ToggleScreen("overview")]

label x:
    "This is a shovel"
    $ renpy.pause(hard=True)

