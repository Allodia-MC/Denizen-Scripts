tax_setup:
    type: task
    script:
    - foreach <server.players>:
        - flag player previousbalance:<player.money>

daily_tax:
    type: world
    events:
        on system time 05:00:
        - define bracket1targets <server.players.filter[money.is[OR_MORE].than[20000]].filter[money.is[LESS].than[40000]]>
        - define bracket2targets <server.players.filter[money.is[OR_MORE].than[40000]].filter[money.is[LESS].than[80000]]>
        - define bracket3targets <server.players.filter[money.is[OR_MORE].than[80000]]>
        - foreach <[bracket1targets]>:
            - define b1taxableincome <player.money.sub[<player.flag[previousbalance]>]>
            - money take quantity:<[b1taxableincome].mul[0.18]>
        - foreach <[bracket2targets]>:
            - define b2taxableincome <player.money.sub[<player.flag[previousbalance]>]>
            - money take quantity:<[b2taxableincome].mul[0.30]>
        - foreach <[bracket3targets]>:
            - define b3taxableincome <player.money.sub[<player.flag[previousbalance]>]>
            - money take quantity:<[b3taxableincome].mul[0.42]>
        - foreach <server.players.filter_tag[<util.time_now.duration_since[<[filter_value].last_played_time>].in_hours.is[OR_LESS].than[24]>]>:
            - flag player previousbalance:<player.money>