class_name TableMatch
extends RefCounted
## Ticket #30 — module match, seul seam de la copie (spec #29).
##
## Coordonnées monde de la spec (physique.md) : pixels, axe y vers le haut.
## La scène convertit écran <-> monde (y_écran = 1280 - y_monde).
## Un pas = 0,016 s. Pas de moteur physique : intégration explicite.

const PAS := 0.016
const PX_PAR_M := 32.0
const M_PAR_PX := 0.03125

const RAYON_PALET := 30.0
const RAYON_MAILLET := 60.0
const REBOND_PALET := 0.85
const MASSE_PALET := 2.761
const MASSE_MAILLET := 331.34

# Ressort du doigt (mode 10000 Hz, ticket #30) : force max = masse x 20000 N.
const FORCE_RESSORT_MAX := MASSE_MAILLET * 20000.0
const ACCEL_MAX := FORCE_RESSORT_MAX / MASSE_MAILLET # = 20000 m/s²

const DOIGT_MIN := Vector2(90, 100)
const DOIGT_MAX := Vector2(630, 1180)
const DOIGT_LIMITE_HAUT := 650.0 # au-dessus : geste refusé (maillet bas)
const LIGNE_MILIEU := 640.0

const PALET_0 := Vector2(360, 640)
const MAILLET_BAS_0 := Vector2(360, 320)
const MAILLET_HAUT_0 := Vector2(360, 960)

const FACE_GAUCHE := 30.0
const FACE_DROITE := 690.0

## Ticket #31 — premier camp à 7 buts gagne, pas de chrono (regles.md).
const BUTS_POUR_GAGNER := 7

var score_bas := 0
var score_haut := 0
var palet_pos := PALET_0
var palet_vel := Vector2.ZERO # m/s, repère monde
var maillet_bas_pos := MAILLET_BAS_0
var maillet_bas_vel := Vector2.ZERO # m/s, repère monde
var maillet_haut_pos := MAILLET_HAUT_0

var _cible_doigt := MAILLET_BAS_0
var _doigt_pose := false

## Ticket #31 — prix du « continuer » (regles.md §Continuer) : 1 000
## puis +1 000 jusqu'à 9 000 dans la même partie ; recommencer le ramène
## à 1 000. Les objets/boucliers n'ont pas encore d'état : les annuler
## est pour l'instant vide, les boutons relèvent de l'écran.
var prix_continuer := 1000


func _init() -> void:
	coup_denvoi()


func coup_denvoi() -> void:
	score_bas = 0
	score_haut = 0
	_replacer()


## Ticket #31 — même effet qu'un rejouer de l'écran de résultat
## (regles.md §Recommencer) : scores à 0, prix à 1 000, maillets et
## palet replacés, puis le même coup d'envoi.
func recommencer() -> void:
	prix_continuer = 1000
	coup_denvoi()


## Ticket #31 — la partie est terminée dès qu'un camp atteint 7 buts.
func termine() -> bool:
	return score_bas >= BUTS_POUR_GAGNER or score_haut >= BUTS_POUR_GAGNER


## Ticket #31 — "bas", "haut", ou "" si personne n'a 7.
func gagnant() -> String:
	if score_bas >= BUTS_POUR_GAGNER:
		return "bas"
	if score_haut >= BUTS_POUR_GAGNER:
		return "haut"
	return ""


## Ticket #31 — étoiles de stage depuis l'écart (regles.md §Stage).
## Le bas est le camp du joueur : 7-6 → 1, 7-5 → 2, écart ≥ 3 → 3,
## défaite ou partie en cours → 0.
func etoiles() -> int:
	if score_bas < BUTS_POUR_GAGNER:
		return 0
	var ecart := score_bas - score_haut
	if ecart <= 1:
		return 1
	if ecart == 2:
		return 2
	return 3


func set_doigt_bas(p: Vector2) -> void:
	if p.y > DOIGT_LIMITE_HAUT:
		return
	_cible_doigt = Vector2(
		clampf(p.x, DOIGT_MIN.x, DOIGT_MAX.x),
		clampf(p.y, DOIGT_MIN.y, DOIGT_MAX.y)
	)
	_doigt_pose = true


func lever_doigt() -> void:
	# L'articulation reste sur la dernière cible (physique.md).
	_doigt_pose = false


func step() -> void:
	_step_maillet_bas()
	if _step_palet():
		_step_buts()


func _replacer() -> void:
	palet_pos = PALET_0
	palet_vel = Vector2.ZERO
	maillet_bas_pos = MAILLET_BAS_0
	maillet_bas_vel = Vector2.ZERO
	maillet_haut_pos = MAILLET_HAUT_0
	_cible_doigt = MAILLET_BAS_0
	_doigt_pose = false


func _step_maillet_bas() -> void:
	if not _doigt_pose:
		maillet_bas_vel = Vector2.ZERO
		return
	var ecart_m := (_cible_doigt - maillet_bas_pos) * M_PAR_PX
	var v_demandee := ecart_m / PAS
	var v_max := ACCEL_MAX * PAS
	if v_demandee.length() > v_max:
		v_demandee = v_demandee.normalized() * v_max
	maillet_bas_vel = v_demandee
	maillet_bas_pos += maillet_bas_vel * PAS * PX_PAR_M
	# Le maillet bas ne franchit pas la ligne du milieu (ticket #30).
	maillet_bas_pos.x = clampf(maillet_bas_pos.x, RAYON_MAILLET, 720.0 - RAYON_MAILLET)
	maillet_bas_pos.y = clampf(maillet_bas_pos.y, RAYON_MAILLET, LIGNE_MILIEU)


func _step_palet() -> bool:
	palet_pos += palet_vel * PAS * PX_PAR_M
	_rebond_mur()
	_rebond_maillet(maillet_bas_pos, maillet_bas_vel)
	_rebond_maillet(maillet_haut_pos, Vector2.ZERO)
	return true


func _rebond_mur() -> void:
	if palet_pos.x - RAYON_PALET < FACE_GAUCHE:
		palet_pos.x = FACE_GAUCHE + RAYON_PALET
		palet_vel.x = -palet_vel.x * REBOND_PALET
	elif palet_pos.x + RAYON_PALET > FACE_DROITE:
		palet_pos.x = FACE_DROITE - RAYON_PALET
		palet_vel.x = -palet_vel.x * REBOND_PALET


func _rebond_maillet(centre: Vector2, vitesse: Vector2) -> void:
	var ecart := palet_pos - centre
	var distance := ecart.length()
	var contact := RAYON_PALET + RAYON_MAILLET
	if distance >= contact:
		return
	var normale := Vector2.UP
	if distance > 0.0001:
		normale = ecart / distance
	palet_pos = centre + normale * contact
	var vn := (palet_vel - vitesse).dot(normale)
	if vn < 0.0:
		palet_vel -= (1.0 + REBOND_PALET) * vn * normale


func _step_buts() -> void:
	# Bornes strictes : y = 0 et y = 1280 ne sont pas des buts.
	if palet_pos.y > 1280.0:
		score_bas += 1
		_replacer()
	elif palet_pos.y < 0.0:
		score_haut += 1
		_replacer()
