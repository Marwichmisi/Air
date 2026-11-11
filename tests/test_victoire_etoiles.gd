@tool
extends McpTestSuite
## Ticket #31 — la partie s'arrête à 7 buts, sans chrono.
## Tranche 1 : premier camp à 7 gagne (module seul, sans écran).

const Match := preload("res://scripts/match.gd")


func suite_name() -> String:
	return "victoire"


func _marquer_bas(m, fois: int) -> void:
	for i in fois:
		m.palet_pos = Vector2(360, 1275)
		m.palet_vel = Vector2(0, 20)
		m.step()


func _marquer_haut(m, fois: int) -> void:
	for i in fois:
		m.palet_pos = Vector2(360, 5)
		m.palet_vel = Vector2(0, -20)
		m.step()


func test_pas_de_gagnant_avant_7() -> void:
	var m = Match.new()
	_marquer_bas(m, 6)
	_marquer_haut(m, 6)
	assert_false(m.termine(), "6-6 : la partie continue")
	assert_eq(m.gagnant(), "", "aucun gagnant avant 7")


func test_premier_a_7_bas_gagne() -> void:
	var m = Match.new()
	_marquer_haut(m, 4)
	_marquer_bas(m, 7)
	assert_true(m.termine(), "7-4 : la partie est terminée")
	assert_eq(m.gagnant(), "bas", "le bas gagne à 7")


func test_premier_a_7_haut_gagne() -> void:
	var m = Match.new()
	_marquer_bas(m, 2)
	_marquer_haut(m, 7)
	assert_true(m.termine(), "2-7 : la partie est terminée")
	assert_eq(m.gagnant(), "haut", "le haut gagne à 7")


func test_etoile_7_6() -> void:
	var m = Match.new()
	_marquer_haut(m, 6)
	_marquer_bas(m, 7)
	assert_eq(m.etoiles(), 1, "7-6 : 1 étoile")


func test_etoile_7_5() -> void:
	var m = Match.new()
	_marquer_haut(m, 5)
	_marquer_bas(m, 7)
	assert_eq(m.etoiles(), 2, "7-5 : 2 étoiles")


func test_etoile_ecart_large() -> void:
	var m = Match.new()
	_marquer_haut(m, 4)
	_marquer_bas(m, 7)
	assert_eq(m.etoiles(), 3, "7-4 : 3 étoiles")
	var m2 = Match.new()
	_marquer_bas(m2, 7)
	assert_eq(m2.etoiles(), 3, "7-0 : 3 étoiles")


func test_defaite_zero_etoile() -> void:
	var m = Match.new()
	_marquer_bas(m, 6)
	_marquer_haut(m, 7)
	assert_eq(m.etoiles(), 0, "6-7 : 0 étoile en défaite")


func test_partie_en_cours_zero_etoile() -> void:
	var m = Match.new()
	_marquer_bas(m, 3)
	_marquer_haut(m, 2)
	assert_eq(m.etoiles(), 0, "3-2 : 0 étoile tant que personne n'a 7")


func test_recommencer_remet_a_zero() -> void:
	var m = Match.new()
	_marquer_haut(m, 4)
	_marquer_bas(m, 7)
	assert_true(m.termine(), "pré-condition : 7-4 terminé")
	m.prix_continuer = 5000
	m.recommencer()
	assert_eq(m.score_bas, 0, "score bas à 0 après recommencer")
	assert_eq(m.score_haut, 0, "score haut à 0 après recommencer")
	assert_eq(m.palet_pos, Vector2(360, 640), "palet au centre après recommencer")
	assert_eq(m.maillet_bas_pos, Vector2(360, 320), "maillet bas replacé")
	assert_eq(m.maillet_haut_pos, Vector2(360, 960), "maillet haut replacé")
	assert_eq(m.prix_continuer, 1000, "prix du continuer ramené à 1000")
	assert_false(m.termine(), "la partie repartie n'est pas terminée")
	assert_eq(m.gagnant(), "", "plus de gagnant après recommencer")
