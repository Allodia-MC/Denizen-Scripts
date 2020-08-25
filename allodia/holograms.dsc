IronLine1:
    type: entity
    entity_type: ARMOR_STAND
    gravity: false
    visible: false
    custom_name_visible: true
    custom_name: "<green>Iron"
IronLine2:
    type: entity
    entity_type: ARMOR_STAND
    gravity: false
    visible: false
    custom_name_visible: true
    custom_name: "<green>✔ <gray>Mining Level Req: 2"
IronLine3:
    type: entity
    entity_type: ARMOR_STAND
    gravity: false
    visible: false
    custom_name_visible: true
    custom_name: "<gray>Left click to mine."

IronHologram:
    type: task
    script:
    - spawn IronLine1 <player.location.above[0.8]>
    - spawn IronLine2 <player.location.above[0.5]>
    - spawn IronLine3 <player.location.above[0.2]>

IronHologramCommand:
    type: command
    name: ironhologram
    usage: /ironhologram
    description: Will spawn test iron hologram.
    permission: allodia.admin.ironhologram
    script:
    - run IronHologram


HologramMaker:
    type: command
    name: hologrammaker
    usage: /hologrammaker [text to be displayed]
    aliases:
    - hmaker
    - hologram
    - holomaker
    - holo
    description: Will make holograms
    permission: allodia.admin.hologram
    script:
        - define message <context.raw_args.parse_color>
        - spawn armor_stand <player.location> save:stand visible:false custom_name:<[message]> custom_name_visible:true
        - adjust <entry[stand].spawned_entity> visible:false
        - adjust <entry[stand].spawned_entity> custom_name:<[message]>
        - adjust <entry[stand].spawned_entity> custom_name_visible:true