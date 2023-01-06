extends Node

## SINGLETON
## accessed by calling Mstr

enum States {
	IDLE, # when no card is showing and deck can be clicked
	LOCKED, # when animation is playing, nothing can be clicked
	DISPLAYING_CARD # when card is showing
}
var state = States.IDLE

## seed is randomized at game start
func _ready():
	randomize()
