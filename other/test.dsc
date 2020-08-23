my_first_task:
    type: task
    script:
    - narrate "hello world this is my first script"
    - run my_second_task

my_second_task:
    type: task
    script:
    - narrate "this is the second script"

health_scare:
    type: task
    script:
    - narrate "you think you're so special with <player.health> left?"
    - hurt <player> <util.random.decimal[0].to[<player.health.div[2]>]>
    - narrate "take that <player.name>! now you only have <player.health> left."

world_script:
    type: world
    events:
        on player breaks stone with:diamond_pickaxe:
        - narrate "Whoa <player.name>, you broke a <context.material.name>! You aren't allowed to do that."
        - determine cancelled

healing_bell:
    type: world
    events:
        on player right clicks bell:
        - if <player.health_percentage> > 90:
            - actionbar "<red>The bell does nothing, you are healthy enough."
        - else if <player.health_percentage> < 25:
            - actionbar "<red>The bell can not save you now."
        - else:
            - actionbar "<green>The bell has healed you!"
            - heal

def_sample:
    type: task
    script:
    - define current <player.health>
    - define goal <util.random.int[2].to[10]>
    - narrate "Your health is <[current]>. Your goal is <[goal]>. Let's heal you to <[current].add[<[goal]>]>!"
    - heal <[goal]>

better_with_defs:
    type: world
    events:
        after player breaks *_ore:
        - ratelimit <player> 30s
        - define health <player.health>
        - if <[health]> < 5:
            - narrate "You mined a <context.material.name>! Pretty impressive."
            - wait 2s
            - narrate "But shouldn't you be healing, not mining, <player.name>?"
            - wait 2s
            - narrate "You only have <[health]> left."