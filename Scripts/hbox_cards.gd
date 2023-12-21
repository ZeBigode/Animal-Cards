extends HBoxContainer

var selected_card = null
var offset = Vector2()
var pos_init = null

var pos_max_init = 720 # oou 640
var limite_drag = 695 # ou 615
var pos_card_drag = 640 # ou 560
var childerends = null

var dragging = false
var pressedd = false
onready var hbox = $"."
var num_cards = 9
var card = preload("res://Scenes/cards/card.tscn")

func _ready():
	randomize()
	

func _process(_delta):
	childerends = get_child_count()
	if childerends == 10:
		pos_max_init = 720 # oou 640
		limite_drag = 695 # ou 615
		pos_card_drag = 640# ou 560
	elif childerends == 9:
		pos_max_init = 640
		limite_drag = 615
		pos_card_drag = 560


func _on_hbox_cards_gui_input(event):
	if event is InputEventScreenTouch:
		if event.pressed:
			
			for i in range(get_child_count()):
				var cards = get_child(i)
				
				if cards.ative:
					for j in range(get_child_count()):
						var card3 = get_child(j)
						
						if i != j:
							card3.foco = false
							card3.show_behind_parent = true
							#print(card3.show_behind_parent)
					
					selected_card = cards
					if selected_card.cliked == false:
						selected_card.cliked = true
						selected_card.foco = true
					elif selected_card.cliked and dragging == false:
						selected_card.cliked = false
						selected_card.foco = false
					
					
					pos_init = selected_card.rect_position.x
					offset = cards.rect_position.x - event.position.x
					break
					
		elif not event.pressed:
			
			for i in range(get_child_count()):
				var cards = get_child(i)
				cards.show_behind_parent = false
				
			if selected_card:
				var index = selected_card.get_index()
				for i in range(get_child_count()):
					var cards = get_child(i)
					if cards != selected_card  and cards.rect_position.x > selected_card.rect_position.x or  selected_card.rect_position.x < cards.rect_position.x :
						var card_index = cards.get_index()
						
						
						if index != card_index:
							if dragging:
								
								move_child(selected_card, card_index )
								update()
								
								dragging = false
								selected_card.draing = false
								break
								
					elif pos_init == 0 or pos_init == pos_max_init :
						if index == cards.get_index():
							
							if selected_card.rect_position.x < 80 or selected_card.rect_position.x >= pos_card_drag and index >= 8:
								selected_card.rect_position.x = pos_init
								dragging = false
								selected_card.draing = false
								break
								
				
				
				selected_card.rect_position.x = pos_init
				selected_card = null
				$"../../..".info_btn_discart_bater()
				
	if selected_card and event is InputEventScreenDrag:
		selected_card.draing = true
		dragging = true
		
		if  selected_card.rect_position.x <= limite_drag:
			selected_card.rect_position.x = limite_drag
			selected_card.rect_position.x = event.position.x + offset
			
			if selected_card.rect_position.x > limite_drag:
				selected_card.rect_position.x = limite_drag
		elif selected_card.rect_position.x > limite_drag and selected_card.ative ==true:
			selected_card.rect_position.x = event.position.x + offset
			
			
		yield(get_tree().create_timer(.6), "timeout")
	
