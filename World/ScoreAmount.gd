extends Label

func _ready():
# warning-ignore:return_value_discarded
	PlayerScore.connect("scoreChanged", self, "change_score")

func change_score(value):
	self.set_text(str(value))
