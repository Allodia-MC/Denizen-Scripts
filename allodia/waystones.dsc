# TO-DO:
#
# write basis 

teleportation_rune_test:
    type: item
    material: flint
    mechanisms:
        nbt: destination/waystone-test1
    display_name: <dark_purple>Test Teleportation Rune
    lore:
    - ""
    - "Right click at a waystone to teleport."

create_waystone_command:
    type: command
    name: createwaystone
    description: Creates a waystone cuboid around the user.
    usage: /createwaystone <&lt>name<&gt>
    permission: allodia.perm.waystones.create
    script:
    - if <context.args.is_empty>:
        - narrate "<red>Improper usage. Use /createwaystone <&lt>name<&gt>."
    - else:
        - inject create_waystone

create_waystone:
    type: task
    script:
    - note <player.location.add[-5,-5,-5].to_cuboid[<player.location.add[5,5,5]>]> as:waystone-<context.args.get[1]>

waystone_listener:
    type: world
    events:
        on player enters cuboid:
        - if <context.area.note_name.contains_text[waystone]> && !<player.item_in_hand.has_nbt[destination]>:
            - playsound <player.location> sound:ENTITY_VILLAGER_AMBIENT volume:10 pitch:1
            - narrate "<&color[#A181B4]><italic>Maybe I should come back with a teleportation rune.." targets:<player>
        - if <context.area.note_name.contains_text[waystone]> && <player.item_in_hand.has_nbt[destination]>:
            - flag player inwaystone:true
            - playsound <player.location> sound:BLOCK_BEACON_ACTIVATE volume:10 pitch:0.5
            - while <player.location.is_within[<context.area>]>:
                - inject waystone_effects
                - wait 11s
        on player exits cuboid:
        - if <context.from.note_name.contains_text[waystone]>:
            - flag player inwaystone:!
        on player scrolls their hotbar:
        - if <player.location.is_within[]>
        on player right clicks lodestone:
        - inject waystone_teleport

waystone_effects:
    type: task
    script:
    - playeffect effect:ENCHANTMENT_TABLE at:<cuboid[<context.area>].blocks[lodestone].get[1]> visibility:20 quantity:80
    - playsound <player.location> sound:BLOCK_BEACON_AMBIENT volume:10 pitch:0.5

waystone_teleport:
    type: task
    script: