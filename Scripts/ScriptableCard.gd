extends Resource
class_name Card

enum CardTypes {TREASURE,TRAP,QUEST,EVENT,DUEL,RULE}
enum CardRarities {COMMON, RARE, EPIC, LEGENDARY, SUPERLEGENDARY, SPECIAL}

export(String) var card_name
export(CardTypes) var card_type
export(String,MULTILINE) var card_text
export(Image) var card_art
export(CardRarities) var card_rarity
export(String, MULTILINE) var extended_description

func get_border_color() -> Color:
	var color
	match card_type:
		CardTypes.TREASURE:
			color = Color("88c556")
		CardTypes.TRAP:
			color = Color("cd3b3b")
		CardTypes.QUEST:
			color = Color("cdb33b")
		CardTypes.EVENT:
			color = Color("b8b8b8")
		CardTypes.DUEL:
			color = Color("67429d")
		CardTypes.RULE:
			color = Color("366fb1")
		_:
			Color("ffffff")
	
	## black border if card is superlegendary
	#if card_rarity == CardRarities.SUPERLEGENDARY:
		#color = Color("3a3a3a")
	
	return color


func get_rarity_color() -> Color:
	var color
	match card_rarity:
		CardRarities.COMMON:
			color = Color("b8b8b8")
		CardRarities.RARE:
			color = Color("205bc2")
		CardRarities.EPIC:
			color = Color("7d36b2")
		CardRarities.LEGENDARY:
			color = Color("d9bb46")
		CardRarities.SUPERLEGENDARY:
			color = Color("1e1e1e")
		CardRarities.SPECIAL:
			color = Color("d9bb46")
		_:
			color = Color("b8b8b8")
	return color
