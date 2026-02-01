extends Control

var talismans = []
@onready var mask_outline: TextureRect = $MaskOutline


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	talismans = [$Talisman1, $Talisman2, $Talisman3]
	Globals.game_ui = self
	WorldManager.connect("world_state_changed",_on_world_changed)

func _on_world_changed(new_state):
	if new_state == WorldManager.WORLD_STATE.GHOST_WORLD:
		mask_outline.show()
	else:
		mask_outline.hide()
