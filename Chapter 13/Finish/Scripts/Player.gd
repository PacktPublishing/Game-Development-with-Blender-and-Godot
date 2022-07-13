extends KinematicBody

onready var camera:Camera = get_viewport().get_camera()
onready var space_state:PhysicsDirectSpaceState = get_world().direct_space_state
export(NodePath) onready var nav = get_node(nav) as Navigation
const DISTANCE_THRESHOLD:= 1
const SPEED:= 5

var path:= []
var path_index:=0

func _unhandled_input(event):
	if event is InputEventMouseButton and event.button_index == 1:
		find_path(event)

func _physics_process(delta):
	move_along(path)

func find_path(event):
	var from = camera.project_ray_origin(event.position)
	var to = from + camera.project_ray_normal(event.position) * 100
	var result = space_state.intersect_ray(from, to)
	
	if result and result.collider:
		path = nav.get_simple_path(global_transform.origin, result.position)
		path_index = 0

func move_along(path:Array):
	if !path or path_index == path.size():
		return
		
	var distance_to_next_step = global_transform.origin.distance_to(path[path_index])
	var direction:Vector3 = path[path_index] - global_transform.origin
	
	if distance_to_next_step < DISTANCE_THRESHOLD:
		path_index += 1
	else:
		move_and_slide(direction.normalized() * SPEED)
