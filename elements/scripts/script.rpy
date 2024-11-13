# Rainer Neumann - Cemetery Administration
define a = Character("Rainer Neumann")
# Travel agency
define t = Character("Woman from Travel Agency")

label start:
    show screen overview
    "After a 3-hour drive, you finally arrive. Solkwitz, a village of 1,000 souls in the countryside and part of your police district. Boris Amburger, 49, who has been employed as a cemetery gardener in Solkwitz for 3 years, disappeared a few days ago."
    "This was reported by an employee of the cemetery administration after the person in question did not show up for work. You look at the shop windows in the village center. A bakery advertises coffee for 1.50 and rolls for 35 cents."
    "At a fork in the road, you turn right and shortly afterwards the cemetery is in front of you. Tall oak trees are generously distributed between gravestones and paths."
    "You park your car in the parking lot in front of the entrance and can already see the cemetery administrator with whom you have arranged to meet."
    a "It's great that you were able to come so quickly. My name is Rainer Neumann, I'm the cemetery manager here. Mr. Amburger worked as a cemetery gardener for a few years and also lived on the property."
    a "He points to a house at the back of the cemetery. A few days ago I tried to reach him about a funeral, but he didn't answer."
    a "I then drove here, but he seemed to have disappeared off the face of the earth. As far as I know, he had no acquaintances or friends here in the village."
    a "One of the villagers last saw him in the cemetery a week ago. It's all pretty strange. Why would someone just disappear like that? But maybe he didn't like it."
    a "He was actually very reliable. I'm sorry, I can't tell you any more about that. Unfortunately, I have to find a successor quickly now."
    # TODO
    "You say goodbye to him and decide to have a look around the cemetery first. Take marker 51 from the board."
    $ renpy.pause(hard=True)

# TODO
# disable scroll mousewheel to scroll through content
# better menu/start
# remove whitescreen at the bottom
