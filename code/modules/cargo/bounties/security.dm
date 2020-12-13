/datum/bounty/item/security/riotshotgun
	name = "Штурмовой дробовик"
	description = "Хулиганы взошли на борт ЦК! Быстрее отправьте дробовики, иначе всё станет еще хуже."
	reward = CARGO_CRATE_VALUE * 10
	required_count = 2
	wanted_types = list(/obj/item/gun/ballistic/shotgun/riot)

/datum/bounty/item/security/recharger
	name = "Зарядные устройства"
	description = "Военная академия НТ проводит стрелковые учения. Они требуют, чтобы зарядные устройства были отправлены."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 3
	wanted_types = list(/obj/machinery/recharger)

/datum/bounty/item/security/pepperspray
	name = "Перцовый балончик"
	description = "У нас было много беспорядков на космической станции 76. Нам бы не помешали новые перцовые баллончики."
	reward = CARGO_CRATE_VALUE * 6
	required_count = 4
	wanted_types = list(/obj/item/reagent_containers/spray/pepper)

/datum/bounty/item/security/prison_clothes
	name = "Тюремная форма"
	description = "ТерраГов не смогли получить новую форму для заключенных, поэтому, если у вас есть запасная форма, мы её заберем."
	reward = CARGO_CRATE_VALUE * 4
	required_count = 4
	wanted_types = list(/obj/item/clothing/under/rank/prisoner)

/datum/bounty/item/security/plates
	name = "Номерные знаки"
	description = "В результате автокатастрофы с участием клоуна мы могли бы использовать аванс на некоторые из номерных знаков вашего заключенного."
	reward = CARGO_CRATE_VALUE * 2
	required_count = 10
	wanted_types = list(/obj/item/stack/license_plates/filled)

/datum/bounty/item/security/earmuffs
	name = "Наушники"
	description = "Центральное Командование устало от сообщений вашей станции. Они приказали вам отправить наушники, чтобы уменьшить раздражение."
	reward = CARGO_CRATE_VALUE * 2
	wanted_types = list(/obj/item/clothing/ears/earmuffs)

/datum/bounty/item/security/handcuffs
	name = "Наручники"
	description = "В Центральное Командование прибыл большой поток беглых заключенных. Сейчас идеальное время для отправки запасных наручников (или удерживающих устройств)."
	reward = CARGO_CRATE_VALUE * 2
	required_count = 5
	wanted_types = list(/obj/item/restraints/handcuffs)
