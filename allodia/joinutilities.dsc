new_players:
    type: world
    events:
        on player joins:
        - if !<player.has_flag[user]>:
            - flag player user:true

last_seen:
    type: world
    events:
        on player quits:
        - flag player logofftime:<player.last_played_time>
