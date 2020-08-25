# TO-DO:
#
# basis of resource node system, including:
#   level system of nodes
#   holograms for nodes using entitytags + armor stands and the spawn command. when player enters a resource node region, spawn in the appropriate armor stands, and despawn them when they leave
#   resource collecting animations with the animate command + ARM_SWING & sounds/block break particles for breaking things
#   look into showfakes, to show broken blocks or empty ores/cobblestone for the players
#
# rewrite resouce listener, has to listen for left/right clicks on resource nodes

# resources listener listens for all resource gathering events and cancels all block breaks
resources_listener:
    type: world
    debug: true
    events:
        on player breaks block:
        - if <context.location.regions.contains_any_text[mining]>:
            - inject mining_event
        - if <context.location.regions.contains_any_text[woodcutting]>:
            - inject woodcutting_event
        - if <context.location.regions.contains_any_text[farming]>:
            - inject farming_event
        - else:
            - determine cancelled
        on player right clicks AIR with:fishing_rod:
        - if <context.location.regions.contains_any_text[fishing]>:
            - inject fishing_event
        - else:
            - determine cancelled

mining_event:
    type: task
    script:
    - 