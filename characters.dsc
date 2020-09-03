character_selector_inventory:
    type: inventory
    inventory: chest
    title: Select Your Character
    size: 27
    definitions:
      filler: 
    slots:
      - [filler] [] [] [] [] [] [] [filler] []
      - [filler] [] [] [] [] [] [] [filler] []
      - [filler] [] [] [] [] [] [] [filler] []

character_selector_location:
    type: world
    events:
        on player quits:
        - adjust <player> location:darkness