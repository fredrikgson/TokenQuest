extends Control

func init_from_resource(res:Card):
	$Border/Fill.self_modulate = res.get_border_color()
	$Border/CardName.text = res.card_name
	$Border/RarityRing/RarityFill.self_modulate = res.get_rarity_color()
