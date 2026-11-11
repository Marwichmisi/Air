@tool
extends Node2D
## Ticket #30 — la table affiche le match et renvoie les doigts.
## Le drag souris pilote le doigt sur desktop, le tactile sur téléphone.
## Monde (spec) : y vers le haut. Écran : y vers le bas.
## Dans l'éditeur, la garde Engine.is_editor_hint() affiche le coup
## d'envoi sans faire avancer la partie.

const Match := preload("res://scripts/match.gd")

var _partie = null
var _souris_tenue := false

@onready var _table: Node2D = $TableArt
@onready var _palet: Node2D = $Palet
@onready var _bas: Node2D = $MailletBas
@onready var _haut: Node2D = $MailletHaut


static func monde_vers_ecran(p: Vector2) -> Vector2:
	return Vector2(p.x, 1280.0 - p.y)


static func ecran_vers_monde(p: Vector2) -> Vector2:
	return Vector2(p.x, 1280.0 - p.y)


func _ready() -> void:
	_partie = Match.new()
	_rafraichir_vue()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if _partie == null:
		return
	_partie.step()
	_rafraichir_vue()


func _input(event: InputEvent) -> void:
	if Engine.is_editor_hint():
		return
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		_souris_tenue = event.pressed
		if event.pressed:
			_toucher(_vers_scene(event.position))
		elif _partie != null:
			_partie.lever_doigt()
	elif event is InputEventMouseMotion and _souris_tenue:
		_toucher(_vers_scene(event.position))
	elif event is InputEventScreenTouch:
		if _partie == null:
			return
		if event.pressed:
			_toucher(_vers_scene(event.position))
		else:
			_partie.lever_doigt()
	elif event is InputEventScreenDrag:
		_toucher(_vers_scene(event.position))


## La position d'un événement est en pixels de fenêtre : on la ramène
## dans la scène 720 x 1280 (identité quand la fenêtre fait déjà 720 x 1280).
func _vers_scene(p_vue: Vector2) -> Vector2:
	return get_canvas_transform().affine_inverse() * p_vue


func _toucher(ecran: Vector2) -> void:
	if _partie == null:
		return
	_partie.set_doigt_bas(ecran_vers_monde(ecran))


func _rafraichir_vue() -> void:
	_palet.position = monde_vers_ecran(_partie.palet_pos)
	_bas.position = monde_vers_ecran(_partie.maillet_bas_pos)
	_haut.position = monde_vers_ecran(_partie.maillet_haut_pos)
	_table.set("score_bas", _partie.score_bas)
	_table.set("score_haut", _partie.score_haut)
