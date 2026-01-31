extends Control

@onready var talisman_label: RichTextLabel = $RichTextLabel




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	talisman_label.text = "Remaining Talismans:" + str(Globals.player.remaining_talismans)
