/obj/machinery/computer/shuttle/unit_shuttle
	name = "unit shuttle console"
	desc = "Used to control the unit shuttle."
	circuit = /obj/item/circuitboard/computer/unit_shuttle
	shuttleId = "podunit"
	possible_destinations = "space_station;planet_station;"
	no_destination_swap = TRUE

/obj/item/circuitboard/computer/unit_shuttle
	name = "Unit Shuttle (Computer Board)"
	icon_state = "generic"
	build_path = /obj/machinery/computer/shuttle/unit_shuttle

/datum/map_template/shuttle/escape_pod/unit
	suffix = "unit"
	name = "transport pod (Unit)"

/datum/map_template/shuttle/arrival/unit
	suffix = "unit"
	name = "arrival shuttle (Unit)"

/turf/open/space/basic/planet
	name = "открытое пространство"
	icon = 'code/shitcode/valtos/icons/cliffs.dmi'
	icon_state = "void"
	baseturfs = /turf/open/space/basic/planet
	flags_1 = NOJAUNT_1
	explosion_block = INFINITY

/turf/open/space/basic/planet/cliffs
	name = "обрыв"
	icon_state = "cliff1"
	plane = FLOOR_PLANE

/turf/open/space/basic/planet/cliffs/Initialize()
	aaaa = icon_state
	. = ..()
	icon_state = aaaa

/area/centcom/outdoors/Initialize()
	. = ..()
	icon = 'code/shitcode/valtos/icons/cliffs.dmi'
	icon_state = "snow_storm"

/turf/open/space/basic/planet/Entered(atom/movable/AM, atom/OldLoc)
	..()
	if(!locate(/obj/structure/lattice) in src)
		throw_atom(AM)

/turf/open/space/basic/planet/proc/throw_atom(atom/movable/AM)
	set waitfor = FALSE
	if(!AM || istype(AM, /obj/docking_port))
		return
	if(AM.loc != src)
		return
	var/max = world.maxx-TRANSITIONEDGE
	var/min = 1+TRANSITIONEDGE

	var/_z = 4 // всё летит в планету нахуй
	var/_x = rand(min,max)
	var/_y = rand(min,max)

	var/turf/T = locate(_x, _y, _z)
	if(isliving(AM))
		var/mob/living/M = AM
		M.apply_damage(rand(100, 200), BRUTE)
		M.Paralyze(120)
		to_chat(M, "<big>БЛЯТЬ!</big>")
	AM.forceMove(T)
