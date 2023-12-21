extends Node2D


var vip_tmp

var xp_vip_ness = 1250
var xp_vip_atual = 55

func _ready():
	atualiza_info_vip()
	pass

func _process(_delta):
	
	atualiza_barra_xp(xp_vip_ness , xp_vip_atual)
	$"../vip_info/atual_num".text = str($"..".vip)
	$num.text = str($"..".vip)
	if $"..".vip <10:
		atualizar_panil_vip(vip_tmp+1)
		$"../vip_info/proximo_painel/tab_vip".current_tab = vip_tmp 
	else:
		atualizar_panil_vip(vip_tmp)
		$"../vip_info/proximo_painel/tab_vip".current_tab = vip_tmp -1
	$"../vip_info/atual_painel/tab_vip_atual".current_tab = $"..".vip - 1
	
func _on_btn_vip_back_pressed():
	$"..".som_btn()
	$"..".show_menu(true)
	$"../vip_info/btn_vip_back".disabled = true
	$"../vip_info".visible = false


func _on_Button_pressed():
	$"..".som_btn()
	$"..".show_menu(false)
	$"../vip_info/btn_vip_back".disabled = false
	$"../vip_info".visible = true


func _on_btn_mais_pressed():
	$"..".som_btn()
	#$"..".vip += 1
	if vip_tmp < 10:
		vip_tmp +=1 
	
func _on_btn_menos_pressed():
	$"..".som_btn()
	#$"..".vip -= 1
	if vip_tmp > 0:
		vip_tmp -=1

func atualizar_panil_vip(vip):
	$"../vip_info/proximo_painel/vip_name".text = "VIP "+ str(vip)
	
	if vip == 10:
		$"../vip_info/proximo_painel/btn_mais".visible = false
		$"../vip_info/proximo_painel/btn_menos".visible = true
	elif vip == 1:
		$"../vip_info/proximo_painel/btn_mais".visible = true
		$"../vip_info/proximo_painel/btn_menos".visible = false
	else:
		$"../vip_info/proximo_painel/btn_mais".visible = true
		$"../vip_info/proximo_painel/btn_menos".visible = true

func atualiza_barra_xp(max_valuee , value_atual):
	$"../vip_info/bar_xpvip".max_value = max_valuee
	$"../vip_info/bar_xpvip".value = value_atual
	$"../vip_info/bar_xpvip/Label".text = str(value_atual)+"/"+str(max_valuee)
	
	
func atualiza_info_vip():
	if $"..".vip <10:
		$"../vip_info/proximo_painel/tab_vip".current_tab = $"..".vip 
	else:
		$"../vip_info/bar_xpvip".visible = false
		$"../vip_info/proximo_painel/tab_vip".current_tab = $"..".vip - 1
		
	vip_tmp = $"..".vip 
	pass
