# TO-DO:
#
# Improve waystone_teleport particle effects + sounds
# General cleanup
# Take teleportation rune / implement rune uses/durability via NBT

teleportation_rune_test1:
    type: item
    material: flint
    mechanisms:
        nbt: destination/waystone_test1
    display_name: <dark_purple>Test Teleportation Rune
    lore:
    - ""
    - "Right click at a waystone to teleport."

teleportation_rune_test2:
    type: item
    material: flint
    mechanisms:
        nbt: destination/waystone_test2
        display_name: <dark_purple>Test Teleportation Rune
    lore:
    - "Right click at a waystone to teleport."

create_waystone_command:
    type: command
    name: createwaystone
    description: Creates a waystone cuboid around the user.
    usage: /createwaystone <&lt>name<&gt>
    permission: allodia.admin.createwaystone
    script:
    - if <context.args.is_empty> || <context.args.size> > 1:
        - narrate "<red>Improper usage. Use /createwaystone <&lt>name<&gt>."
    - else:
        - inject create_waystone

create_waystone:
    type: task
    script:
    - note <player.location.add[-5,-5,-5].to_cuboid[<player.location.add[5,5,5]>]> as:waystone_<context.args.get[1]>
    - narrate "<green>Waystone region <&dq>waystone_<context.args.get[1]><&dq> successfully created."

waystone_listener:
    type: world
    events:
        after player enters waystone_*:
        - if <player.item_in_hand.has_nbt[destination]>:
            - flag player inwaystone:true
            - playsound <player.location> sound:BLOCK_BEACON_ACTIVATE volume:10 pitch:0.5
            - while <player.location.is_within[<context.area>]> && <player.item_in_hand.has_nbt[destination]>:
                - playeffect effect:ENCHANTMENT_TABLE at:<context.area.blocks[lodestone].first.center> quantity:10 data:0.8 offset:0,2,0
                - wait 2t
        on player exits waystone_*:
        - if <player.item_in_hand.has_nbt[destination]>:
            - flag player inwaystone:!
            - playsound <player.location> sound:BLOCK_BEACON_DEACTIVATE volume:10 pitch:0.5
        - else:
            - playsound <player.location> sound:ENTITY_VILLAGER_AMBIENT volume:10 pitch:1
            - narrate "<&color[#A181B4]><italic>Maybe I should come back with a teleportation rune.." targets:<player>
        after player scrolls their hotbar in:waystone_* item:teleportation_rune_*:
        - flag player inwaystone:true
        - playsound <player.location> sound:BLOCK_BEACON_ACTIVATE volume:10 pitch:0.5
        - while <player.item_in_hand.has_nbt[destination]> && <player.has_flag[inwaystone]>:
            - playeffect effect:ENCHANTMENT_TABLE at:<player.location.find.blocks[lodestone].within[5].first.center> quantity:10 data:0.8 offset:0,2,0
            - wait 2t
        on player right clicks lodestone in:waystone_* with:teleportation_rune_*:
        - inject waystone_teleport

waystone_teleport:
    type: task
    script:
    - define destination <context.item.nbt[destination]>
    - if <context.location.is_within[<[destination]>]>:
        - narrate "<red>You are already here!"
        - stop
    - else:
        - teleport <player> <cuboid[<[destination]>].spawnable_blocks.random>
