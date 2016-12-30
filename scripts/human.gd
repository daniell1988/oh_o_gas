extends RigidBody2D

var go_home = false
var scared = false
var walk_path = Vector2()
var pos
var mirror = false

func _ready():
	pos = get_pos()
	set_process(true)

func _process(delta):
	if(go_home):
		if not mirror: 
			set_scale(Vector2(get_scale().x * -1, 1))
			mirror = true
		if(not scared):
			set_pos(Vector2(get_pos().x-1,get_pos().y))
		else:
			set_pos(Vector2(get_pos().x-4,get_pos().y))
	else:
		if get_pos().length() <= walk_path.length():
			var dir = (walk_path - pos).normalized()
			pos += dir * 1
			set_pos(pos)
	
func go_home(scared = false):
	self.scared = scared
	go_home = true
	global.score += 50

func die():
	global.score += 100
	queue_free()
	get_node("blood").play()