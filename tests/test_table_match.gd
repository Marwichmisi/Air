@tool
extends McpTestSuite
## Ticket #30 — la partie se fait avancer sans écran : coup d'envoi,
## attraction du doigt, buts haut/bas lus sur le score.

const Match := preload("res://scripts/match.gd")


func suite_name() -> String:
	return "table"


func test_coup_denvoi() -> void:
	var m = Match.new()
	assert_eq(m.score_bas, 0, "score bas à 0 au coup d'envoi")
	assert_eq(m.score_haut, 0, "score haut à 0 au coup d'envoi")
	assert_eq(m.palet_pos, Vector2(360, 640), "palet au centre")
	assert_eq(m.maillet_bas_pos, Vector2(360, 320), "maillet bas devant son but")
	assert_eq(m.maillet_haut_pos, Vector2(360, 960), "maillet haut devant son but")


func test_doigt_attire_maillet_bas() -> void:
	var m = Match.new()
	m.set_doigt_bas(Vector2(400, 300))
	for i in 60:
		m.step()
	assert_true(
		m.maillet_bas_pos.distance_to(Vector2(400, 300)) < 1.0,
		"le maillet bas rejoint le doigt, écart = %s" % str(m.maillet_bas_pos)
	)
	assert_true(m.maillet_bas_pos.y <= 640.0, "le maillet bas reste dans sa moitié")


func test_doigt_borne_sur_la_table() -> void:
	var m = Match.new()
	m.set_doigt_bas(Vector2(1000, 300))
	for i in 60:
		m.step()
	assert_true(m.maillet_bas_pos.x <= 630.5, "le doigt est ramené au bord x = 630")
	assert_true(
		m.maillet_bas_pos.distance_to(Vector2(630, 300)) < 1.0,
		"le maillet vise le point borné, pos = %s" % str(m.maillet_bas_pos)
	)


func test_doigt_au_dessus_refuse() -> void:
	var m = Match.new()
	m.set_doigt_bas(Vector2(360, 700))
	for i in 30:
		m.step()
	assert_eq(m.maillet_bas_pos, Vector2(360, 320), "doigt au-dessus de y = 650 ignoré")


func test_but_par_le_haut() -> void:
	var m = Match.new()
	m.palet_pos = Vector2(360, 1275)
	m.palet_vel = Vector2(0, 20)
	m.step()
	assert_eq(m.score_bas, 1, "sortie par le haut : +1 pour le bas")
	assert_eq(m.score_haut, 0, "le haut ne marque pas")
	assert_eq(m.palet_pos, Vector2(360, 640), "palet remis au centre après le but")


func test_but_par_le_bas() -> void:
	var m = Match.new()
	m.palet_pos = Vector2(360, 5)
	m.palet_vel = Vector2(0, -20)
	m.step()
	assert_eq(m.score_haut, 1, "sortie par le bas : +1 pour le haut")
	assert_eq(m.score_bas, 0, "le bas ne marque pas")
	assert_eq(m.palet_pos, Vector2(360, 640), "palet remis au centre après le but")
