# frozen_string_literal: true

# mixin
module Illustrator
  SCAFFOLD = "
        -------------
        |
        |
  "

  HEAD = "     ( )
  "

  NECK = "      |
  "

  TORSO = "     | |
       | |
       ~~~
  "

  RIGHT_ARM = "   --| |
     | | |
     O ~~~
  "

  LEFT_ARM = "   --| |--
     | | | |
     O ~~~ O
  "

  RIGHT_LEG = "   --| |--
     | | | |
     O ~~~ O
       |
       |
       D
  "

  LEFT_LEG = "   --| |--
     | | | |
     O ~~~ O
       | |
       | |
       D D
  "

  BODY = [SCAFFOLD, HEAD, NECK, TORSO, RIGHT_ARM, LEFT_ARM, RIGHT_LEG, LEFT_LEG]
  BODY.reverse!
end
