extends Node2D

onready var coins = $"../".coins

var anim_playng = false
var nivel_mesa = tr("P_INICIANTE")
var cap_mesa = 4
var valor_moedas = 500
var cor_nivel = "59d51b"
var trof = 1
var cor_iniciante = "59d51b"
var cor_experiente = "0023ff"
var cor_profisional = "fff800" 
var cor_genio = "b000bc"


func _ready():
	atualiza_coisns()
	$sale.current_tab = 1
	

func atualiza_coisns():
	coins = $"../".coins
	
	
	
func atualizar_nivel():
	var extra_arg_1 = valor_moedas
	var mesa = 4
	match mesa:
		2:
			if extra_arg_1 < 11000:
				
				cor_nivel = cor_iniciante
				nivel_mesa = tr("P_INICIANTE")
			elif extra_arg_1 >11000 and extra_arg_1 < 110000:
				cor_nivel = cor_experiente
				nivel_mesa = tr("P_EXPERIENTE")
			elif extra_arg_1 >110000 and extra_arg_1 < 1100000:
				cor_nivel = cor_profisional
				nivel_mesa = tr("P_PROFISSIONAL")
			elif extra_arg_1 >1100000:
				cor_nivel = cor_genio
				nivel_mesa = tr("P_GENIO")
		4:
			if extra_arg_1 < 11000:
				cor_nivel = "59d51b"
				nivel_mesa = tr("P_INICIANTE")
			elif extra_arg_1 >11000 and extra_arg_1 < 60000:
				cor_nivel = "0023ff"
				nivel_mesa = tr("P_EXPERIENTE")
			elif extra_arg_1 >60000 and extra_arg_1 < 510000:
				cor_nivel = "fff800"
				nivel_mesa = tr("P_PROFISSIONAL")
			elif extra_arg_1 >510000:
				cor_nivel = "b000bc"
				nivel_mesa = tr("P_GENIO")

func _on_Button_pressed(extra_arg_0, extra_arg_1):
	atualizar_nivel()
	
	if coins < extra_arg_1:
		if !anim_playng:
			anim_playng = true
			$anim.set_current_animation("not_coin")
			$"..".som_erro()
			yield($anim, "animation_finished")
		return
	$"..".som_btn()
	cap_mesa = extra_arg_0
	valor_moedas = extra_arg_1
	
	match extra_arg_0:
		2:
			if extra_arg_1 < 11000:
				
				cor_nivel = cor_iniciante
				nivel_mesa = tr("P_INICIANTE")
			elif extra_arg_1 >11000 and extra_arg_1 < 110000:
				cor_nivel = cor_experiente
				nivel_mesa = tr("P_EXPERIENTE")
			elif extra_arg_1 >110000 and extra_arg_1 < 1100000:
				cor_nivel = cor_profisional
				nivel_mesa = tr("P_PROFISSIONAL")
			elif extra_arg_1 >1100000:
				cor_nivel = cor_genio
				nivel_mesa = tr("P_GENIO")
		4:
			if extra_arg_1 < 11000:
				trof = 1
				cor_nivel = "59d51b"
				nivel_mesa = tr("P_INICIANTE")
			elif extra_arg_1 >11000 and extra_arg_1 < 60000:
				trof = 2
				cor_nivel = "0023ff"
				nivel_mesa = tr("P_EXPERIENTE")
			elif extra_arg_1 >60000 and extra_arg_1 < 510000:
				trof = 3
				cor_nivel = "fff800"
				nivel_mesa = tr("P_PROFISSIONAL")
			elif extra_arg_1 >510000:
				trof = 4
				cor_nivel = "b000bc"
				nivel_mesa = tr("P_GENIO")
	
	$notifc_coininval2/info_mesa2/info_nivel.text = nivel_mesa
	$notifc_coininval2/info_mesa2/info_coin_m.text = $"..".formatNumber(valor_moedas)
	$notifc_coininval2/info_mesa2/bg_info.modulate = cor_nivel
	if !anim_playng:
		anim_playng = true
		$anim.play("notifi_bar")
		yield($anim, "animation_finished")

	$"..".atualiza_info_mesa(cor_nivel,valor_moedas,nivel_mesa,cap_mesa)

func _on_anim_animation_finished(_anim_name):
	anim_playng = false
	
