extends Node2D

# cartas saindo do monte para os players=================
var monte_pos_p1 = Vector2(505,311)
var monte_pos_p2 = Vector2(-385,25)
var monte_pos_p3 = Vector2(100,-220)
var monte_pos_p4 = Vector2(487,33)
# carts saindo do discart para players==================
var discart_pos_p1 = Vector2(390,311)
var discart_pos_p2 = Vector2(-500,25)
var discart_pos_p3 = Vector2(-15,-220)
var discart_pos_p4 = Vector2(370,33)
# cartas saindo do players pro discart=================
var p1_pos_dicart = Vector2(330,-311)
var p2_pos_dicart = Vector2(500,-25)
var p3_pos_dicart = Vector2(15,220)
var p4_pos_dicart = Vector2(-370,-33)
#montes===================================================
onready var cards = preload("res://Scenes/cards/card.tscn")
onready var monte = $monte/monte
onready var monte_discart = $discarte/discarte
onready var monte_p1 = $players/player1/hbox_cards
onready var monte_p2 = $players/player2/hbox_play
onready var monte_p3 = $players/player3/hbox_play
onready var monte_p4 = $players/player4/hbox_play
#========================================================
onready var coins_iconscenes = preload("res://Scenes/icon_coin.tscn")
onready var pai_moedasScenes = $anim_pacote_moedas
var tipo_back_icon
onready var vitoria = $"../canv_mtr_poupu/vitoria"
onready var canvas_notf = $"../canv_mtr_poupu"
onready var tween = $"../tween"
var vez 
const TIP = 13
var started = false
var time_left 
var discarte_empty = true
var comprando = false
var pode_jogar:bool = false
var tpIA:int = 4
onready var nomePlayer = $"..".nick_name
var nomeIA2 = ""
var nomeIA3 = ""
var nomeIA4 = ""
var pote_mesa = 0
var moedas_entrada = 0

var pode_sair = false
var posicao_final = Vector2(640, 360)
var raio = 100
var posicao_central = Vector2(300, 300)
var valor_atual = 0 setget set_valor_atual

func _ready():
	randomize()
	vez = randi() % 4 + 1 # timer=randi() % 10 + 1
	$players/player1/timer_bar/timer_compra.wait_time = tpIA + 1
	$players/player1/timer_bar/timer_discrt.wait_time = tpIA + 1
	$players/player2/timer_bar2.max_value = tpIA + 1
	$players/player3/timer_bar3.max_value = tpIA + 1
	$players/player4/timer_bar4.max_value = tpIA + 1
	
func _process(_delta):
	set_scale_IA()
	mostra_timer_relogio(time_left)
	$init/info_init.text = str(int($init/init_jogo.time_left)+1)
	$info_mesa_jogo/bg.modulate = $"../room".cor_nivel
	$pote/icon_trofeu.modulate = $"../room".cor_nivel
	$info_mesa_jogo/info_nivel.text = $"../room".nivel_mesa
	moedas_entrada = $"../room".valor_moedas
	$info_mesa_jogo/info_coins.text = $"..".formatNumber(moedas_entrada)

func atualizar_bots_nomes():
	var nomeAleatorio = $"../nomes".nome_aleatorio()
	$players/player2/nick_name.text = nomeAleatorio
	nomeAleatorio = $"../nomes".nome_aleatorio()
	$players/player3/nick_name.text = nomeAleatorio
	nomeAleatorio = $"../nomes".nome_aleatorio()
	$players/player4/nick_name.text = nomeAleatorio
	pass

func atualizar_bots_icon():
	var array_icons = $"../perfil".arry_icon_texture
	var indiceAleatorio = rand_range(0, array_icons.size() - 1)
	var iconAleatorio = array_icons[indiceAleatorio]
	$players/player2/icon_perfil.texture = iconAleatorio
	indiceAleatorio = rand_range(0, array_icons.size() - 1)
	iconAleatorio = array_icons[indiceAleatorio]
	$players/player3/icon_perfil.texture = iconAleatorio
	indiceAleatorio = rand_range(0, array_icons.size() - 1)
	iconAleatorio = array_icons[indiceAleatorio]
	$players/player4/icon_perfil.texture = iconAleatorio

func atualizar_bots_board():
	var cor_board = ["ffffff", "000000", "00ff00", "ff0000", "e21bf8", "ffe400", "000fff"]
	var indiceAleatorio = rand_range(0, cor_board.size() - 1)
	var corAleatorio = cor_board[indiceAleatorio]
	$players/player2/bg.modulate = corAleatorio
	indiceAleatorio = rand_range(0, cor_board.size() - 1)
	corAleatorio = cor_board[indiceAleatorio]
	$players/player3/bg.modulate = corAleatorio
	indiceAleatorio = rand_range(0, cor_board.size() - 1)
	corAleatorio = cor_board[indiceAleatorio]
	$players/player4/bg.modulate = corAleatorio
	
	



func set_valor_atual(value):
	valor_atual = value
func pos_animMove():
	var angulo = randf() * 2 * PI
	var posicao = posicao_central + Vector2(raio * cos(angulo), raio * sin(angulo))
	return posicao

func instaci_sprit_moeds(pos):
	var qty = 20
	for i in range(qty):
		var icon_n = coins_iconscenes.instance()
		icon_n.position = pos
		pai_moedasScenes.add_child(icon_n)
		
		pass

func junta_moedasMeio():
	for child in pai_moedasScenes.get_children():
		yield(get_tree().create_timer(.03),"timeout")
		var destino = Vector2(rand_range(600, 680),rand_range(320, 400))
		
		tween.interpolate_property(child , "position" , child.position, destino ,0.2 ,Tween.TRANS_LINEAR  )
		tween.start() 
		child.position = destino
		
		pass
func junta_moedasPot():
	pote_mesa = moedas_entrada * 4
	tween.interpolate_property(self, "valor_atual", 0, pote_mesa, 1.2, Tween.TRANS_LINEAR)
	tween.start()
	
	for child in pai_moedasScenes.get_children():
		yield(get_tree().create_timer(.01),"timeout")
		var destino = Vector2(1102,60)
		
		tween.interpolate_property(child , "position" , child.position, destino ,0.1 ,Tween.TRANS_LINEAR  )
		tween.start() 
		child.position = destino
	$pote/qty.text = $"..".formatNumber(pote_mesa)
	
	$som_moedas.stop()
	for child in pai_moedasScenes.get_children():
		var chil= child
		chil.queue_free()
	



func apagatodas_cards():
	var filhos = monte.get_children()
	filhos += monte_discart.get_children()
	filhos += monte_p1.get_children()
	filhos += monte_p2.get_children()
	filhos += monte_p3.get_children()
	filhos += monte_p4.get_children()
	for filho in filhos:
		filho.queue_free()

func jogardnv_jogo():
	$pote/qty.text = str(0)
	pote_mesa = 0
	valor_atual = 0
	pode_sair = false
	started = false
	escond_cards_sprite(false)
	$init/init_jogo.stop()
	
	vez = randi() % 4 + 1
	apagatodas_cards()
	instaci_sprit_moeds(Vector2(225,590))
	instaci_sprit_moeds(Vector2(92,314))
	instaci_sprit_moeds(Vector2(579,69))
	instaci_sprit_moeds(Vector2(1194,314))
	
	junta_moedasMeio()
	
	yield(get_tree().create_timer(3),"timeout")
	junta_moedasPot()
	print("junto pot coins")
	yield(get_tree().create_timer(1.7),"timeout")
	
	$init/init_jogo.start()
	$init/iniciar_notf.show()
	criar_baralho()
	escond_cards_sprite(true)
	yield(get_tree().create_timer(.5),"timeout")
	
	$init/iniciar_notf.hide()
	$init/init_jogo.start()
	destribuir_cards_toods()
	$init/info_init.show()
	$monte/monte.show()

func escond_cards_sprite(ver_fal:bool):
	$players/player1/hbox_cards.visible = ver_fal
	$players/player2/hbox_play.visible = ver_fal
	$players/player3/hbox_play.visible = ver_fal
	$players/player4/hbox_play.visible = ver_fal
	$monte/monte.visible = ver_fal
	$discarte/discarte.visible = ver_fal
	if ver_fal == false:
		$players/player1/timer_bar/timer_compra.stop()
		$players/player1/timer_bar/timer_discrt.stop()
	

func get_repeated_ids(monte_at,repeatCount: int) -> Array:
	print(monte_at ,"aqui monte")
	print("-----------------------------------")
	var vboxs = {}
	var vbox1 = []
	var vbox2 = []
	var vbox3 = []
	var children = []
	var idCounts = {}
	var id1
	var id2
	var id3
	# Obtém todos os filhos TextureRect do HBoxContainer
	for child in monte_at.get_children():
		if child is TextureRect:
			children.append(child)
			var id = child.id

			# Conta quantas vezes cada ID aparece
			if idCounts.has(id):
				idCounts[id] += 1
			else:
				idCounts[id] = 1
	# Obtém os filhos com IDs repetidos exatamente repeatCount vezes
	for child in children:
		var id = child.id
		var repeatCountInChildren = idCounts[id]
		if repeatCountInChildren >= repeatCount:
			if id1 == null:
				id1 = child.id
			elif id2 == null and child.id != id1:
				id2 = child.id
			elif id3 == null and child.id != id2 and child.id != id1:
				id3 = child.id 
			
			if vbox1.size() < 3 and id1 == child.id:
				monte_at.remove_child(child)
				vbox1.append(child)
				print(vbox1,"vbox1")
				print("-----------------------------------")
			elif vbox2.size() < 3 and id2 == child.id:
				monte_at.remove_child(child)
				vbox2.append(child)
				print(vbox2,"vbox2")
				print("-----------------------------------")
			elif vbox3.size() < 3 and id3 == child.id:
				monte_at.remove_child(child)
				vbox3.append(child)
				print(vbox3 ,"vbox3")
				print("-----------------------------------")
	vboxs["vbox1"] = vbox1
	vboxs["vbox2"] = vbox2
	vboxs["vbox3"] = vbox3
	return vboxs

func check_ids_repeated_every_three(monte_atual):
	var children = []
	var idCounts = {}
	var qty = 0
	# Obtém todos os filhos TextureRect do HBoxContainer
	for child in monte_atual.get_children():
		if child is TextureRect:
			children.append(child)
			var id = child.id
			# Conta quantas vezes cada ID aparece
			if idCounts.has(id):
				idCounts[id] += 1
			else:
				idCounts[id] = 1
	
	# Verifica se os IDs se repetem a cada 3
	for id in idCounts.keys():
		var repeatCount = idCounts[id]
		if repeatCount >= 3:
			
			qty += 1
	
	print(qty)
	
	return qty



func remove_child_least_repeated_id(monte_atual):
	var children = []
	var idCounts = {}
	var child_id_last
	# Obtém todos os filhos TextureRect do HBoxContainer
	for child in monte_atual.get_children():
		if child is TextureRect:
			children.append(child)
			var id = child.id

			# Conta quantas vezes cada ID aparece
			if idCounts.has(id):
				idCounts[id] += 1
			else:
				idCounts[id] = 1

	# Encontra o ID menos repetido
	var leastRepeatedID = -1
	var leastRepeatCount = 10
	var overid = -1
	var overcount = -1
	
	for id in idCounts.keys():
		var repeatCount = idCounts[id]
		if repeatCount > 3 :
			overid = id
			overcount = repeatCount
		if  repeatCount < leastRepeatCount :
			leastRepeatedID = id
			leastRepeatCount = repeatCount
	
	if overcount != -1:
		leastRepeatedID = overid
		leastRepeatCount = overcount
		

	# Remove o filho com o ID menos repetido
	for child in children:
		if child.id == leastRepeatedID:
			child_id_last = child
			break
	
	return child_id_last
	

func verific_id_qty(monte_atul , id_compare ):
	var qty_ids = 0 
	for i in range(monte_atul.get_child_count()):
		var child = monte_atul.get_child(i)
		var id_card = child.id
		if id_card == id_compare:
			qty_ids += 1
	return qty_ids
func mostra_timer_relogio(obgt_timerlesft):
	if obgt_timerlesft != null:
		$players/player1/timer_bar.value = obgt_timerlesft.time_left
		$players/player2/timer_bar2.value = obgt_timerlesft.time_left
		$players/player3/timer_bar3.value = obgt_timerlesft.time_left
		$players/player4/timer_bar4.value = obgt_timerlesft.time_left
	
func info_btn_discart_bater():
	if monte_p1.get_child_count() == 10 :
		for i in range(monte_p1.get_child_count()):
			var child = monte_p1.get_child(i)
			if child.foco == true:
				$discart_btn.visible = true
				break
			else:
				$discart_btn.visible = false
	if vez != 1:
		$bater.visible = false
	

func destribuir_cards_toods():
	for i in range(4):
		var idx = i + 1
		for j in range(9):
			var last_card_monte = last_card(monte)
			match idx:
				1:
					compras_card(monte_p1, monte , monte_pos_p1 ,false , 0.1 )
					yield(tween , "tween_completed")
				2:
					compras_card(monte_p2, monte , monte_pos_p2 ,true ,0.1)
					yield(tween , "tween_completed")
				3:
					compras_card(monte_p3, monte , monte_pos_p3 ,true ,0.1 )
					yield(tween , "tween_completed")
				4:
					compras_card(monte_p4, monte , monte_pos_p4 ,true ,0.1)
					yield(tween , "tween_completed")
	
	$som_card_shullfe.stop()
	pode_sair = true

func _on_discart_btn_pressed():
	$som_card_mao.play()
	$discart_btn.visible = false
	$players/player1/timer_bar/timer_discrt.stop()
	for i in range(monte_p1.get_child_count()):
		if monte_p1.get_child(i) == null:
			return
		
		var child = monte_p1.get_child(i)
		
		if child.foco == true  and monte_p1.get_child_count() == 10 :
			child.foco = false
			child.ative = false
			child.stado = child.discart
			move_anim(child  , child.rect_position , p1_pos_dicart , 0.4)
			yield(tween , "tween_completed")
			monte_p1.remove_child(child)
			monte_discart.add_child(child)
			$players/player1/timer_bar.visible = false
			$players/player1/timer_bar/timer_discrt.stop()
			vez = 2
			$players/player1/timer_bar/timer_compra.wait_time = tpIA + 1
			$players/player1/timer_bar/timer_discrt.wait_time = tpIA + 1
			jogar_vez(vez)
			

func move_anim(obejeto  , pos_inicial , pos_final, timer):
	tween.interpolate_property(obejeto , "rect_position" , pos_inicial, pos_final ,timer ,Tween.TRANS_LINEAR, Tween.EASE_IN )
	tween.start() 
	

func _on_init_jogo_timeout():
	
	started = true
	$init/info_init.hide()
	jogar_vez(vez)

func criar_baralho():
	for i in range(TIP):
		for _j in range(8):
			var card = cards.instance()
			card.cor_board = $"../config".cor_bord
			if tipo_back_icon == 1:
				card.back_tip = 1
			else:
				card.back_tip = 2
			card.atau_tipo()
			card.id = i
			card.stado = monte
			
			monte.add_child(card)
	embaralhar()

func embaralhar():
	var children = monte.get_children()
	var children_arry = []
	for child in children:
		children_arry.append(child)
	children_arry.shuffle()
	for child in children:
		monte.remove_child(child)
	for child in children_arry:
		child.stado = child.monte
		monte.add_child(child)
		

func jogar_vez(vezz):
	alualiza_foucs_vez(vez)
	print(vezz)
	var id_last = last_card(monte_discart)
	var ids_compare
	
	if started :
		match vezz:
			1:
				$players/player1/timer_bar/timer_compra.wait_time = 10
				$players/player1/timer_bar/timer_discrt.wait_time = 10
				
				$players/player1/timer_bar/timer_compra.start()
				time_left = $players/player1/timer_bar/timer_compra
				$players/player1/timer_bar.visible = true
				yield(get_tree().create_timer(9),"timeout")
				if $players/player1/timer_bar/timer_discrt.time_left <= 1:
					$discart_btn.visible = false
			2:
				if id_last != null:
					ids_compare = verific_id_qty(monte_p2 , id_last.id)
				$players/player2/timer_bar2.visible = true
				time_left = $players/player1/timer_bar/timer_compra
				$players/player1/timer_bar/timer_compra.start()
				yield(get_tree().create_timer(randi() % tpIA + 1),"timeout")
				$players/player1/timer_bar/timer_compra.stop()
				if started:
					if ids_compare == 1 or ids_compare == 2 :
						compras_card(monte_p2, monte_discart , discart_pos_p2 , true ,0.4)
					else:
						compras_card(monte_p2, monte , monte_pos_p2 , true ,0.4)
				yield(tween, "tween_completed")
				var chek_vict = check_ids_repeated_every_three(monte_p2)
				if chek_vict == 3:
					
					mostra_dados_vitoria(monte_p2 ,nomeIA2 , false , pote_mesa)
					yield(get_tree().create_timer(1),"timeout")
					escond_cards_sprite(false)
					$"../canv_mtr_poupu/anim".play("scale_vitore")
					$"../canv_mtr_poupu/vitoria".atualizaricons()
					started = false
					$"../perfil".qty_jogos += 1
					return
				print("Os IDs não se repetem a cada 3 filhos.")
				$players/player1/timer_bar/timer_compra.start()
				yield(get_tree().create_timer(randi() % tpIA + 1),"timeout")
				$players/player1/timer_bar/timer_compra.stop()
				$players/player2/timer_bar2.visible = false
				discartIA(monte_p2 , p2_pos_dicart)
				yield(tween,"tween_completed")
				vez = 3
				jogar_vez(vez)
			
			
				pass
			3:
				if id_last != null:
					ids_compare = verific_id_qty(monte_p3 , id_last.id)
				$players/player3/timer_bar3.visible = true
				time_left = $players/player1/timer_bar/timer_compra
				$players/player1/timer_bar/timer_compra.start()
				yield(get_tree().create_timer(randi() % tpIA + 1),"timeout")
				$players/player1/timer_bar/timer_compra.stop()
				if started:
					if ids_compare == 1 or ids_compare == 2 :
						compras_card(monte_p3, monte_discart , discart_pos_p3 , true ,0.4)
					else:
						compras_card(monte_p3, monte , monte_pos_p3 , true ,0.4)
				yield(tween, "tween_completed")
				var chek_vict = check_ids_repeated_every_three(monte_p3)
				if chek_vict == 3:
					
					mostra_dados_vitoria(monte_p3 ,nomeIA3 , false , pote_mesa)
					yield(get_tree().create_timer(1),"timeout")
					escond_cards_sprite(false)
					$"../canv_mtr_poupu/anim".play("scale_vitore")
					$"../canv_mtr_poupu/vitoria".atualizaricons()
					started = false
					$"../perfil".qty_jogos += 1
					return
				print("Os IDs nao se repetem a cada 3 filhos.")
				$players/player1/timer_bar/timer_compra.start()
				yield(get_tree().create_timer(randi() % tpIA + 1),"timeout")
				$players/player1/timer_bar/timer_compra.stop()
				$players/player3/timer_bar3.visible = false
				discartIA(monte_p3 , p3_pos_dicart)
				yield(tween,"tween_completed")
			
				vez = 4
				jogar_vez(vez)
				pass
			4:
				if id_last != null:
					ids_compare = verific_id_qty(monte_p4 , id_last.id)
				$players/player4/timer_bar4.visible = true
				time_left = $players/player1/timer_bar/timer_compra
				$players/player1/timer_bar/timer_compra.start()
				yield(get_tree().create_timer(randi() % tpIA + 1),"timeout")
				$players/player1/timer_bar/timer_compra.stop()
				if started:
					if ids_compare == 1 or ids_compare == 2 :
						compras_card(monte_p4, monte_discart , discart_pos_p4 , true ,0.4)
					else:
						compras_card(monte_p4, monte , monte_pos_p4 , true ,0.4)
				yield(tween, "tween_completed")
				var chek_vict = check_ids_repeated_every_three(monte_p4)
				if chek_vict == 3:
					
					mostra_dados_vitoria(monte_p3 ,nomeIA3 , false , pote_mesa)
					yield(get_tree().create_timer(1),"timeout")
					escond_cards_sprite(false)
					$"../canv_mtr_poupu/anim".play("scale_vitore")
					$"../canv_mtr_poupu/vitoria".atualizaricons()
					started = false
					$"../perfil".qty_jogos += 1
					return
				print("Os IDs nao se repetem a cada 3 filhos.")
				$players/player1/timer_bar/timer_compra.start()
				yield(get_tree().create_timer(randi() % tpIA + 1),"timeout")
				$players/player1/timer_bar/timer_compra.stop()
				$players/player4/timer_bar4.visible = false
				discartIA(monte_p4 , p4_pos_dicart)
				yield(tween,"tween_completed")
				vez = 1
				jogar_vez(vez)
				pass


func alualiza_foucs_vez(vez_):
	if pode_sair == false :
		if valor_atual != pote_mesa:
			$pote/qty.text = str(int(valor_atual))
		$Button.disabled = true
	else:
		
		$Button.disabled = false
	
	if started:
		match vez_:
			1:
				$players/player1/foucs1.visible = true
				$players/player2/foucs2.visible = false
				$players/player3/foucs3.visible = false
				$players/player4/foucs4.visible = false
				$players/player4/timer_bar4.visible = false
				$players/player3/timer_bar3.visible = false
				$players/player2/timer_bar2.visible = false
				$players/player1/timer_bar.visible = true
				pass
			2:
				$players/player1/foucs1.visible = false
				$players/player2/foucs2.visible = true
				$players/player3/foucs3.visible = false
				$players/player4/foucs4.visible = false
				$players/player4/timer_bar4.visible = false
				$players/player3/timer_bar3.visible = false
				$players/player2/timer_bar2.visible = true
				$players/player1/timer_bar.visible = false
				pass
			3:
				$players/player1/foucs1.visible = false
				$players/player2/foucs2.visible = false
				$players/player3/foucs3.visible = true
				$players/player4/foucs4.visible = false
				$players/player4/timer_bar4.visible = false
				$players/player3/timer_bar3.visible = true
				$players/player2/timer_bar2.visible = false
				$players/player1/timer_bar.visible = false
				pass
			4:
				$players/player1/foucs1.visible = false
				$players/player2/foucs2.visible = false
				$players/player3/foucs3.visible = false
				$players/player4/foucs4.visible = true
				$players/player4/timer_bar4.visible = true
				$players/player3/timer_bar3.visible = false
				$players/player2/timer_bar2.visible = false
				$players/player1/timer_bar.visible = false
				pass
	
	else:
		$players/player1/foucs1.visible = false
		$players/player2/foucs2.visible = false
		$players/player3/foucs3.visible = false
		$players/player4/foucs4.visible = false
		$players/player4/timer_bar4.visible = false
		$players/player3/timer_bar3.visible = false
		$players/player2/timer_bar2.visible = false
		$players/player1/timer_bar.visible = false
		pass


func _on_monte_btn_pressed():
	
	if started and monte_p1.get_child_count() == 9 and vez == 1:
		compras_card(monte_p1, monte , monte_pos_p1 ,false ,0.4)
		yield(tween,"tween_completed")
		$players/player1/timer_bar/timer_compra.stop()
		$players/player1/timer_bar/timer_discrt.start()
		time_left = $players/player1/timer_bar/timer_discrt
		$players/player1/timer_bar.visible = true
		var p_ganhar = check_ids_repeated_every_three(monte_p1)
		if p_ganhar == 3 :
			print("Os IDs se repetem a cada 3 filhos.")
			$bater.visible = true


func _on_discarte_btn_pressed():
	if started and monte_discart.get_child_count() > 0 and monte_p1.get_child_count() == 9 and vez ==1:
		compras_card(monte_p1, monte_discart , discart_pos_p1 , false ,0.4)
		yield(tween,"tween_completed")
		$players/player1/timer_bar/timer_compra.stop()
		$players/player1/timer_bar/timer_discrt.start()
		time_left = $players/player1/timer_bar/timer_discrt
		$players/player1/timer_bar.visible = true
		var p_ganhar = check_ids_repeated_every_three(monte_p1)
		if p_ganhar == 3:
			print("Os IDs se repetem a cada 3 filhos.")
			$bater.visible = true
		
func set_scale_IA():
	for i in range(monte_p2.get_child_count()):
		var cards = monte_p2.get_child(i)
		if cards.anim_states == false:
			cards.rect_scale = Vector2(0.5,0.5)
	for i in range(monte_p3.get_child_count()):
		var cards = monte_p3.get_child(i)
		if cards.anim_states == false:
			cards.rect_scale = Vector2(0.5,0.5)
	for i in range(monte_p4.get_child_count()):
		var cards = monte_p4.get_child(i)
		if cards.anim_states == false:
			cards.rect_scale = Vector2(0.5,0.5)

func _on_bater_pressed():
	$"..".coins += pote_mesa
	$bater.hide()
	started = false
	escond_cards_sprite(false)
	mostra_dados_vitoria(monte_p1, nomePlayer , true , pote_mesa)
	
	$"../canv_mtr_poupu/anim".play("scale_vitore")
	$"../canv_mtr_poupu/vitoria".atualizaricons()
	$"../canv_mtr_poupu/vitoria".set_trofeus($"../room".trof)
	$"../perfil".qty_jogos += 1
	$"../perfil".vitorias += 1
	
	$"..".salvar_BD_firebase()

func mostra_dados_vitoria(monte_at, nome, vitoriaa , pote_moedas):
	var hboxes = get_repeated_ids(monte_at,3)
	vitoria.carrega_painel_vitoria(nome,vitoriaa , pote_moedas , hboxes["vbox1"],hboxes["vbox2"],hboxes["vbox3"])
	if vitoriaa:
		$"../canv_mtr_poupu/vitoria/som_vitoria".play()
	else:
		$"../canv_mtr_poupu/vitoria/som_derrota".play()
	
	
func _on_timer_discrt_timeout():
	$discart_btn.visible = false
	if vez == 1:
		
		var child = remove_child_least_repeated_id(monte_p1)
		if monte_p1.get_child_count() == 10 :
			child.foco = false
			child.ative = false
			child.stado = child.discart
			move_anim(child  , child.rect_position , p1_pos_dicart , 0.4)
			yield(tween , "tween_completed")
			
			monte_p1.remove_child(child)
			monte_discart.add_child(child)
			$players/player1/timer_bar/timer_discrt.stop()
			vez = 2
			$players/player1/timer_bar/timer_compra.wait_time = tpIA + 1
			$players/player1/timer_bar/timer_discrt.wait_time = tpIA + 1
			jogar_vez(vez)
			$players/player1/timer_bar.visible = false

func discartIA(montee , pp_pos_discart):
	$som_card_mao.play()
	montee.rect_clip_content = false
	if montee.get_child_count() == 10 :
		var child = remove_child_least_repeated_id(montee)
		child.foco = false
		child.ative = false
		child.anim_play(3)
		move_anim(child  , child.rect_position , pp_pos_discart , 0.5)
		
		yield(tween , "tween_completed")
		montee.rect_clip_content = true
		child.stado = child.discart
		montee.remove_child(child)
		monte_discart.add_child(child)
		
		


func _on_timer_compra_timeout():
	if vez == 1:
		$players/player1/timer_bar/timer_discrt.start()
		time_left = $players/player1/timer_bar/timer_discrt
		$players/player1/timer_bar.visible = true
		$players/player1/timer_bar/timer_compra.stop()
		compras_card(monte_p1, monte , monte_pos_p1 , false ,0.4)
		yield(tween,"tween_completed")
		var p_ganhar = check_ids_repeated_every_three(monte_p1)
		if p_ganhar == 3:
			print("Os IDs se repetem a cada 3 filhos.")
			$bater.visible = true

func last_card(montee):
	var cout = montee.get_child_count()
	var lastcard = montee.get_child(cout - 1)
	return lastcard


func compras_card(local_monte  ,  monte_compra , posicao_anim , IA ,timer):
	$som_card_mao.play()
	if comprando == false:
		comprando = true
		var lastcard_monte = last_card(monte_compra)
		
		
		if IA:
			if timer == 0.1:
				lastcard_monte.anim_play(1)
			elif timer == 0.4:
				lastcard_monte.anim_play(2)
				
			lastcard_monte.stado = lastcard_monte.IA
			
			local_monte.rect_clip_content = true
		
		
		move_anim(lastcard_monte , lastcard_monte.rect_position, posicao_anim ,timer)
		yield(tween,"tween_completed")
		
		if IA == false:
			lastcard_monte.stado = lastcard_monte.mao
		lastcard_monte.foco = false
		lastcard_monte.ative = false
		monte_compra.remove_child(lastcard_monte)
		local_monte.add_child(lastcard_monte)
		comprando = false
	


func _on_Cancelar_pressed():
	$Button.visible = true
	$notif_sair.visible = false
