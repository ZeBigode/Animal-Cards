extends Node

onready var scene_menu = preload("res://Scenes/menu.tscn")



# arquivos salvos online
onready var nome = ArquivosSaveOff.nome
onready var coins = 10000
onready var data_ult_login = ""
onready var data_criacao_conta = ""
onready var nivel = 0
onready var xp_nivel = 0
onready var xp_vip = 0
onready var qty_jogos = 0
onready var vitorias = 0
onready var pontos_videos = 0
onready var qty_dia_points_video = 0
onready var trofeus1 = 0
onready var trofeus2 = 0
onready var trofeus3 = 0
onready var trofeus4 = 0
var menu = false
var colet_coins_diario = true
onready var http : HTTPRequest = $HTTPRequest


var new_profile := false
var information_sent := false
var profile := {
	"nome": {},
	"coins": {},
	"data_ult_login": {},
	"data_criacao_conta": {},
	"nivel": {},
	"xp_nivel": {},
	"xp_vip": {},
	"qty_jogos": {},
	"vitorias": {},
	"pontos_videos": {},
	"qty_dia_points_video": {},
	"trofeus1": {},
	"trofeus2": {},
	"trofeus3": {},
	"trofeus4": {}
} 


func _ready() -> void:
	carregar_dados()
	
	

func carregar_dados():
	FireBase.get_document("users/%s" % FireBase.user_info.id, http)

func printss():
	print("foi")

func compare_dates(date_str1: String, date_str2: String) -> int:
	var date_parts1 = date_str1.split("-")
	var date_parts2 = date_str2.split("-")
	
	if date_parts1.size() != 3 or date_parts2.size() != 3:
		# Certifique-se de que as strings estejam no formato esperado (YYYY-MM-DD)
		return 0
	
	var year1 = int(date_parts1[0])
	var month1 = int(date_parts1[1])
	var day1 = int(date_parts1[2])
	
	var year2 = int(date_parts2[0])
	var month2 = int(date_parts2[1])
	var day2 = int(date_parts2[2])
	
	if year1 == year2:
		if month1 == month2:
			if day1 == day2:
				return 0  # Datas iguais
			elif day1 < day2:
				return -1  # data_str1 é anterior a data_str2
			else:
				return 1  # data_str1 é posterior a data_str2
		elif month1 < month2:
			return -1
		else:
			return 1
	elif year1 < year2:
		return -1
	else:
		return 1

func load_variavei_on() -> void:
	nome = profile["nome"]["stringValue"]
	coins = int(profile["coins"]["integerValue"])
	data_ult_login = profile["data_ult_login"]["stringValue"]
	data_criacao_conta = profile["data_criacao_conta"]["stringValue"]
	
	nivel = int(profile["nivel"]["integerValue"])
	xp_nivel = int(profile["xp_nivel"]["integerValue"])
	xp_vip = int(profile["xp_vip"]["integerValue"])
	qty_jogos = int(profile["qty_jogos"]["integerValue"])
	vitorias = int(profile["vitorias"]["integerValue"])
	pontos_videos = int(profile["pontos_videos"]["integerValue"])
	qty_dia_points_video = int(profile["qty_dia_points_video"]["integerValue"])
	trofeus1 = int(profile["trofeus1"]["integerValue"])
	trofeus2 = int(profile["trofeus2"]["integerValue"])
	trofeus3 = int(profile["trofeus3"]["integerValue"])
	trofeus4 = int(profile["trofeus4"]["integerValue"])

func save_updt_profile() -> void:
	
	profile.nome = { "stringValue": nome }
	profile.coins = { "integerValue": coins }
	profile.data_ult_login = { "stringValue": data_ult_login }
	profile.data_criacao_conta = { "stringValue": data_criacao_conta }
	profile.nivel = { "integerValue": nivel }
	profile.xp_nivel = { "integerValue": xp_nivel }
	profile.xp_vip = { "integerValue": xp_vip }
	profile.qty_jogos = { "integerValue": qty_jogos }
	profile.vitorias = { "integerValue": vitorias }
	profile.pontos_videos = { "integerValue": pontos_videos }
	profile.qty_dia_points_video = { "integerValue": qty_dia_points_video }
	profile.trofeus1 = { "integerValue": trofeus1 }
	profile.trofeus2 = { "integerValue": trofeus2 }
	profile.trofeus3 = { "integerValue": trofeus3 }
	profile.trofeus4 = { "integerValue": trofeus4 }
	
	match new_profile:
		true:
			FireBase.save_document("users?documentId=%s" % FireBase.user_info.id, profile, http)
		false:
			FireBase.update_document("users/%s" % FireBase.user_info.id, profile, http)

func _on_HTTPRequest_request_completed(result, response_code, headers, body):
	var result_body := JSON.parse(body.get_string_from_ascii()).result as Dictionary
	print("foii")
	match response_code:
		404:
			data_criacao_conta  =  DataTime.data
			data_ult_login = DataTime.data
			new_profile = true
			colet_coins_diario = true
			inseri_menu("new")
			
			save_updt_profile()

			return
		200:
			self.profile = result_body.fields
			
			load_variavei_on()
			
			if compare_dates(profile["data_ult_login"]["stringValue"],DataTime.data) == 0 :
				colet_coins_diario = false
			
			if compare_dates(profile["data_ult_login"]["stringValue"],DataTime.data) != 0 :
				colet_coins_diario = true
				data_ult_login = DataTime.data
				qty_dia_points_video = 0
				
			
			yield(get_tree().create_timer(3), "timeout")
			if menu == false:
				inseri_menu("already")
				save_updt_profile()
		
	if menu:
		if response_code != 200:
			save_updt_profile()
	



func inseri_menu(tipo :String):
	var instance_menu = scene_menu.instance()
	if tipo == "new":
		instance_menu.nick_name = nome
		instance_menu.coins = coins
		instance_menu.nivel = nivel
		instance_menu.curruntXp = xp_nivel
		instance_menu.vipsXp = xp_vip
		instance_menu.points_videos = pontos_videos
		instance_menu.get_node("propaganda").videos_por_d = qty_dia_points_video
		instance_menu.get_node("perfil").qty_jogos = qty_jogos
		instance_menu.get_node("perfil").vitorias = vitorias
		instance_menu.get_node("perfil").trofeus1 = trofeus1
		instance_menu.get_node("perfil").trofeus2 = trofeus2
		instance_menu.get_node("perfil").trofeus3 = trofeus3
		instance_menu.get_node("perfil").trofeus4 = trofeus4
		instance_menu.coins_diario = colet_coins_diario
	elif tipo == "already":
		instance_menu.nick_name = profile["nome"]["stringValue"]
		instance_menu.coins = int(profile["coins"]["integerValue"])
		instance_menu.nivel = int(profile["nivel"]["integerValue"])
		instance_menu.curruntXp = int(profile["xp_nivel"]["integerValue"])
		instance_menu.vipsXp = int(profile["xp_vip"]["integerValue"])
		instance_menu.points_videos = int(profile["pontos_videos"]["integerValue"])
		instance_menu.get_node("propaganda").videos_por_d = int(qty_dia_points_video)
		instance_menu.get_node("perfil").qty_jogos = int(profile["qty_jogos"]["integerValue"])
		instance_menu.get_node("perfil").vitorias = int(profile["vitorias"]["integerValue"])
		instance_menu.get_node("perfil").trofeus1 = int(profile["trofeus1"]["integerValue"])
		instance_menu.get_node("perfil").trofeus2 = int(profile["trofeus2"]["integerValue"])
		instance_menu.get_node("perfil").trofeus3 = int(profile["trofeus3"]["integerValue"])
		instance_menu.get_node("perfil").trofeus4 = int(profile["trofeus4"]["integerValue"])
		instance_menu.coins_diario = colet_coins_diario
	$"..".add_child(instance_menu)
	menu = true
	$"..".move_save_pos()
