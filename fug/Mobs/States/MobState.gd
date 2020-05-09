extends State

class_name MobState

onready var _animator : AnimatedSprite = owner.get_node("AnimatedSprite")
onready var _collider : CollisionShape2D = owner.get_node("CollisionShape2D")
onready var _mob : Mob = owner
onready var _shoved_collider := owner.get_node("ShoveArea/Collider")
