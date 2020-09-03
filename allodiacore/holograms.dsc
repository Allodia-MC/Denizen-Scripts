## MINING RESOURCES

# Iron Holograms
IronItem:
    type: entity
    entity_type: DROPPED_ITEM
    gravity: false
    item: IRON_INGOT
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
    - spawn IronItem <player.location.above[0.2]>
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