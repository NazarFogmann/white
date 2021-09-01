/obj/item/clothing/mask/muzzle
	name = "кляп"
	desc = "Чтобы прекратить этот мерзкий звук."
	icon_state = "muzzle"
	inhand_icon_state = "blindfold"
	flags_cover = MASKCOVERSMOUTH
	w_class = WEIGHT_CLASS_SMALL
	gas_transfer_coefficient = 0.9
	equip_delay_other = 20

/obj/item/clothing/mask/muzzle/attack_paw(mob/user)
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if(src == C.wear_mask)
			to_chat(user, span_warning("Мне понадобиться помощь для того чтобы это снять!") )
			return
	..()

/obj/item/clothing/mask/surgical
	name = "стерильная маска"
	desc = "Стерильная маска создана для предотвращения распространения болезней."
	icon_state = "sterile"
	inhand_icon_state = "sterile"
	w_class = WEIGHT_CLASS_TINY
	flags_inv = HIDEFACE|HIDESNOUT
	flags_cover = MASKCOVERSMOUTH
	visor_flags_inv = HIDEFACE|HIDESNOUT
	visor_flags_cover = MASKCOVERSMOUTH
	gas_transfer_coefficient = 0.9
	permeability_coefficient = 0.01
	armor = list(MELEE = 0, BULLET = 0, LASER = 0,ENERGY = 0, BOMB = 0, BIO = 25, RAD = 0, FIRE = 0, ACID = 0)
	actions_types = list(/datum/action/item_action/adjust)

/obj/item/clothing/mask/surgical/attack_self(mob/user)
	adjustmask(user)

/obj/item/clothing/mask/fakemoustache
	name = "фальшивые усы"
	desc = "Внимание: усы фальшивые."
	icon_state = "fake-moustache"
	flags_inv = HIDEFACE
	species_exception = list(/datum/species/golem)

/obj/item/clothing/mask/fakemoustache/italian
	name = "итальянские усы"
	desc = "Сделаны из настоящих итальянских усов. Передает носителю дикое желание сильно жестикулировать."
	modifies_speech = TRUE

/obj/item/clothing/mask/fakemoustache/italian/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = " [message]"
		var/list/italian_words = strings("italian_replacement.json", "italian")

		for(var/key in italian_words)
			var/value = italian_words[key]
			if(islist(value))
				value = pick(value)

			message = replacetextEx(message, " [uppertext(key)]", " [uppertext(value)]")
			message = replacetextEx(message, " [capitalize(key)]", " [capitalize(value)]")
			message = replacetextEx(message, " [key]", " [value]")

		if(prob(3))
			message += pick(" Ravioli, ravioli, give me the formuoli!"," Mamma-mia!"," Mamma-mia! That's a spicy meat-ball!", " La la la la la funiculi funicula!")
	speech_args[SPEECH_MESSAGE] = trim(message)

/obj/item/clothing/mask/joy
	name = "маска радости"
	desc = "Выразите своё счастье или скройте печали с этой маской смеющегося лица с вырезанными на нём слезами радости."
	icon_state = "joy"
	flags_inv = HIDESNOUT

/obj/item/clothing/mask/bandana
	name = "бандана ботаника"
	desc = "Отличная бандана с нанотехнологичной подкладкой и узором гидропоники."
	w_class = WEIGHT_CLASS_TINY
	flags_cover = MASKCOVERSMOUTH
	flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_inv = HIDEFACE|HIDEFACIALHAIR|HIDESNOUT
	visor_flags_cover = MASKCOVERSMOUTH | PEPPERPROOF
	slot_flags = ITEM_SLOT_MASK
	adjusted_flags = ITEM_SLOT_HEAD
	icon_state = "bandbotany"
	species_exception = list(/datum/species/golem)

/obj/item/clothing/mask/bandana/attack_self(mob/user)
	adjustmask(user)

/obj/item/clothing/mask/bandana/AltClick(mob/user)
	. = ..()
	if(iscarbon(user))
		var/mob/living/carbon/C = user
		if((C.get_item_by_slot(ITEM_SLOT_HEAD == src)) || (C.get_item_by_slot(ITEM_SLOT_MASK) == src))
			to_chat(user, span_warning("Ты не можешь завязать [src] пока носишь его!") )
			return
	if(slot_flags & ITEM_SLOT_HEAD)
		to_chat(user, span_warning("You must undo [src] before you can tie it into a neckerchief!") )
	else
		if(user.is_holding(src))
			var/obj/item/clothing/neck/neckerchief/nk = new(src)
			nk.name = "[name] neckerchief"
			nk.desc = "[desc] It's tied up like a neckerchief."
			nk.icon_state = icon_state
			nk.worn_icon = 'icons/misc/hidden.dmi' //hide underlying neckerchief object while it applies its own mutable appearance
			nk.sourceBandanaType = src.type
			var/currentHandIndex = user.get_held_index_of_item(src)
			user.transferItemToLoc(src, null)
			user.put_in_hand(nk, currentHandIndex)
			user.visible_message(span_notice("You tie [src] up like a neckerchief.") , span_notice("[user] ties [src] up like a neckerchief.") )
			qdel(src)
		else
			to_chat(user, span_warning("You must be holding [src] in order to tie it!") )

/obj/item/clothing/mask/bandana/red
	name = "красная бандана"
	desc = "Неплохая красная бандана с нанотехнологичной подкладкой."
	icon_state = "bandred"

/obj/item/clothing/mask/bandana/blue
	name = "синяя бандана"
	desc = "Неплохая синяя бандана с нанотехнологичной подкладкой."
	icon_state = "bandblue"

/obj/item/clothing/mask/bandana/green
	name = "зелёная бандана"
	desc = "Неплохая зеленая бандана с нанотехнологичной подкладкой."
	icon_state = "bandgreen"

/obj/item/clothing/mask/bandana/gold
	name = "золотая бандана"
	desc = "Неплохая золотая бандана с нанотехнологичной подкладкой."
	icon_state = "bandgold"

/obj/item/clothing/mask/bandana/black
	name = "черная бандана"
	desc = "Неплохая черная бандана с нанотехнологичной подкладкой."
	icon_state = "bandblack"

/obj/item/clothing/mask/bandana/skull
	name = "бандана с черепом"
	desc = "Неплохая бандана с нанотехнологичной подкладкой и рисунком черепа."
	icon_state = "bandskull"

/obj/item/clothing/mask/bandana/durathread
	name = "дюратканевая бандана"
	desc =  "Бандана из дюраткани, вы хотели бы чтобы она предоставляла хоть какую-то защиту, но она слишком тонкая..."
	icon_state = "banddurathread"

/obj/item/clothing/mask/mummy
	name = "маска мумии"
	desc = "Древние бинты."
	icon_state = "mummy_mask"
	inhand_icon_state = "mummy_mask"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/mask/scarecrow
	name = "маска из мешка"
	desc = "Мешок из мешковины с прорезями для глаз."
	icon_state = "scarecrow_sack"
	inhand_icon_state = "scarecrow_sack"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT

/obj/item/clothing/mask/gondola
	name = "Маска гондолы"
	desc = "Из настоящего гондольего меха "
	icon_state = "gondola"
	inhand_icon_state = "gondola"
	flags_inv = HIDEFACE|HIDEHAIR|HIDEFACIALHAIR|HIDESNOUT
	w_class = WEIGHT_CLASS_SMALL
	modifies_speech = TRUE

/obj/item/clothing/mask/gondola/handle_speech(datum/source, list/speech_args)
	var/message = speech_args[SPEECH_MESSAGE]
	if(message[1] != "*")
		message = " [message]"
		var/list/spurdo_words = strings("spurdo_replacement.json", "spurdo")
		for(var/key in spurdo_words)
			var/value = spurdo_words[key]
			if(islist(value))
				value = pick(value)
			message = replacetextEx(message,regex(uppertext(key),"g"), "[uppertext(value)]")
			message = replacetextEx(message,regex(capitalize(key),"g"), "[capitalize(value)]")
			message = replacetextEx(message,regex(key,"g"), "[value]")
	speech_args[SPEECH_MESSAGE] = trim(message)
