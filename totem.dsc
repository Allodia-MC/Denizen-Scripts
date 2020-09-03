totem_animation:
    type: command
    name: animatetotem
    description: Runs the Totem resurrection animation for player.
    usage: /animatetotem <&lt>playername<&gt>
    permission: allodia.perm.animatetotem
    tab completions:
        1: <server.online_players.parse[name]>
    script:
    - if <context.args.is_empty>:
        - animate <player> animation:TOTEM_RESURRECT
    - else:
        - animate <context.args.get[1].as_player> animation:TOTEM_RESURRECT

# this command is working, but requires a resource pack to change totem texture and sound