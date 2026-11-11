@tool
extends Node2D
## Ticket #30 — art de la table (nouvelle art, mêmes rôles et tailles).
## Coordonnées écran : 720 x 1280, y vers le bas. Le haut de l'écran
## est le côté du haut (monde y = 1280), le bas celui du bas (monde y = 0).
## Faces internes des murs : x = 30 et x = 690 (physique.md).

const L := 720.0
const H := 1280.0
const RAIL := 30.0
const BUT_DEMI := 110.0 # bouche du but : 220 px centrée

const FOND := Color(0.04, 0.09, 0.20)
const GLACE_HAUT := Color(0.55, 0.78, 0.96)
const GLACE_BAS := Color(0.62, 0.83, 0.98)
const LIGNE := Color(0.97, 0.98, 1.0)
const RAIL_COUL := Color(0.75, 0.16, 0.18)
const RAIL_SOMBRE := Color(0.45, 0.08, 0.10)
const FILET := Color(0.10, 0.14, 0.22)
const SCORE := Color(0.10, 0.16, 0.30)

var score_bas := 0:
	set(v):
		score_bas = v
		queue_redraw()
var score_haut := 0:
	set(v):
		score_haut = v
		queue_redraw()


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	# Fond autour (ne déborde jamais : la table remplit l'écran).
	draw_rect(Rect2(0, 0, L, H), FOND)
	# Surface de jeu entre les rails.
	var surf := Rect2(RAIL, RAIL, L - 2.0 * RAIL, H - 2.0 * RAIL)
	draw_rect(Rect2(surf.position.x, surf.position.y, surf.size.x, surf.size.y / 2.0), GLACE_HAUT)
	draw_rect(Rect2(surf.position.x, surf.position.y + surf.size.y / 2.0, surf.size.x, surf.size.y / 2.0), GLACE_BAS)
	# Ligne du milieu et rond central.
	draw_line(Vector2(RAIL, H / 2.0), Vector2(L - RAIL, H / 2.0), LIGNE, 8.0)
	draw_arc(Vector2(L / 2.0, H / 2.0), 90.0, 0.0, TAU, 48, LIGNE, 8.0)
	draw_circle(Vector2(L / 2.0, H / 2.0), 12.0, LIGNE)
	# Traits des zones de but (devant chaque bouche).
	draw_line(Vector2(L / 2.0 - BUT_DEMI, 210.0), Vector2(L / 2.0 + BUT_DEMI, 210.0), LIGNE, 6.0)
	draw_line(Vector2(L / 2.0 - BUT_DEMI, H - 210.0), Vector2(L / 2.0 + BUT_DEMI, H - 210.0), LIGNE, 6.0)
	# Bouches de but : filet sombre derrière l'ouverture.
	draw_rect(Rect2(L / 2.0 - BUT_DEMI, 0, 2.0 * BUT_DEMI, RAIL), FILET)
	draw_rect(Rect2(L / 2.0 - BUT_DEMI, H - RAIL, 2.0 * BUT_DEMI, RAIL), FILET)
	_draw_rails()
	_draw_scores()


func _draw_scores() -> void:
	var fonte := ThemeDB.fallback_font
	# Score du bas, côté joueur.
	draw_string(fonte, Vector2(60, 1210), str(score_bas),
		HORIZONTAL_ALIGNMENT_CENTER, 600, 96, SCORE)
	# Score du haut, tourné de 180° pour le camp adverse.
	draw_set_transform(Vector2(L / 2.0, 140.0), PI, Vector2.ONE)
	draw_string(fonte, Vector2(-300, 34), str(score_haut),
		HORIZONTAL_ALIGNMENT_CENTER, 600, 96, SCORE)
	draw_set_transform(Vector2.ZERO, 0.0, Vector2.ONE)


func _draw_rails() -> void:
	# Rails latéraux pleins.
	draw_rect(Rect2(0, 0, RAIL, H), RAIL_COUL)
	draw_rect(Rect2(L - RAIL, 0, RAIL, H), RAIL_COUL)
	draw_rect(Rect2(0, 0, 6.0, H), RAIL_SOMBRE)
	draw_rect(Rect2(L - 6.0, 0, 6.0, H), RAIL_SOMBRE)
	# Rails des bouts, coupés à la bouche du but.
	for y in [0.0, H - RAIL]:
		draw_rect(Rect2(0, y, L / 2.0 - BUT_DEMI, RAIL), RAIL_COUL)
		draw_rect(Rect2(L / 2.0 + BUT_DEMI, y, L / 2.0 - BUT_DEMI, RAIL), RAIL_COUL)
