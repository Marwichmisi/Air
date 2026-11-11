@tool
extends Node2D
## Ticket #30 — un disque de la table : palet (r = 30) ou maillet (r = 60).
## Dessin vectoriel (pas de rectangle placeholder).

@export var rayon := 30.0:
	set(v):
		rayon = v
		queue_redraw()
@export var couleur_bord := Color(0.92, 0.92, 0.95):
	set(v):
		couleur_bord = v
		queue_redraw()
@export var couleur_coeur := Color(0.80, 0.12, 0.14):
	set(v):
		couleur_coeur = v
		queue_redraw()


func _ready() -> void:
	queue_redraw()


func _draw() -> void:
	draw_circle(Vector2.ZERO, rayon, couleur_bord)
	draw_circle(Vector2.ZERO, rayon * 0.62, couleur_coeur)
	draw_circle(Vector2.ZERO + Vector2(-rayon * 0.22, -rayon * 0.22), rayon * 0.16, Color(1, 1, 1, 0.55))
