extends Node2D

onready var max_value = $"..".points_videos

var edit_tmp = 0
var edit_tmp_coin = 0
var vps_coins = 1000
var add_coin = 0
var vps_vips_poins = 5
var add_vips = 0

func _ready():
	$TabContainer/P_TROCA/troca_p_vips/pain/info/num2.text = str(vps_vips_poins)
	$TabContainer/P_TROCA/troca_p_coins/pain2/info/num2.text =str(vps_coins)
	
func _process(_delta):
	$propaganda2/num.text = str($"..".points_videos)
	max_value = $"..".points_videos
	if $TabContainer/P_TROCA/troca_p_vips/pain/troca/edit_vps.text != "":
		$TabContainer/P_TROCA/troca_p_vips/pain/troca/info_vips.text = str(edit_tmp * vps_vips_poins)
	else:
		$TabContainer/P_TROCA/troca_p_vips/pain/troca/info_vips.text = "0"
		
	if $TabContainer/P_TROCA/troca_p_coins/pain2/troca/edit_vps_coin.text != "":
		$TabContainer/P_TROCA/troca_p_coins/pain2/troca/info_coins.text = str(edit_tmp_coin * vps_coins)
	else:
		$TabContainer/P_TROCA/troca_p_coins/pain2/troca/info_coins.text = "0"
		

func _on_edit_vps_text_changed(new_text):
	$"..".som_btn()
	if new_text.is_valid_integer():
		var value = new_text.to_int()
		edit_tmp = value
		 # se o número inserido for maior que a variável max_value, defina o texto para o valor de max_value
		if value > max_value:
			$TabContainer/P_TROCA/troca_p_vips/pain/troca/edit_vps.text = (str(max_value))
			edit_tmp = max_value
	else:
		$TabContainer/P_TROCA/troca_p_vips/pain/troca/edit_vps.text = str(edit_tmp)

func _on_btn_trocar_pressed():
	$"..".som_btn()
	if int($TabContainer/P_TROCA/troca_p_vips/pain/troca/info_vips.text) != 0 :
		add_vips = int($TabContainer/P_TROCA/troca_p_vips/pain/troca/info_vips.text)
		$"..".points_videos -= edit_tmp
		$TabContainer/P_TROCA/troca_p_vips/pain/troca/info_vips.text = ""
		$TabContainer/P_TROCA/troca_p_vips/pain/troca/edit_vps.text = ""
		$"../VIP".atualiza_info_vip()
		
		$"../propaganda".atualiza_vp()
		
	

func _on_edit_vps_coin_text_changed(new_text):
	$"..".som_btn()
	if new_text.is_valid_integer():
		var value = new_text.to_int()
		edit_tmp_coin = value
		 # se o número inserido for maior que a variável max_value, defina o texto para o valor de max_value
		if value > max_value:
			$TabContainer/P_TROCA/troca_p_coins/pain2/troca/edit_vps_coin.text = (str(max_value))
			edit_tmp_coin = max_value
		
	else:
		$TabContainer/P_TROCA/troca_p_coins/pain2/troca/edit_vps_coin.text = str(edit_tmp_coin)

func _on_btn_trocar2_pressed():
	$"..".som_btn()
	if int($TabContainer/P_TROCA/troca_p_coins/pain2/troca/info_coins.text) != 0 :
		add_coin = int($TabContainer/P_TROCA/troca_p_coins/pain2/troca/info_coins.text)
		$"..".points_videos -= edit_tmp_coin
		$TabContainer/P_TROCA/troca_p_coins/pain2/troca/edit_vps_coin.text = ""
		$TabContainer/P_TROCA/troca_p_coins/pain2/troca/info_coins.text = ""
		
		$"../propaganda".atualiza_vp()
