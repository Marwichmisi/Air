@tool
extends Node2D
## Ticket #30 — la table affiche le match et renvoie les doigts.
## Le drag souris pilote le doigt sur desktop, le tactile sur téléphone.
## Monde (spec) : y vers le haut. Écran : y vers le bas.
## Dans l'éditeur, la garde Engine.is_editor_hint() affiche le coup
## d'envoi sans faire avancer la partie.

const Match := preload("res://scripts/match.gd")

## Ticket #31 — écran de résultat : étoiles dorées/grises proches de
## l'original, voile sombre. Layout et visibilité en code : le transport
## DSH ne porte pas les booléens/Vector2/Color vers node_set_property.
const COULEUR_ETOILE := Color(1.0, 0.79, 0.24)
const COULEUR_ETOILE_VIDE := Color(0.42, 0.45, 0.50)
const COULEUR_VOILE := Color(0.02, 0.04, 0.10, 0.78)

var _partie = null
var _souris_tenue := false
var _resultat_affiche := false

@onready var _table: Node2D = $TableArt
@onready var _palet: Node2D = $Palet
@onready var _bas: Node2D = $MailletBas
@onready var _haut: Node2D = $MailletHaut
@onready var _panneau: Control = $Resultat/Panneau
@onready var _voile: ColorRect = $Resultat/Panneau/Voile
@onready var _titre_bas: Label = $Resultat/Panneau/TitreBas
@onready var _titre_haut: Label = $Resultat/Panneau/TitreHaut
@onready var _btn_recommencer: Button = $Resultat/Panneau/Recommencer
@onready var _btn_menu: Button = $Resultat/Panneau/Menu


static func monde_vers_ecran(p: Vector2) -> Vector2:
	return Vector2(p.x, 1280.0 - p.y)


static func ecran_vers_monde(p: Vector2) -> Vector2:
	return Vector2(p.x, 1280.0 - p.y)


func _ready() -> void:
	_partie = Match.new()
	_disposer_resultat()
	_rafraichir_vue()


func _process(_delta: float) -> void:
	if Engine.is_editor_hint():
		return
	if _partie == null:
		return
	if _partie.termine():
		if not _resultat_affiche:
			_afficher_resultat()
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
	if _resultat_affiche:
		return
	_partie.set_doigt_bas(ecran_vers_monde(ecran))


func _rafraichir_vue() -> void:
	_palet.position = monde_vers_ecran(_partie.palet_pos)
	_bas.position = monde_vers_ecran(_partie.maillet_bas_pos)
	_haut.position = monde_vers_ecran(_partie.maillet_haut_pos)
	_table.set("score_bas", _partie.score_bas)
	_table.set("score_haut", _partie.score_haut)


## Ticket #31 — dispose le panneau de résultat (texte + étoiles +
## boutons). Positions écran 720 x 1280, y vers le bas : le mot du
## joueur en bas (25 % de la hauteur), celui du haut tourné de 180°
## (75 %), les étoiles au centre (ecrans.md §Fin de partie).
func _disposer_resultat() -> void:
	_panneau.set_anchors_preset(Control.PRESET_FULL_RECT)
	_voile.set_anchors_preset(Control.PRESET_FULL_RECT)
	_voile.color = COULEUR_VOILE
	_titre_bas.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_titre_bas.add_theme_font_size_override("font_size", 72)
	_titre_bas.position = Vector2(0, 896)
	_titre_bas.size = Vector2(720, 120)
	_titre_haut.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	_titre_haut.add_theme_font_size_override("font_size", 72)
	_titre_haut.position = Vector2(0, 264)
	_titre_haut.size = Vector2(720, 120)
	_titre_haut.pivot_offset = _titre_haut.size / 2.0
	_titre_haut.rotation = PI
	for i in 3:
		var e := _etoile_label(i)
		e.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		e.add_theme_font_size_override("font_size", 96)
		e.size = Vector2(120, 120)
		e.position = Vector2(170.0 + float(i) * 130.0, 580)
	_btn_recommencer.add_theme_font_size_override("font_size", 40)
	_btn_recommencer.position = Vector2(210, 1040)
	_btn_recommencer.size = Vector2(300, 90)
	_btn_menu.add_theme_font_size_override("font_size", 40)
	_btn_menu.position = Vector2(210, 1142)
	_btn_menu.size = Vector2(300, 90)
	_panneau.visible = false


func _etoile_label(i: int) -> Label:
	return _panneau.get_node("Etoile%d" % (i + 1)) as Label


func _colorier_etoiles(n: int) -> void:
	for i in 3:
		_etoile_label(i).add_theme_color_override(
			"font_color", COULEUR_ETOILE if i < n else COULEUR_ETOILE_VIDE
		)


func _afficher_resultat() -> void:
	_resultat_affiche = true
	var gagne: bool = _partie.gagnant() == "bas"
	_titre_bas.text = "GAGNÉ !" if gagne else "PERDU"
	_titre_haut.text = "PERDU" if gagne else "GAGNÉ !"
	_colorier_etoiles(_partie.etoiles())
	_panneau.visible = true
	if not Engine.is_editor_hint():
		_animer_etoiles()


## Petite animation de victoire : les étoiles surgissent en cascade.
func _animer_etoiles() -> void:
	for i in 3:
		var e := _etoile_label(i)
		e.pivot_offset = e.size / 2.0
		e.scale = Vector2(0.01, 0.01)
		var tw := create_tween()
		tw.tween_interval(0.12 * float(i))
		tw.tween_property(e, "scale", Vector2.ONE, 0.3)\
			.set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)


## Recommencer relance le coup d'envoi à 0-0 (regles.md §Recommencer).
func _sur_recommencer() -> void:
	_partie.recommencer()
	_panneau.visible = false
	_resultat_affiche = false
	_rafraichir_vue()


## TODO (ticket menu) : afficher le menu au lieu de refermer le panneau.
func _sur_menu() -> void:
	_panneau.visible = false
