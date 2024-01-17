extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var anim = get_node("AnimationPlayer")

var isInCombo = false
var currentAttack = 0
var previousAttack = 0

@onready var ColliderScript = get_node("Colliders")

var time = 0
var timeTillNextInput = 0.5

func _ready():
	time = timeTillNextInput

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		anim.play("jump")

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
		if velocity.y == 0:
			anim.play("run")
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if velocity.y == 0 and not isInCombo:
			anim.play("idle")
	if velocity.y > 0:
		anim.play("fall")
	move_and_slide()

	# Get the attack input and handle combos. 
	if Input.is_action_just_pressed("ui_punch"):
		if currentAttack == 0:
			_Reset_Previous_Attack(previousAttack)
			previousAttack = 1

			_Set_Attack_Position(1, Vector2(104, -51))
			anim.play("punch")
		if currentAttack == 1:
			_Reset_Previous_Attack(previousAttack)
			previousAttack = 1

			_Set_Attack_Position(1, Vector2(99, -111))
			anim.play("uppercut")
		if currentAttack == 2:
			_Reset_Previous_Attack(previousAttack)
			previousAttack = 0

			_Set_Attack_Position(0, Vector2(108, 14))
			anim.play("high kick")
		isInCombo = true
		currentAttack += 1
		_Reset_Attack_Timer()

	# Reset combo if attack button not pressed in time. 
	if isInCombo :
		time -= delta

		if time<0:
			time = timeTillNextInput
			isInCombo = false
			currentAttack = 0
			_Reset_Previous_Attack(previousAttack)
			anim.play("idle")

func _Reset_Attack_Timer():
	if(currentAttack < 4):
		time = timeTillNextInput

func _Set_Attack_Position(currentAttackID,newPos):
	ColliderScript.p1FightColl[currentAttackID].position += newPos
	ColliderScript._Handle_Specific_Collider_Disabling(false, currentAttackID)

func _Reset_Previous_Attack(previousAttackID):
	ColliderScript.p1FightColl[previousAttackID].position = Vector2(0,0)
	ColliderScript._Handle_Specific_Collider_Disabling(true, previousAttackID)
