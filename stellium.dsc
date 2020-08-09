stellium_online_regen:
    type: world
    debug: true
    events:
        on time 5 in world:
        - announce "<&color[#9C5BE1]><italic>As the sun rises, you feel safe again..."
        - define targets <server.online_players.filter_tag[<placeholder[mmocore_stellium].player[<[filter_value]>].is[OR_LESS].than[9]>]>
        - narrate "<&6><bold>+1 <&7>Stellium" targets:<[targets]>
        - foreach <[targets]>:
            - execute as_server "mmocore admin resource-stellium give <[value].name> 1" silent


stellium_offline_regen:
    type: world
    debug: true
    events:
        on player quits:
        - flag player logofftime:<player.last_played_time>
        on player joins:
        - define lastseen <util.time_now.duration_since[<player.flag[logofftime]>].in_hours.round_to[2]>
        - define increase <util.time_now.duration_since[<player.flag[logofftime]>].in_hours.round>
        - if <[lastseen]> < 1:
            - stop
        - if <[lastseen]> >= 1 && <[lastseen]> <= 10:
            - execute as_op "mmocore admin resource-stellium give <player.name> <[increase]>"
            - wait 1.5s
            - narrate "<&color[#8E44AD]><italic>In your absence, you regained some of your essence..." targets:<player>
            - narrate "<&6><bold>+<[increase]> <&7>Stellium" targets:<player>
            - stop
        - if <[lastseen]> > 10:
            - define currentstellium <placeholder[mmocore_stellium].player[<player>]>
            - define longtermincrease <element[10].sub[<[currentstellium]>]>
            - execute as_op "mmocore admin resource-stellium set <player.name> 10"
            - narrate "<&color[#8E44AD]><italic>In your absence, you regained your full essence..." targets:<player>
            - narrate "<&6><bold>+<[longtermincrease]> <&7>Stellium" targets:<player>
            - stop


stellium_death:
    type: world
    debug: true
    events:
        on player death:
        - waituntil <player.is_spawned>
        - define currentstellium <placeholder[mmocore_stellium].player[<player>]>
        - define reduction 2
        - if <[currentstellium]> >= <[reduction]>:
            - execute as_server "mmocore admin resource-stellium take <player.name> <[reduction]>" silent
            - define newstellium <element[<[currentstellium]>].sub[<[reduction]>]>
            - if <[newstellium]> > 0:
                - narrate "<&color[#C0392B]><bold>You left a part of you in your past life..." targets:<player>
                - narrate "" targets:<player>
                - narrate "<&6><bold>-<[reduction]> <&7>Stellium" targets:<player>
                - narrate "<&7><italic>You have <[newstellium]> Stellium remaining."
                - stop
            - if <[newstellium]> = 0:
                - narrate "<&color[#C0392B]><bold>You can feel yourself slipping away..." targets:<player>
                - narrate "" targets:<player>
                - narrate "<&6><bold>-2 <&7>Stellium" targets:<player>
                - narrate "<&7><italic>You are now out of Stellium!" targets:<player>
                - stop
        - if <[currentstellium]> = 1:
            - execute as_server "mmocore admin resource-stellium take <player.name> 1" silent
            - narrate "<&color[#C0392B]><bold>You can feel yourself slipping away..." targets:<player>
            - narrate "" targets:<player>
            - narrate "<&6><bold>-1 <&7>Stellium" targets:<player>
            - narrate "<&7><italic>You are now out of Stellium!" targets:<player>
            - stop
        - if <[currentstellium]> = 0:
            - narrate "<&color[#C0392B]><bold>You lack your usual essence..." targets:<player>
            - narrate "" targets:<player>
            - narrate "<&7><italic>No Stellium Remaining!" targets:<player>
            - stop

# stellium_death is fully tested and functional



