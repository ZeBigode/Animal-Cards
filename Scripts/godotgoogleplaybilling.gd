extends Node

var payment
var itemToken
# Called when the node enters the scene tree for the first time.
func _ready():
	if Engine.has_singleton("GodotGooglePlayBilling"):
		payment = Engine.get_singleton("GodotGooglePlayBilling")
		
		payment.connect("connected", self, "_on_connected") # No params
		payment.connect("disconnected", self, "_on_disconnected") # No params
		payment.connect("connect_error", self, "_on_connect_error") # Response ID (int), Debug message (string)
		payment.connect("purchases_updated", self, "_on_purchases_updated") # Purchases (Dictionary[])
		payment.connect("purchase_error", self, "_on_purchase_error") # Response ID (int), Debug message (string)
		payment.connect("product_details_query_completed", self, "_on_sku_details_query_completed") # SKUs (Dictionary[])
		payment.connect("product_details_query_error", self, "_on_sku_details_query_error") # Response ID (int), Debug message (string), Queried SKUs (string[])
		payment.connect("purchase_acknowledged", self, "_on_purchase_acknowledged") # Purchase token (string)
		payment.connect("purchase_acknowledgement_error", self, "_on_purchase_acknowledgement_error") # Response ID (int), Debug message (string), Purchase token (string)
		payment.connect("purchase_consumed", self, "_on_purchase_consumed") # Purchase token (string)
		payment.connect("purchase_consumption_error", self, "_on_purchase_consumption_error") # Response ID (int), Debug message (string), Purchase token (string)

		payment.startConnection()
		
	else:
		print("Android IAP support is not enabled. Make sure you have enabled 'Custom Build' and the GodotGooglePlayBilling plugin in your Android export settings! IAP will not work.")

func _on_connected():
	pass#payment.querySkuDetails(["teste"], "inapp") # "subs" for subscriptions

func _on_sku_details_query_completed(sku_details):
	for available_sku in sku_details:
		print(available_sku)

func _on_product_details_query_error(response_id, error_message, products_queried):
	print("on_product_details_query_error id:", response_id, " message: ",
			error_message, " products: ", products_queried)
	


func _on_purchase_acknowledged(token):
	print("purchase was acknowledged! " + token)

func _on_purchase_consumed(token):
	print("item was consumed " + token)

func comprar_not_consumi():
	var response = payment.purchase("teste")
	print("purchase has been attempted : result " + response.status)
	if response.status != OK:
		print("error purchasing item")
	pass # Replace with function body.


func comprar_consumi():
	if itemToken == null:
		print("Error you need to buy this first")
	else:
		print("consuming item")
		payment.consumePurchase(itemToken)
	pass # Replace with function body.
