extends Control

var icon_card_crocodile = preload("res://Sprites/Cards/Crocodile.png")
var icon_card_eagle = preload("res://Sprites/Cards/eagle.png")
var icon_card_elephant = preload("res://Sprites/Cards/elephant.png")
var icon_card_giraffe = preload("res://Sprites/Cards/Giraffe.png")
var icon_card_gorilla = preload("res://Sprites/Cards/Gorilla.png")
var icon_card_hipoppotamus = preload("res://Sprites/Cards/hipoppotamus.png")
var icon_card_kangaroo = preload("res://Sprites/Cards/kangaroo.png")
var icon_card_lion = preload("res://Sprites/Cards/lion.png")
var icon_card_penguin = preload("res://Sprites/Cards/penguin.png")
var icon_card_puma = preload("res://Sprites/Cards/Puma.png")
var icon_card_rabbit = preload("res://Sprites/Cards/rabbit.png")
var icon_card_wolf = preload("res://Sprites/Cards/Wolf.png")
var icon_card_zebra = preload("res://Sprites/Cards/zebra.png")

var back_icon = preload("res://Texture/card_back1.png")
var back_icon2 = preload("res://Texture/card_back2.png")
var back_tip = 2
var id = 0

var cor_board = "128cf8"
enum {monte , discart , mao , IA}
var foco = false
var cliked = false
var ative = false
var draing = false
onready var anim =  $anim
var stado
var anim_states = false


func _ready():
	
	stado = mao
	$bg.modulate = cor_board

func anim_play(intt:int):
	match intt:
		1:
			anim.play("scale_mini")
			anim_states = true
		2:
			anim.play("compra_mini_scale")
			anim_states = true
		3:
			anim.play("back_scale_mini")
			anim_states = true
			
	
func atau_tipo():
	if back_tip == 1:
		
		$back_icon.texture = back_icon
	elif back_tip == 2:
		$back_icon.texture = back_icon2

func _process(_delta):
	atualiza_card_id(id)
	
	if  stado == 2 :
		$back_icon.visible = false
		if foco :
			rect_position.y = -20
		elif draing:
			rect_position.y = -20
		else:
			rect_position.y = 0
	
		if rect_position.x < -5 :
			rect_position.x = -5
		elif rect_position.x > 815:
			rect_position.x = 815
	if stado == 0 or stado == 3:
		$back_icon.visible = true
	if stado == 1:
		$back_icon.visible = false
		pass
		
		
func atualiza_card_id(idd):
	match idd:
		0:
			$name.text = tr("P_CROCODILO")
			$icon.texture = icon_card_crocodile
			
			pass
		1:
			$name.text = tr("P_AGUIA")
			$icon.texture = icon_card_eagle
			pass
		2:
			$name.text = tr("P_ELEFANTE")
			$icon.texture = icon_card_elephant
			pass
		3:
			$name.text = tr("P_GIRAFA")
			$icon.texture = icon_card_giraffe
			pass
		4:
			$name.text = tr("P_GORILA")
			$icon.texture = icon_card_gorilla
			pass
		5:
			$name.text = tr("P_HIPOPOTAMO")
			$icon.texture = icon_card_hipoppotamus
			pass
		6:
			$name.text = tr("P_CANGURU")
			$icon.texture = icon_card_kangaroo
			pass
		7:
			$name.text = tr("P_LEAO")
			$icon.texture = icon_card_lion
			pass
		8:
			$name.text = tr("P_PINGUIM")
			$icon.texture = icon_card_penguin
			pass
		9:
			$name.text = tr("P_PUMA")
			$icon.texture = icon_card_puma
			pass
		10:
			$name.text = tr("P_COELHO")
			$icon.texture = icon_card_rabbit
			pass
		11:
			$name.text = tr("P_LOBO")
			$icon.texture = icon_card_wolf
			pass
		12:
			$name.text = tr("P_ZEBRA")
			$icon.texture = icon_card_zebra
			pass

func _on_card_gui_input(event):
	
	if event is InputEventScreenTouch and event.pressed:
		if stado == 2:
			ative = true
	elif event is InputEventScreenTouch and event.pressed == false:
		if stado == 2:
			ative = false







func _on_anim_animation_finished(anim_name):
	anim_states = false
