extends RigidBody2D

var go_home = false
var walk_path = Vector2()
var spawn_place = Vector2()
var pos
var mirror = false

var characters = ['mendigao', 'katcha', 'dogao', 'old_woman', 'ternurinha', 'viadinho']

func _ready():
	randomize()
	pos = get_pos()
	set_process(true)
	var c = characters[randf() * 6]
	var tex = load("res://textures/characters/" + c + ".png")
	get_node("Sprite").set_texture(tex)

func _process(delta):
	if(go_home):
		if not mirror: 
			set_scale(Vector2(get_scale().x * -1, 1))
			mirror = true
		else:
			if get_pos().distance_to(spawn_place) >= 1:
				var dir = (spawn_place - pos).normalized()
				pos += dir * 1
				set_pos(pos)
			else:
				hide()
	else:
		if get_pos().distance_to(walk_path) >= 1:
			var dir = (walk_path - pos).normalized()
			pos += dir * 1
			set_pos(pos)
	
func go_home():
	go_home = true
	global.score += 50

func die():
	global.score += 100
	get_node("Sprite").hide()
	get_node("blood").show()
	get_node("blood/AnimationPlayer").play("blood")
