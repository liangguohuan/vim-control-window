

# Introduction

Easy to control window geometry. 


# Required

- vim +python
- xdotool (ubuntu platform can install like 'apt-get install xdotool')


# Commands

                :ControlWindow [top] [right] [down] [left] 
move the window like css margin style. you can do it like:

- :ControlWindow 30
- :ControlWindow 20 30
- :ControlWindow 10 30 20
- :ControlWindow 20 30 30 20


# Variables

                        g:controlwindow#top#margin

this variable means `Screen Heigh` must be reduced it is value when do command
action. ubuntu platform, it's very reasonable to reduced the `unity panel` height
when it count the height.

# Notice
xdotool can not move window topleft absolutely, it will leave 10 pixel.

