# Multiplayer Configuration Guide

This guide details all multiplayer configurations supported by the Tekken Tag Tournament 2 PC port, including local competitive play, cooperative pair play, and online peer-to-peer matchmaking.

---

## Local Multiplayer Modes

Tekken Tag Tournament 2 offers two distinct local multiplayer experiences:

1. Versus Battle (1v1 or 2v2):
   Two players select their own fighters and compete against one another across standard rounds.
2. Pair Play (Cooperative 2-Player Tag Team):
   Two players team up on the same side. Player 1 controls the primary fighter, while Player 2 controls the tag partner. Players tag in and out in real time during the match.

---

## Controller Configurations

### Configuration 1: Two Gamepads (Plug and Play)
1. Connect two controllers to your PC via USB or Bluetooth.
2. Windows assigns Controller 1 to Player 1 and Controller 2 to Player 2 automatically through XInput.
3. Launch the game.
4. From the main menu, select `OFFLINE MODE > VS BATTLE`.
5. On the character selection screen, Player 2 presses the `START` button on Controller 2 to join.

### Configuration 2: One Controller and One Keyboard
1. Keyboard input is routed to Player 1 by default.
2. Connect your controller.
3. If the controller connects to XInput Slot 2, Player 1 controls the keyboard and Player 2 controls the gamepad.
4. If your controller takes Slot 1 automatically, launch the game and press a key on the keyboard during the title screen before activating the controller.

### Configuration 3: Two Players on a Single Keyboard (Shared Keyboard)
Because Windows combines all keystrokes into a single hardware event queue, two players sharing one physical keyboard require a virtual controller bridge (such as Keyboard2Xinput or x360ce) to route Player 2 keys to a second virtual gamepad:

1. Setup:
   - Player 1 (Left Hand): Uses WASD for movement and UIJK for combat.
   - Player 2 (Right Hand): Uses Arrow Keys for movement and the Numeric Keypad for combat (Numpad 4, 5, 1, 2 for punches and kicks; Numpad 0 for Tag; Numpad Enter for Start).
2. Configure the virtual controller tool to map the Numpad keys to Virtual XInput Controller 2.
3. In VS Battle, Player 2 presses Numpad Enter to join as Controller 2. Both players can now fight simultaneously on the same physical keyboard.

---

## Online Peer-to-Peer Multiplayer (Steam)

The native PC port includes built-in Steamworks peer-to-peer netcode for low-latency online battles:

### Prerequisites
- Steam must be installed, running, and signed in on both PCs.
- Both players must use the identical release build of the port.
- No port forwarding or Xbox LIVE configuration is required.

### Hosting an Online Match
1. From the main menu, go to `ONLINE MODE > PLAYER MATCH`.
2. Select `CREATE SESSION`.
3. Steam displays your status as playing "Spacewar" (this is Valve's official testing application ID used for non-store community builds).

### Joining an Online Match
1. From the main menu, go to `ONLINE MODE > PLAYER MATCH`.
2. Select `SEARCH`.
3. Available public lobbies hosted by players running this port will appear in the lobby list. Select the host to connect.
