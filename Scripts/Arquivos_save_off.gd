extends Node

var nome :String = ""
var new_conta :bool = true

# arquivos salvos off
#var e_mail
#var senha
var volume_music
var volume_fx
var icon_perfil
var borda_perfil
var linguagem

const senha_cripp = [""]
const arquivo_login = "user://.json"
const arquivo_dados = "user://.json"
var dados_save_off = ["false" ,0,0,0,"",""]
var login_save_off = [  "false"  ,  "" , ""  ]

func _ready():
	load_arquivo_dados_off()
	load_arquivo_login_off()
	

func save_arquivo_login_off():
	
	var file = File.new()
	var result = file.open_encrypted_with_pass(arquivo_login, file.WRITE, str(senha_cripp))
	if result == OK:
		
		file.store_line(to_json(login_save_off))
		
		file.close()
		
func load_arquivo_login_off():
	var file = File.new()
	var result = file.open_encrypted_with_pass(arquivo_login, file.READ, str(senha_cripp))
	if result == OK:
		var text = file.get_as_text()
		var tem = {}
		tem = parse_json(text)
		login_save_off = tem
		file.close()






func save_arquivo_dados_off():
	var file = File.new()
	var result = file.open(arquivo_dados, File.WRITE)
	if result == OK:
		dados_save_off[0] = "true"
		file.store_line(to_json(dados_save_off))
		file.close()

func load_arquivo_dados_off():
	var file = File.new()
	var result = file.open(arquivo_dados, File.READ)
	if result == OK:
		var text = file.get_as_text()
		var tem = {}
		tem = parse_json(text)
		dados_save_off = tem
		file.close()






