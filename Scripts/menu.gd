extends Node2D 

var nick_name = "" 
var coins = 0
var coins_diario = true
#niveis xps
var nivel = 1
var curruntXp = 0
var max_xp_nivel = calculate_xp_needed_for_level(nivel , 250 , 1.3)
#vips xps poind video
var vip = 1
var vipsXp = 0
var points_videos = 12000

onready var cena_save = get_node("../saveload_dados_on")

var atulizar_pront = false

func _ready():
	#$Label.text = str(Godotgoogleplaybilling.test)
	vip_xp(vipsXp)
	max_xp_nivel = calculate_xp_needed_for_level(nivel , 250 , 1.3)
	show_menu(true)
	
	if coins_diario:
		$canv_mtr_poupu/tela_recompensa/moeda_icon/tex_recom.text = "+" + str(amaut_coins_diario(vip))
		yield(get_tree().create_timer(.3),"timeout")
		$canv_mtr_poupu/tela_recompensa.visible = true

		$bnt_room.disabled = true
		$bnt_play.disabled = true
		$btn_shop.disabled = true
		$config_btn.disabled = true
		$perfil/butn_perfil.disabled = true
		$VIP/Button.disabled = true
		$coin/btn_compra.disabled = true
		$propaganda/btn_adbom.visible = false
	
	atualiza_info_mesa($room.cor_nivel,$room.valor_moedas,$room.nivel_mesa,$room.cap_mesa)


func _process(_delta):
	
	vip_xp(vipsXp)
	$VIP.xp_vip_atual = vipsXp
	$VIP.xp_vip_ness = calculate_xp_needed_for_level(vip,600 ,1.5)
	$popupmenu/P_INFORMACOES/bg_j5/bar_nivel_info.max_value = max_xp_nivel
	$popupmenu/P_INFORMACOES/bg_j5/bar_nivel_info.value = curruntXp
	$popupmenu/P_INFORMACOES/bg_j5/bar_nivel_info/info.text = str(curruntXp) +"/"+ str(max_xp_nivel)
	if $loja.add_vips != 0 :
		vipsXp += $loja.add_vips
		$loja.add_vips = 0
	if $loja.add_coin != 0 :
		coins += $loja.add_coin
		$loja.add_coin = 0
		
	$perfil/icon/num.text = tr("P_NIVEL")+" "+str(nivel)
	$coin/num.text = str(coins)
	$coin_sale/num.text = str(coins)
	

func salvar_BD_firebase():
	#aqui passar todos dados para salvaar
	cena_save.nome = nick_name
	cena_save.coins = coins
	cena_save.nivel = nivel
	cena_save.xp_nivel = curruntXp
	cena_save.xp_vip = vipsXp
	cena_save.qty_jogos = $perfil.qty_jogos
	cena_save.vitorias = $perfil.vitorias
	cena_save.pontos_videos = points_videos
	cena_save.qty_dia_points_video = $propaganda.videos_por_d
	cena_save.trofeus1 = $perfil.trofeus1
	cena_save.trofeus2 = $perfil.trofeus2
	cena_save.trofeus3 = $perfil.trofeus3
	cena_save.trofeus4 = $perfil.trofeus4
	#aqui chma metado save
	cena_save.save_updt_profile()
	pass

func amaut_coins_diario(vipp):
	var coinss = 0
	if vipp == 1:
		coinss = 2500
	elif vipp == 2:
		coinss = 5000
	elif vipp == 3:
		coinss = 10000
	elif vipp == 4:
		coinss = 20000
	elif vipp == 5:
		coinss = 50000
	elif vipp == 6:
		coinss = 100000
	elif vipp == 7:
		coinss = 200000
	elif vipp == 8:
		coinss = 350000
	elif vipp == 9:
		coinss = 500000
	elif vipp == 10:
		coinss = 1000000
	
	return coinss
	


func add_xp(amount):
	curruntXp += amount
	# Se o jogador atingir a quantidade máxima de XP, ele sobe de nível
	if curruntXp >= max_xp_nivel:
		level_up()

# Função para aumentar o nível do jogador
func level_up():
	nivel += 1
	# Aumenta a quantidade máxima de XP necessária para subir de nível
	
	var restoxp =  abs(max_xp_nivel - curruntXp)
	max_xp_nivel = calculate_xp_needed_for_level(nivel , 250 , 1.3)
	curruntXp = 0
	add_xp(restoxp)
	

func _on_butn_perfil_pressed():
	$perfil.atualiza_tudo()
	$perfil.atualiza_dados_perfil()
	$perfil/bg_perfil.visible = false
	$perfil/icon.visible = false
	som_btn()
	show_menu(false)
	$popupmenu.current_tab = 0
	$popupmenu.visible = true
	$popupmenu/P_INFORMACOES/btn_menu.visible = true

func _on_back_menu_pressed():
	$room.atualizar_nivel()
	som_btn()
	interpolacao_camera(Vector2(1280,0), Vector2() )
	show_menu(true)

func _on_config_btn_pressed():
	som_btn()
	show_menu(false)
	interpolacao_camera(Vector2(),Vector2(1280,0) )

func interpolacao_camera(val_init, val_final):
	$tween.interpolate_property($camera , "position" , val_init,val_final ,1 , Tween.TRANS_EXPO,Tween.EASE_OUT ,0)
	$tween.start()
	
func _on_btn_compra_pressed():
	som_btn()
	show_menu(false)
	$loja.visible = true

func _on_btn_shop_pressed():
	
	som_btn()
	show_menu(false)
	$loja.visible = true
	
func _on_back_menu_room_pressed():
	som_btn()
	show_menu(true)
	interpolacao_camera(Vector2(0,-720) , Vector2())

func _on_bnt_room_pressed():
	$room.atualiza_coisns()
	som_btn()
	show_menu(false)
	interpolacao_camera(Vector2(),Vector2(0,-720))
	
	
	
func atualiza_info_mesa(cor , valor , nivell , capmesa):
	
	$bnt_play/info_mesa/bg_info.modulate = cor
	$bnt_play/info_mesa/info_nivel.text = nivell
	$bnt_play/info_mesa/info_coin_m.text = formatNumber(valor)
	$bnt_play/info_mesa/icon/num_muilty.text = str(capmesa)
	
	$room/notifc_coininval2/info_mesa2/bg_info.modulate = cor
	$room/notifc_coininval2/info_mesa2/info_nivel.text = nivell
	$room/notifc_coininval2/info_mesa2/info_coin_m.text = formatNumber(valor)
	$room/notifc_coininval2/info_mesa2/icon/num_muilty.text = str(capmesa)
	
func formatNumber(value):
	
	var suffix = ""
	if value >= 1000000:
		value = value / 1000000.00
		
		suffix = "M"
	elif value >= 10000:
		value = value / 1000.00
		suffix = ".00K"
	return str(value) + suffix

func show_menu(opcao):
	if opcao == true:
		$perfil/bg_perfil.visible = true
		$perfil/icon.visible = true
		$coin.visible = true
		$VIP.visible = true
		$config_btn.disabled = false
		$config_btn.visible = true
		$perfil/butn_perfil.disabled = false
		$btn_shop.visible = true
		$btn_shop.disabled = false
		$bnt_room.disabled = false
		$bnt_room.visible = true
		$bnt_play.disabled = false
		$bnt_play.visible = true
		$propaganda.visible = true
		
	else:
		$perfil/bg_perfil.visible = false
		$perfil/icon.visible = false
		$coin.visible = false
		$VIP.visible = false
		$config_btn.disabled = true
		$config_btn.visible = false
		$perfil/butn_perfil.disabled = true
		$btn_shop.visible = false
		$btn_shop.disabled = true
		$bnt_room.disabled = true
		$bnt_room.visible = false
		$bnt_play.disabled = true
		$bnt_play.visible = false
		$propaganda.visible = false
		

func som_btn():
	$sons_botao.play()
func som_erro():
	$sons_erro.play()

func _on_bnt_play_pressed():
	if coins >= $room.valor_moedas:
		$jogo.alualiza_foucs_vez(1)
		som_btn()
		
		$jogo.atualizar_bots_nomes()
		$jogo.atualizar_bots_board()
		$jogo.atualizar_bots_icon()
		$jogo.tipo_back_icon = $config.back_tipo
		coins -= $room.valor_moedas
		$jogo.escond_cards_sprite(true)
		show_menu(false)
		interpolacao_camera(Vector2() , Vector2(-1280,0))
		yield($tween,"tween_completed")
		$jogo/som_moedas.play()
		$jogo.instaci_sprit_moeds(Vector2(225,590))
		$jogo.instaci_sprit_moeds(Vector2(92,314))
		$jogo.instaci_sprit_moeds(Vector2(579,69))
		$jogo.instaci_sprit_moeds(Vector2(1194,314))
		$jogo.junta_moedasMeio()
		yield(get_tree().create_timer(3),"timeout")
		$jogo.junta_moedasPot()
		yield(get_tree().create_timer(1.7),"timeout")
		
		
		$jogo/init/iniciar_notf.show()
		yield(get_tree().create_timer(.5),"timeout")
		$jogo/init/iniciar_notf.hide()
		$jogo/init/init_jogo.start()
		$jogo.criar_baralho()
		$jogo/som_card_shullfe.play()
		$jogo.destribuir_cards_toods()
		$jogo/init/info_init.show()
		$jogo/monte/monte.show()
		salvar_BD_firebase()


func _on_btn_back_pressed():
	som_btn()
	show_menu(true)
	$loja.visible = false
	salvar_BD_firebase()

func _on_btn_add_vip_pressed():
	som_btn()
	$vip_info.visible = false
	show_menu(false)
	$loja.visible = true

func vip_xp(xp):
	if xp >= 600 and xp < 1697:#2
		vip = 2
		pass
	elif xp >= 1697 and xp < 3117:#3
		vip = 3
		pass
	elif xp >= 3117 and xp < 4800:#4
		vip = 4
		pass
	elif xp >= 4800 and xp < 6708:#5
		vip = 5
		pass
	elif xp >= 6708 and xp < 8818:#6
		vip = 6
		pass
	elif xp >= 8818 and xp < 11112:#7
		vip = 7
		pass
	elif xp >= 11112 and xp < 13576:#8
		vip = 8
		pass
	elif xp >= 13576 and xp < 16200:#9
		vip = 9
		pass
	elif xp >=  16200 :#10
		vip = 10
	if !atulizar_pront :
		$VIP.atualiza_info_vip()
		atulizar_pront = true


func calculate_xp_needed_for_level(level: int, base_xp_needed: int, xp_scale_factor: float) -> int:
	return int(base_xp_needed * pow(level, xp_scale_factor))



func _on_Button_pressed():
	som_btn()
	$jogo/Button.visible = false
	$jogo/notif_sair.visible = true


func _on_btn_sair_pressed():
	
	som_btn()
	$jogo/pote/qty.text = str(0)
	$jogo.pote_mesa = 0
	$jogo.valor_atual = 0
	$jogo.pode_sair = false
	$jogo.started = false
	$jogo.apagatodas_cards()
	$jogo.escond_cards_sprite(false)
	$jogo/init/init_jogo.stop()
	$canv_mtr_poupu/vitoria.apagar_inofs_childs()
	$canv_mtr_poupu/vitoria.visible = false
	$canv_mtr_poupu/anim.stop()
	show_menu(true)
	interpolacao_camera(Vector2(-1280,0), Vector2() )
	salvar_BD_firebase()


func _on_sair_pressed():
	som_btn()
	$jogo/Button.visible = true
	$jogo/notif_sair.visible = false
	$jogo/pote/qty.text = str(0)
	$jogo.pote_mesa = 0
	$jogo.valor_atual = 0
	$jogo.pode_sair = false
	$jogo.started = false
	$jogo.escond_cards_sprite(false)
	$jogo/init/init_jogo.stop()
	show_menu(true)
	interpolacao_camera(Vector2(-1280,0), Vector2() )
	yield($tween,"tween_completed")
	$jogo.apagatodas_cards()
	salvar_BD_firebase()



func _on_ok_pressed():
	$canv_mtr_poupu/tela_recompensa.visible = false
	$bnt_room.disabled = false
	$bnt_play.disabled = false
	$btn_shop.disabled = false
	$config_btn.disabled = false
	$perfil/butn_perfil.disabled = false
	$VIP/Button.disabled = false
	$coin/btn_compra.disabled = false
	$propaganda/btn_adbom.visible = true
	coins += amaut_coins_diario(vip)
	coins_diario = false
	salvar_BD_firebase()



