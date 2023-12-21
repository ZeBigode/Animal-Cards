extends Node2D

onready var icon_leon_perfil = preload("res://Sprites/icon_perfil/lion.png")
onready var icon_canguru_perfil = preload("res://Sprites/icon_perfil/canguru.png")
onready var icon_eagle_perfil = preload("res://Sprites/icon_perfil/eagle.png")
onready var icon_gorilla_perfil = preload("res://Sprites/icon_perfil/gorila.png")
onready var icon_pinguin_perfil = preload("res://Sprites/icon_perfil/pinguin.png")
onready var icon_puma_perfil = preload("res://Sprites/icon_perfil/puma.png")
onready var icon_wolf_perfil = preload("res://Sprites/icon_perfil/wolf.png")
onready var icon_zebra_perfil = preload("res://Sprites/icon_perfil/zebra.png")

var arry_icon_texture 

var icon_id = 1
var tmp_icon_id = null
onready var board_perfil = $bg_perfil
var cor_board = "ffffff"
var tmp_borad_cor = null


var qty_jogos = 0
var vitorias = 0
var trofeus1 = 0
var trofeus2 = 0
var trofeus3 = 0
var trofeus4 = 0


func _ready():
	if ArquivosSaveOff.dados_save_off[3] != 0:
		icon_id = ArquivosSaveOff.dados_save_off[3]
		
	if ArquivosSaveOff.dados_save_off[4] != "":
		cor_board = ArquivosSaveOff.dados_save_off[4]
	atualiza_icon_textur(icon_id)
	$icon/nick_name.text = $"..".nick_name
	atualiza_tudo()
	
	
func _process(_delta):
	
	
	if tmp_borad_cor == null and tmp_icon_id == null:
		$"../popupmenu/P_EDITAR/btn_save".disabled = true
		$"../popupmenu/P_EDITAR/btn_save".visible = false
	else:
		$"../popupmenu/P_EDITAR/btn_save".disabled = false
		$"../popupmenu/P_EDITAR/btn_save".visible = true
	
	atualiza_block_bord($"..".nivel, $"..".vip)
	$"../popupmenu/P_INFORMACOES/bg_j3/info_qtyj/num".text = $"..".nick_name
	$icon/nick_name.text = $"..".nick_name
	$"../jogo/players/player1/nick_name".text = $"..".nick_name

func atualiza_tudo():
	if arry_icon_texture == null:
		arry_icon_texture = [icon_leon_perfil,icon_canguru_perfil,icon_eagle_perfil,
						 icon_gorilla_perfil,icon_pinguin_perfil,icon_puma_perfil,
						  icon_wolf_perfil,icon_zebra_perfil]
	$"../popupmenu/P_INFORMACOES/bg_j5/nivel".text = str($"..".nivel)
	if cor_board != null:
		$"../jogo/players/player1/bg".modulate = cor_board
		board_perfil.modulate = cor_board
	pass

func atualiza_dados_perfil():
	$"../popupmenu/P_INFORMACOES/bg_j/info_qtyj/num".text = str(qty_jogos)
	$"../popupmenu/P_INFORMACOES/bg_j4/trofeu4/num".text = str(trofeus4)
	$"../popupmenu/P_INFORMACOES/bg_j4/trofeu3/num".text = str(trofeus3)
	$"../popupmenu/P_INFORMACOES/bg_j4/trofeu2/num".text = str(trofeus2)
	$"../popupmenu/P_INFORMACOES/bg_j4/trofeu/num".text = str(trofeus1)
	$"../popupmenu/P_INFORMACOES/bg_j2/bar_ta".max_value = qty_jogos
	$"../popupmenu/P_INFORMACOES/bg_j2/bar_ta".value = vitorias

func _on_btn_menu_pressed():
	$"..".som_btn()
	$"..".show_menu(true)
	$"../popupmenu".visible = false
	$"../popupmenu/P_INFORMACOES/btn_menu".visible = false

func atualiza_icon_textur(id):
	if id == 1:
			
			$"../jogo/players/player1/icon_perfil".texture = icon_pinguin_perfil
			$icon.texture = icon_pinguin_perfil
	elif id == 2:
			
			$"../jogo/players/player1/icon_perfil".texture = icon_canguru_perfil
			$icon.texture = icon_canguru_perfil
	elif id == 3:
			$"../jogo/players/player1/icon_perfil".texture = icon_gorilla_perfil
			$icon.texture = icon_gorilla_perfil
	elif id == 4:
			$"../jogo/players/player1/icon_perfil".texture = icon_wolf_perfil
			$icon.texture = icon_wolf_perfil
	elif id == 5:
			$"../jogo/players/player1/icon_perfil".texture = icon_puma_perfil
			$icon.texture = icon_puma_perfil
	elif id == 6:
			$"../jogo/players/player1/icon_perfil".texture = icon_zebra_perfil
			$icon.texture = icon_zebra_perfil
	elif id == 7:
			$"../jogo/players/player1/icon_perfil".texture = icon_eagle_perfil
			$icon.texture = icon_eagle_perfil
	elif id == 8:
			$"../jogo/players/player1/icon_perfil".texture = icon_leon_perfil
			$icon.texture = icon_leon_perfil

func _on_LineEdit_text_entered(new_text):
	$"../popupmenu/P_EDITAR/edit_nome/Label2".text = tr("P_INFO_ATUALIZ")
	$"../popupmenu/P_EDITAR/edit_nome/anim".play("atualizar_nome")
	$"../popupmenu/P_EDITAR/edit_nome/LineEdit".editable = false
	$"..".nick_name = new_text
	$"..".salvar_BD_firebase()
	yield($"../popupmenu/P_EDITAR/edit_nome/anim","animation_finished")
	$"../popupmenu/P_EDITAR/edit_nome/LineEdit".text = ""
	$"../popupmenu/P_EDITAR/edit_nome/LineEdit".editable = true
	
	
func _on_Button_pressed(extra_arg_0):
	$"..".som_btn()
	tmp_borad_cor = extra_arg_0
	
	match tmp_borad_cor:
		"ffffff":
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon2/detalhs/select".visible = false
		"000000":
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon2/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon2/detalhs/select".visible = false
		"00ff00":
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon3/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon2/detalhs/select".visible = false
		"ff0000":
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon4/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon2/detalhs/select".visible = false
		"e21bf8":
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon5/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon2/detalhs/select".visible = false
		"ffe400":
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon2/detalhs/select".visible = false
		"000fff":
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon2/detalhs/select".visible = true
		
func atualiza_block_bord(nivel , vip):
	
	if nivel >= 3 :
		$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon3/detalhs/Label".visible = false
		$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon3/detalhs/Button".disabled = false
		$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon3/detalhs/Label".visible = false
		$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon3/detalhs/iButton".disabled = false
	if nivel >= 15:
		$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon5/detalhs/Label".visible = false
		$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon5/detalhs/Button".disabled = false
		$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon5/detalhs/Label".visible = false
		$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon5/detalhs/iButton".disabled = false
	if nivel >= 30:
		$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon2/detalhs/Label".visible = false
		$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon2/detalhs/Button".disabled = false
		$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon2/detalhs/Label".visible = false
		$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon2/detalhs/iButton".disabled = false
	
	if vip >= 3:
		$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon4/detalhs/Label".visible = false
		$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon4/detalhs/Button".disabled = false
		$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon4/detalhs/Label".visible = false
		$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon4/detalhs/iButton".disabled = false
	if vip >= 5:
		$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon/detalhs/Label".visible  = false
		$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon/detalhs/Button".disabled = false
		$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon/detalhs/Label".visible = false
		$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon/detalhs/iButton".disabled = false
	if vip >= 10:
		$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon3/detalhs/Label".visible = false
		$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon3/detalhs/iButton".disabled = false

func _on_btn_save_pressed():
	$"..".som_btn()
	if tmp_icon_id != null:
		$"../popupmenu/P_EDITAR/edit_nome/Label2".text = tr("P_ICONE")
		icon_id = tmp_icon_id
		ArquivosSaveOff.dados_save_off[3] = icon_id
	if tmp_borad_cor != null:
		$"../popupmenu/P_EDITAR/edit_nome/Label2".text = tr("P_INFO_ATUABORD")
		cor_board = tmp_borad_cor
		ArquivosSaveOff.dados_save_off[4] = cor_board
	atualiza_icon_textur(icon_id)
	
	
	ArquivosSaveOff.save_arquivo_dados_off()
	
	rest_foucs()
	if tmp_borad_cor != null or tmp_icon_id != null:
		$"../popupmenu/P_EDITAR/edit_nome/anim".play("atualizar_nome")
		tmp_borad_cor = null
		tmp_icon_id = null
		yield($"../popupmenu/P_EDITAR/edit_nome/anim","animation_finished")
	
	$"..".salvar_BD_firebase()

func rest_foucs():
	$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon2/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon3/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon4/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon/s_icon5/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_board/scrollconteiner/vbconte/icon2/s_icon2/detalhs/select".visible = false
	
	$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon2/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon3/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon4/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon5/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon2/detalhs/select".visible = false
	$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon3/detalhs/select".visible = false

func _on_iButton_pressed(extra_arg_0):
	$"..".som_btn()
	tmp_icon_id = extra_arg_0
	
	match tmp_icon_id:
		1:
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon3/detalhs/select".visible = false
		2:
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon2/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon3/detalhs/select".visible = false
		3:
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon3/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon3/detalhs/select".visible = false
		4:
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon4/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon3/detalhs/select".visible = false
		5:
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon5/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon3/detalhs/select".visible = false
		6:
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon3/detalhs/select".visible = false
		7:
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon2/detalhs/select".visible = true
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon3/detalhs/select".visible = false
		8:
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon3/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon4/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon/s_icon5/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon2/detalhs/select".visible = false
			$"../popupmenu/P_EDITAR/edit_icon/scrollconteiner2/vbconte/icon2/s_icon3/detalhs/select".visible = true
