excavation_override:
    type: command
    name: excavation
    description: Show the overview for the excavation skill.
    usage: /excavation
    script:
        - narrate "§aᚐᚑᚒᚓᚔᚍᚎᚏ §2§lExcavation §aᚏᚎᚍᚔᚓᚒᚑᚐ"
        - narrate "§7Level §8- §6<player.mcmmo.level[excavation]>"
        - narrate "§7Exp §8- §e<player.mcmmo.xp[excavation]>§r / §6<player.mcmmo.xp[excavation].to_next_level>"
        - narrate ""
        - narrate "§aᚐᚐᚐᚑᚒᚓᚔᚍᚎᚏ §2§lSkills §aᚏᚎᚍᚔᚓᚒᚑᚐᚐᚐ"
        - narrate "§a§l» §7Super Digger §8- §7§oRank §c§o1 §8§o/ §4§o10"
        - narrate "§a§l» §7Mana Deposit §8- §7§oRank §c§o1 §8§o/ §4§o10"
        - narrate "§a§l» §7Ignore Drops §8- §7§oRank §c§o1 §8§o/ §4§o10"
        - narrate ""
        - narrate "§2§oUse §a§o/ABILITYNAME §2§oto read about an ability, ex: §a§o/manadeposit§2§o."