# Brackeys Platformer

This platformer has been created following Brackey's Godot tutorial:
	https://www.youtube.com/watch?v=LOhfqjmasi0

## Learning Goals

- [ ] What are Scene Groups?
- [ ] What are Global Groups?

## ToDo

- [x] Add parallax to tiles
- [x] Fix jump dampening bug that slows our fall when the jump key is released
- [x] Set up terrain tiles
- [x] Configure camera zoom, or fix the window size
- [x] Play with shaders
  - They don't play very nicely with tile maps
  - Can't use SCREEN_TEXTURE anymore, instead need to:
	- `uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, repeat_disable, filter_nearest;`
- [ ] Add particle emitters
  - [ ] On landing
  - [ ] While sprinting
  - [ ] While sliding to a stop
  - [x] To scene
- [ ] Add health system and damage
	- [ ] Game Manager should properly manage and own death state
- [ ] Add sound effects for a hit
- [ ] Enemy kill
- [-] Programatically extend the background plate
- [ ] Spawn enemies when close, not on load
- [ ] Add a completion point and another level
- [ ] Move music management into GameManager
- [ ] Power-ups

# Coding Adventures

- [ ] Procedurally generate tiles to match a soundtrack (ideally so that players
	  would jump in time with music)
