extends KinematicBody

onready var camera:Camera = get_viewport().get_camera()
onready var space_state:PhysicsDirectSpaceState = get_world().direct_space_state
export(NodePath) onready var nav = get_node(nav) as Navigation
const DISTANCE_THRESHOLD:= 1
const SPEED:= 3

var path:= []
var path_index:=0

var is_moving:bool = false


func _unhandled_input(event):
	if event is InputEventMouseMotion:
		turn_to(event)
		
	if event is InputEventMouseButton and event.button_index == 1:
		find_path(event)

func _physics_process(delta):
	move_along(path)

func get_destination(event)->Vector3:
	var from = camera.project_ray_origin(event.position)
	var to = from + camera.project_ray_normal(event.position) * 100
	var result = space_state.intersect_ray(from, to)
	
	if result and result.collider:
		return result.position

	return Vector3.ZERO

func turn_to(event):
	if is_moving:
		return
	
	var direction:Vector3 = get_destination(event) * Vector3(1,0,1) + Vector3(0, global_transform.origin.y, 0)

	look_at(direction, Vector3.UP)

func find_path(event):	
	path = nav.get_simple_path(global_transform.origin, get_destination(event))
	path_index = 0

func move_along(path:Array):
	if !path or path_index == path.size():
		is_moving = false
		$Clara/AnimationPlayer.play("Idle")
		$FootSteps.stream_paused = true
		return
	
	is_moving = true
	$Clara/AnimationPlayer.play("Walk")
	$FootSteps.stream_paused = false
	
	var distance_to_next_step = global_transform.origin.distance_to(path[path_index])
	var direction:Vector3 = path[path_index] - global_transform.origin
	
	if distance_to_next_step < DISTANCE_THRESHOLD:
		path_index += 1
	else:
		move_and_slide(direction.normalized() * SPEED)
		look_at(path[path_index], Vector3.UP)
