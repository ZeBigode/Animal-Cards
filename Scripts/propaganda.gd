extends Node2D

var videos_por_d = 0
onready var admob = $AdMob


func _ready():
	atualiza_vp()
	loadAds()
# warning-ignore:return_value_discarded
	get_tree().connect("screen_resized", self, "_on_resize")

func loadAds() -> void:
	#admob.load_banner()
	#admob.load_interstitial()
	admob.load_rewarded_video()
	#admob.load_rewarded_interstitial()


func atualiza_vp():
	$num2.text = str(videos_por_d)+"/30"
	$num.text = str($"..".points_videos)


func _on_btn_adbom_pressed():
	if videos_por_d < 30:
		$"..".som_btn()
		print("chamndo video")
		admob.show_rewarded_video()


func _on_AdMob_rewarded_video_loaded():
	print("carrgor video")


func _on_AdMob_rewarded_video_failed_to_load(_error_code):
	yield(get_tree().create_timer(1.0), "timeout")
	admob.load_rewarded_video()


func _on_AdMob_rewarded_video_closed():
	admob.load_rewarded_video()


func _on_AdMob_rewarded(_currency, amount):
	videos_por_d += 2
	$"..".points_videos += 2
	$"..".salvar_BD_firebase()
	atualiza_vp()
	
