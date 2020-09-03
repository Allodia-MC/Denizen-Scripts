#-----------------------------#
#-- EXPERIENCE CORE SCRIPTS --#
#-----------------------------#

xp_increase:
    type: task
    script:
    - if <[target].flag[classxp].add[<[xp]>]> >= <script[xp_curve].data_key[levels.<[target].flag[mainlevel]>.req_xp]>:
        - inject level_up
        - flag <[target]> classxp:+:<[xp]>
    - else:
        - flag <[target]> classxp:+:<[xp]>

level_up:
    type: task
    script:
    - flag <[target]> mainlevel:++
    - playeffect effect:ENCHANTMENT_TABLE at:<[target].location> quantity:10 data:0.8 offset:0,1,0
    - animate <[target]> animation:TOTEM_RESURRECT

#----------------------#
#-- EXPERIENCE CURVE --#
#----------------------#
xp_curve:
    type: data
    levels:
        1:
            req_xp: 100
        2:
            req_xp: 300

#------------------------#
#-- EXPERIENCE SOURCES --#
#------------------------#

mob_xp:
    type: data
    mobs:
        creeper:
            xp: 4
        zombie:
            xp: 3
        skeleton:
            xp: 7

mob_xp_listener:
    type: world
    events:
        on entity killed by player:
        - define xp <script[mob_xp].data_key[mobs.<context.entity>.xp]>
        - define target <context.damager>
        - inject xp_increase


