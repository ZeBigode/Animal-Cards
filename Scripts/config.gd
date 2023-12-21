extends Node2D


var cor_bord = "14e300"
var corgreen = "3dee02"
var corred = "ee0202"
var back_tipo = 1
var back_icon = preload("res://Texture/card_back1.png")
var back_icon2 = preload("res://Texture/card_back2.png")

var vl_music = 10 #vai de 10 a -50 
var vl_fx = 10

func _ready():
	if ArquivosSaveOff.dados_save_off[0] == "true":
		vl_music = ArquivosSaveOff.dados_save_off[1]
		vl_fx = ArquivosSaveOff.dados_save_off[2]

	_on_hs_barmusic_value_changed(vl_music)
	$music_bg/hs_barmusic.value = vl_music
	_on_hs_barsound_value_changed(vl_fx)
	$soundfx/hs_barsound.value = vl_fx
	pass



func _on_hs_barmusic_value_changed(value):
	vl_music = value
	AudioServer.set_bus_volume_db(1,value)
	$timer_save_sons.start()
	
	
func _on_hs_barsound_value_changed(value):
	vl_fx = value
	AudioServer.set_bus_volume_db(2,value)
	$timer_save_sons.start()

func _on_color_pressed():
	$"..".som_btn()
	$idioma/btn_idioma.disabled = true
	$funco_carta/icon/btn.disabled = true
	$bordaCards/bg.visible = true


func _on_Button_pressed():
	$"..".som_btn()
	$idioma/btn_idioma.disabled = false
	$bordaCards/color.disabled = false
	$funco_carta/icon/btn.disabled = false
	$bordaCards/bg.visible = false



func _on_ColorPicker_color_changed(color):
	cor_bord = color
	$bordaCards/color.modulate = cor_bord


func _on_Button2_pressed():
	$"..".som_btn()
	$idioma/btn_idioma.disabled = false
	$bordaCards/color.disabled = false
	$funco_carta/icon/btn.disabled = false
	if back_tipo == 1 :
		$funco_carta/icon.texture = back_icon
	elif back_tipo == 2 :
		$funco_carta/icon.texture = back_icon2
	$funco_carta/opc.visible = false


func _on_icon1_pressed():
	$"..".som_btn()
	back_tipo = 1
	$funco_carta/opc/icon/Sprite.visible = true
	$funco_carta/opc/icon2/Sprite2.visible = false


func _on_icon2_pressed():
	$"..".som_btn()
	back_tipo = 2
	$funco_carta/opc/icon/Sprite.visible = false
	$funco_carta/opc/icon2/Sprite2.visible = true


func _on_btn_pressed():
	$"..".som_btn()
	$idioma/btn_idioma.disabled = true
	$bordaCards/color.disabled = true
	$funco_carta/opc.visible = true


func _on_lingua_pressed():
	$"..".som_btn()
	TranslationServer.set_locale("pt_BR")
	ArquivosSaveOff.dados_save_off[5] = "pt_BR"
	


func _on_lingua2_pressed():
	$"..".som_btn()
	TranslationServer.set_locale("de_DE")
	ArquivosSaveOff.dados_save_off[5] = "de_DE"
	


func _on_lingua3_pressed():
	$"..".som_btn()
	TranslationServer.set_locale("en_US")
	ArquivosSaveOff.dados_save_off[5] = "en_US"
	


func _on_lingua4_pressed():
	$"..".som_btn()
	TranslationServer.set_locale("fr_FR")
	ArquivosSaveOff.dados_save_off[5] = "fr_FR"


func _on_lingua5_pressed():
	$"..".som_btn()
	TranslationServer.set_locale("es_ES")
	ArquivosSaveOff.dados_save_off[5] = "es_ES"


func _on_btn_idioma_pressed():
	$"..".som_btn()
	$bordaCards/color.disabled = true
	$funco_carta/icon/btn.disabled = true
	$idioma/bg.visible = true
	
	


func _on_btn_idio_back_pressed():
	$"..".som_btn()
	$bordaCards/color.disabled = false
	$funco_carta/icon/btn.disabled = false
	$idioma/bg.visible = false
	ArquivosSaveOff.save_arquivo_dados_off()


func _on_timer_save_sons_timeout():
	ArquivosSaveOff.dados_save_off[1] = vl_music
	ArquivosSaveOff.dados_save_off[2] = vl_fx
	ArquivosSaveOff.save_arquivo_dados_off()
	
