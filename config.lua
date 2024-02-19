Config = {}

-- Framework
Config.Core = 'qb-core'
Config.Target = 'qb-target'

-- Loot
Config.Markedbills = true -- if true it will give you cash as a item
Config.MoneyItem = 'markedbills'
Config.Cash = math.random(3000, 5000) -- Not used. Config on server.

-- Reward
Config.RewardItem = 'electronic_card'
Config.RewardChance = math.random(2, 3) -- Not used. Config on server.

-- Item
Config.RequiredItem = 'rope'

-- Police
Config.RequiredPolice = 2
Config.PSDispacth = false
Config.Dispatch = 'ps-dispatch'

--Hack -- Not used. We've changed mini game.
Config.Hack = {
    Type = 'numeric', -- Type (alphabet, numeric, alphanumeric, greek, braille, runes)
    Time = '15'       -- Time (Seconds)
}