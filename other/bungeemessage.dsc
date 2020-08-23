server_switch:
    type: world
    debug: true
    events:
        on bungee player switches to gamehub:
        - narrate "<&8>[<&6>»<&8>] <&6><context.name> <&7>has moved to <&e><context.server><&7>." targets:<server.online_players>