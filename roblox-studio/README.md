# Blockwelt – Roblox Studio version

This folder contains a Roblox Studio recreation of the Blockwelt browser demo. It creates a simple block-style neighborhood with roads, houses, trees, a small park, and flowers. There is no music or audio.

## Add it to Roblox Studio

1. Open a Roblox Studio place (Baseplate is fine).
2. In **ServerScriptService**, create a **Script** named `Blockwelt` and paste in `ServerScriptService/Blockwelt.server.lua`.
3. In **StarterPlayer > StarterPlayerScripts**, create a **LocalScript** named `BlockweltHUD` and paste in `StarterPlayer/StarterPlayerScripts/Blockwelt.client.lua`.
4. Press **Play** to test. Roblox's built-in character controller provides movement, jumping, camera controls, and touch controls on mobile.

The world is generated when the server starts. You can change the colors, house/tree placement, and map size in the server script. The existing browser version remains unchanged.
