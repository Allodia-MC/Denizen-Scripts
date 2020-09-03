new_players:
    type: world
    events:
        on player joins:
        - if !<player.has_flag[user]>:
            - flag player user
            - flag player username:<player.name>
            - flag player class:explorer
            - flag player mainlevel:1
            - flag player classxp:0

last_seen:
    type: world
    events:
        on player quits:
        - flag player logofftime:<player.last_played_time>

flagtest:
    type: task
    script:
    - flag server players.<player.uuid>:<player.name>