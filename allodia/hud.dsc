# TO-DO:
#
# implement current region name in the HUD, check <player.location.note_name>

hud_toggle:
    type: command
    name: hud
    description: Toggle display of the HUD.
    usage: /hud <&lt>enable/disable<&gt>
    permission: allodia.command.hud
    tab completions:
        1: enable|disable
    script:
    - if <context.args.is_empty> || <context.args.size> > 1:
        - narrate "<red>Improper usage. Use /hud <&lt>enable/disable<&gt>."
        - stop
    # could this next portion be better done with a choose/case layout?
    - if <context.args.get[1].contains_text[enable]> && !<player.flag[hud_enabled]>:
        - flag player hud_enabled:true
        - inject hud_enable
        - narrate "<green>Successfully enabled HUD."
        - stop
    - if <context.args.get[1].contains_text[enable]> && <player.flag[hud_enabled]>:
        - narrate "<red>Your HUD is already enabled."
        - stop
    - if <context.args.get[1].contains_text[disable]> && <player.flag[hud_enabled]>:
        - flag player hud_enabled:false
        - inject hud_disable
        - narrate "<red>Successfully disabled HUD."
        - stop
    - if <context.args.get[1].contains_text[disable]> && !<player.flag[hud_enabled]>:
        - narrate "<red>Your HUD is already disabled."
        - stop
    - else:
        - narrate "<red>Improper usage. Use /hud <&lt>enable/disable<&gt>."

hud_enable:
    type: task
    script:
    - bossbar create hud players:<player> "title:<&7><player.location.x.round_to[0]> <&f><&l><player.location.direction.replace_text[north].with[N].replace_text[south].with[S].replace_text[east].with[E].replace_text[west].with[W].replace_text[northwest].with[NW].replace_text[northeast].with[NE].replace_text[southwest].with[SW].replace_text[southeast].with[SE]> <&7><player.location.z.round_to[0]>" style:SOLID color:YELLOW progress:0.0

hud_disable:
    type: task
    script:
    - bossbar remove hud

hud_updater:
    type: world
    debug: false
    events:
        on tick every:30:
        - foreach <server.online_players> as:player:
            - if <[player].flag[hud_enabled]>:
                - bossbar update hud players:<[player]> "title:<&7><[player].location.x.round_to[0]> <&f><&l><[player].location.direction.replace_text[north].with[N].replace_text[south].with[S].replace_text[east].with[E].replace_text[west].with[W].replace_text[northwest].with[NW].replace_text[northeast].with[NE].replace_text[southwest].with[SW].replace_text[southeast].with[SE]> <&7><[player].location.z.round_to[0]>"
            - else:
                - stop

# hud_join_listener listens for new players and then enables the hud + flags them, or just enables the hud for flagged players on login
hud_join_listener:
    type: world
    debug: true
    events:
        on player joins:
        - if !<player.has_flag[hud_enabled]>:
            - inject hud_enable
            - flag player hud_enabled:true
        - if <player.flag[hud_enabled]>:
            - inject hud_enable
        - else:
            - stop


