

# Introduction

Easy to control window geometry. 


# Required

- vim +python
- xdotool (ubuntu platform can install like 'apt-get install xdotool')


# Commands

~~~
  :ControlWindow                you can give no parame. it will just center
                                the window what vim is working in.

  :ControlWindow [margin]       if you just give one parame, it will count the
                                window size, then do margin top right down
                                left base on 'margin'

  :ControlWindow [marginLeftRight] [marginTopBottom] 
                                'marginLeftRight' means the window will margin
                                'left' and 'top' what it is. 'marginTopBottom'
                                means the window will margin 'top' and 'bottom'
                                what it is.

~~~
# Variables

                        g:controlwindow#top#margin

this variable means `Screen Heigh` must be reduced it is value when do command
action. ubuntu platform, it's very reasonable to reduced the `unity panel` height
when it count the height.
