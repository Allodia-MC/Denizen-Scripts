#-------------------#
#-- CORE COMMANDS --#
#-------------------#

# TO DO:
# Add narrations for the give/set/take cases of the mainxp command
# Test everything
# Tab completions

allodia:
    type: command
    name: allodia
    description: Allodia main help menu.
    usage: /allodia
    permission: allodia.admin.help
    tab completions:
    # TO DO
    script:
    - if <context.args.is_empty>:
        - inject help_menu
        - stop

    - define first_args <list[admin]>
    - define first_arg_input <context.args.first>
    - if !<[first_arg_input].contains[<[first_args]>]>:
        - inject invalid_syntax
        - stop

    - define second_args <list[class|classxp|mainlevel]>
    - define second_arg_input <context.args.get[2]>
    - if !<[second_arg_input].contains[<[second_args]>]>:
        - inject invalid_syntax
        - stop
    - if <[second_arg_input].contains[class]>:
        - inject class_command
        - stop

    - define target <server.match_player[<context.args.get[4]>]>

    - if <[second_arg_input].contains[classxp]>:
        - define xp <context.args.get[5]>
        - if !<[xp].is_integer>:
            - inject invalid_syntax
            - stop
        - if <[xp].contains[.]>:
            - inject invalid_syntax
            - stop
        - if <[xp]> < 0:
            - inject invalid_syntax
            - stop
        - choose <context.args.get[3]>:
            - case give:
                - inject xp_increase
#                - narrate
            - case take:
                - flag <[target]> classxp:-:<[xp]>
#                - narrate
            - case set:
                - flag <[target]> classxp:<[xp]>
#                - narrate
            - case default:
                - inject invalid_syntax
                - stop
        
    - if <[second_arg_input].contains[mainlevel]>:
        - define levelinput
        - if !<[levelinput].is_integer>:
            - inject invalid_syntax
            - stop
        - if <[levelinput].contains[.]>:
            - inject invalid_syntax
            - stop
        - if <[levelinput]> < 0:
            - inject invalid_syntax
            - stop
        - else:
            - flag <[target]> mainlevel:<[levelinput]>
#            - narrate


help_menu:
    type: task
    script:
    - narrate

invalid_syntax:
    type: task
    script:
    - narrate "<red>Improper usage. Use /allodia for help."