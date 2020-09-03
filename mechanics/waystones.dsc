# TO-DO:
#
# Implement rune uses/durability via NBT
# Cleanup Titles for Confirmation Click, format destination elementtag
# Implement stellium cost
# Make particle tornado smoke, and denser/closer together bits of particles
# Add particle ring of dragon breath
# Add particles to player when they arrive

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
        - if <context.cause> == WALK:
            - flag player inwaystone
            - if <player.item_in_hand.has_nbt[destination]>:
                - flag player inwaystone:!
                - flag player activewaystone
                - playsound <player.location> sound:BLOCK_BEACON_ACTIVATE volume:10 pitch:0.5
                - while <player.location.is_within[<context.area>]> && <player.item_in_hand.has_nbt[destination]>:
                    - playeffect effect:ENCHANTMENT_TABLE at:<context.area.blocks[lodestone].first.center> quantity:10 data:0.8 offset:0,2,0
                    - wait 2t
        on player exits waystone_* flagged:inwaystone:
        - flag player inwaystone:!
        - playsound <player.location> sound:ENTITY_VILLAGER_AMBIENT volume:10 pitch:1
        - narrate "<&color[#A181B4]><italic>Maybe I should come back with a teleportation rune.."
        on player exits waystone_* flagged:activewaystone:
        - if <context.cause> == TELEPORT:
            - stop
        - if <player.item_in_hand.has_nbt[destination]>:
            - flag player activewaystone:!
            - playsound <player.location> sound:BLOCK_BEACON_DEACTIVATE volume:10 pitch:0.5
        on player exits waystone_* flagged:justteleported:
        - flag player justteleported:!
        - flag player activewaystone:!
        - if <player.item_in_hand.has_nbt[destination]>:
            - playsound <player.location> sound:BLOCK_BEACON_DEACTIVATE volume:10 pitch:0.5
        after player scrolls their hotbar in:waystone_* item:teleportation_rune_*:
        - flag player inwaystone:!
        - flag player activewaystone
        - playsound <player.location> sound:BLOCK_BEACON_ACTIVATE volume:10 pitch:0.5
        - while <player.has_flag[activewaystone]> && <player.item_in_hand.has_nbt[destination]>:
            - playeffect effect:ENCHANTMENT_TABLE at:<player.location.find.blocks[lodestone].within[7].first.center> quantity:10 data:0.8 offset:0,2,0
            - wait 2t
        on player right clicks lodestone in:waystone_* with:teleportation_rune_* flagged:activewaystone:
        - define destination <context.item.nbt[destination]>
        - if <context.location.is_within[<[destination]>]>:
            - narrate "<red>You are already here!"
            - stop
        - else:
            - title "title:<green>[ Destination ]" "subtitle:<dark_purple><context.item.nbt[destination]>" fade_in:0.25s stay:1s fade_out:0.25s
            - wait 1.5s
            - flag player confirmation duration:5s
            - title "title:<green>Right click to confirm..." "subtitle:To: <dark_purple><context.item.nbt[destination]>" fade_in:0.25s stay:4.5s fade_out:0.25s
        on player right clicks lodestone in:waystone_* with:teleportation_rune_* flagged:confirmation:
        - title "title:" "subtitle:"
        - define destination <context.item.nbt[destination]>
        - flag player activewaystone:!
        - take iteminhand
        - playsound <player.location> sound:BLOCK_END_PORTAL_FRAME_FILL volume:10 pitch:0.5
        - inject waystone_teleport

waystone_teleport:
    type: task
    script:
    - wait 1s
    - mythicskill waystone_effect <context.location.find.blocks[lodestone].within[7].first.center>
    - playsound <player.location> sound:BLOCK_RESPAWN_ANCHOR_SET_SPAWN volume:10 pitch:0.7
    - wait 3s
    - flag player justteleported
    - playsound <player.location> sound:ENTITY_ILLUSIONER_MIRROR_MOVE volume:10 pitch:0.7
    - teleport <player> <cuboid[<[destination]>].spawnable_blocks.random>