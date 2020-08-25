new_players:
    type: world
    events:
        on player joins:
        - if !<player.has_flag[user]>:
            - flag player user:true