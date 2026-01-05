local beacon = data.raw["beacon"]["rabbasca-energy-consumer-big"]
if not beacon then return end
beacon.quality_affects_module_slots = false
beacon.module_slots = 0