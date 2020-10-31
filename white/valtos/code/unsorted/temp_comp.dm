PROCESSING_SUBSYSTEM_DEF(realtemp)
	name = "Real Temperature"
	priority = 10
	flags = SS_NO_INIT
	wait = 100

/area
	var/env_temp_relative = 20

/area/awaymission/chilly
	env_temp_relative = -20

/area/awaymission/chilly/Entered(atom/movable/M, oldloc)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		H.AddComponent(/datum/component/realtemp)

/area/awaymission/chilly/Exited(atom/movable/M)
	. = ..()
	if(ishuman(M))
		var/mob/living/carbon/human/H = M
		qdel(H.GetComponent(/datum/component/realtemp))

/datum/component/realtemp
	var/mob/living/carbon/human/owner
	var/body_temp_alt = 30
	var/obj/screen/relative_temp/screen_obj
	var/list/text_temp_sources = list()

/datum/component/realtemp/Initialize()
	if(ishuman(parent))
		START_PROCESSING(SSrealtemp, src)
		owner = parent

		var/datum/hud/hud = owner.hud_used
		screen_obj = new
		screen_obj.hud = src
		hud.infodisplay += screen_obj
		RegisterSignal(screen_obj, COMSIG_CLICK, .proc/hud_click)

/datum/component/realtemp/Destroy()

	var/datum/hud/hud = owner.hud_used
	if(hud?.infodisplay)
		hud.infodisplay -= screen_obj
	QDEL_NULL(screen_obj)

	STOP_PROCESSING(SSrealtemp, src)
	owner = null
	return ..()

/datum/component/realtemp/proc/adjust_temp(amt)
	if(body_temp_alt <= 0)
		body_temp_alt = 0
	if(body_temp_alt <= 50)
		body_temp_alt += amt
		update_temp_icon(amt)
	else
		update_temp_icon(0)

/datum/component/realtemp/proc/update_temp_icon(amt)
	if(!(owner.client || owner.hud_used))
		return

	screen_obj.cut_overlays()

	switch(amt)
		if(-INFINITY to -2)
			screen_obj.add_overlay("temp_ov_1")
		if(-1)
			screen_obj.add_overlay("temp_ov_2")
		if(0)
			screen_obj.add_overlay("temp_ov_3")
		if(1)
			screen_obj.add_overlay("temp_ov_4")
		if(2 to INFINITY)
			screen_obj.add_overlay("temp_ov_5")

	switch(body_temp_alt)
		if(-INFINITY to 0)
			screen_obj.icon_state = "temp_0"
		if(1 to 10)
			screen_obj.icon_state = "temp_1"
		if(11 to 20)
			screen_obj.icon_state = "temp_2"
		if(21 to 30)
			screen_obj.icon_state = "temp_3"
		if(31 to 40)
			screen_obj.icon_state = "temp_4"
		if(41 to INFINITY)
			screen_obj.icon_state = "temp_5"

/datum/component/realtemp/process()

	if(owner.stat == DEAD)
		STOP_PROCESSING(SSrealtemp, src)
		return

	var/area/AR = get_area(owner)
	var/list/temp_sources = list()
	var/temp_to_adjust = 0

	switch(body_temp_alt)
		if(-INFINITY to 0)
			owner.Jitter(15)
			owner.adjustStaminaLoss(10)
			if(prob(25))
				owner.adjustFireLoss(5)
				to_chat(owner, pick("<span class='notice'>Замерзаю...</span>", "<span class='notice'>Холодно...</span>", "<span class='notice'>Мне нужно срочно согреться...</span>"))
		if(1 to 20)
			owner.Jitter(10)
			owner.adjustStaminaLoss(5)
		if(21 to 40)
			owner.Jitter(5)
			owner.adjustStaminaLoss(1)


	switch(AR.env_temp_relative)
		if(-INFINITY to -91)
			temp_to_adjust += -5
		if(-90 to -36)
			temp_to_adjust += -4
		if(-35 to -22)
			temp_to_adjust += -3
		if(-21 to -15)
			temp_to_adjust += -2
		if(-14 to 4)
			temp_to_adjust += -1
		if(5 to INFINITY)
			temp_sources += "Здесь тепло!"
			temp_to_adjust += 1

	switch(owner.get_cold_protection(AR.env_temp_relative))
		if(0.20 to 0.30)
			temp_sources += "Подходящая одежда уберегает меня от холода."
			temp_to_adjust += 1
		if(0.31 to 0.50)
			temp_sources += "Эта одежда не даст мне замёрзнуть."
			temp_to_adjust += 2
		if(0.51 to 0.75)
			temp_sources += "Эта одежда способна не дать мне замёрзнуть точно."
			temp_to_adjust += 3
		if(0.76 to 1)
			temp_sources += "В этой одежде мне не страшен холод."
			temp_to_adjust += 5

	for(var/obj/structure/heat_source in view(3, owner))
		if(istype(heat_source, /obj/structure/bonfire))
			var/obj/structure/bonfire/B = heat_source
			if(B.burning)
				temp_sources += "Костёр согревает меня."
				temp_to_adjust += 2
		if(istype(heat_source, /obj/structure/fireplace))
			var/obj/structure/fireplace/F = heat_source
			if(F.lit)
				temp_sources += "Камин согревает меня."
				temp_to_adjust += 2

	adjust_temp(temp_to_adjust)
	text_temp_sources = temp_sources

/obj/screen/relative_temp
	name = "температура тела"
	icon = 'white/valtos/icons/temp_hud.dmi'
	icon_state = "temp_5"
	screen_loc = ui_relative_temp

/datum/component/realtemp/proc/hud_click(datum/source, location, control, params, mob/user)
	SIGNAL_HANDLER

	if(user != parent)
		return
	print_temp(user)

/datum/component/realtemp/proc/print_temp(mob/user)
	var/msg = "<span class='info'>Мои ощущения температуры:</span>\n"
	for(var/i in text_temp_sources)
		msg += "<span class='notice'>[i]</span>\n"
	to_chat(user, "<div class='examine_block'>[msg]</div>")
