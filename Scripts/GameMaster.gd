extends Node

## SINGLETON
## accessed by calling Mstr

## STATE MACHINE
## to determine whether cards can be drawn or not
enum States {
	IDLE, # when no card is showing and deck can be clicked
	LOCKED, # when animation is playing, nothing can be clicked
	DISPLAYING_CARD # when card is showing
}
var state = States.IDLE

## stores the cards that have been drawn this game
var drawn_cards = []

## seed is randomized at game start
func _ready():
	randomize()
