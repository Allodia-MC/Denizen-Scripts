hud_toggle:
    type: command
    name: hud
    description: Toggle display of the HUD.
    usage: /hud <&lt>enable/disable<&gt>
    permission: allodia.perm.hud
    tab completions:
        1: enable|disable
    script:
    - if <context.args.is_empty>:
        - narrate "<red>Improper usage. Use /hud <&lt>enable/disable<&gt>."
        - stop
    # could this next portion be better done with a choose/case layout?
    - if <context.args.get[1].contains_text[enable]>:
        - flag player hud:enabled
        - inject hud_enable
    - if <context.args.get[1].contains_text[disable]>:
        - flag player hud:disabled
        - inject hud_disable
    - else:
        - narrate "<red>Improper usage. Use /hud <&lt>enable/disable<&gt>."

hud_updater:
    type: world
    debug: true
    events:
        on tick every:10:
        - if <player.flag[hud]> == enabled:
            - actionbar ""
        - else:
            - stop

hud_enable:
    type: task
    script:
    - actionbar  players:<player> title:<player.location.direction>

