# Blockwelt – Roblox Studio version

This folder contains a Roblox Studio recreation of the Blockwelt browser demo. It creates a simple block-style neighborhood with roads, houses, trees, a small park, and flowers. There is no music or audio.

## Add it to Roblox Studio

1. Open a Roblox Studio place (Baseplate is fine).
2. In **ServerScriptService**, create a **Script** named `Blockwelt` and paste in `ServerScriptService/Blockwelt.server.lua`.
3. In **StarterPlayer > StarterPlayerScripts**, create a **LocalScript** named `BlockweltHUD` and paste in `StarterPlayer/StarterPlayerScripts/Blockwelt.client.lua`.
4. To add 10 melee attackers, create a **Script** in **ServerScriptService** named `MeleeRobots` and paste in `ServerScriptService/MeleeRobots.server.lua`.
5. To show your 100-HP bar at the top-right, create a **LocalScript** in **StarterPlayer > StarterPlayerScripts** named `PlayerHealth` and paste in `StarterPlayer/StarterPlayerScripts/PlayerHealth.client.lua`.
6. Press **Play** to test.

Robots and players both have 100 HP. Each robot has a health bar above it. A robot deals 10 damage every 1 second to a player within 7 studs. The robots wander until a player is nearby, then close in and attack with melee damage. They deal no damage to each other.
