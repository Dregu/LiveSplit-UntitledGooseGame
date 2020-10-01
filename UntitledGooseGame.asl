state("Untitled") {
	int honk : "UnityPlayer.dll", 0x1497D10, 0x9C0;
	int reset: "UnityPlayer.dll", 0x14B1800, 0x330, 0x480;
}

startup {
	vars.subGoalChecker = new Dictionary<string, List<string>>{};
	vars.subGoalCheckerClone = new Dictionary<string, List<string>>(); // Create a clone of the dictionary so it can be re-populated.
	var settingsCreator = new Dictionary<string, string> {
		{"splits-intro", "intro logo"},
		{"splits-page1", "to do (garden)"},
			{"page1-goalGarden", "get into the garden"},
			{"page1-goalWet", "get the groundskeeper wet"},
			{"page1-goalKeys", "steal the groundskeeper's keys"},
			{"page1-goalHat", "make the groundskeeper wear his sun hat"},
			{"page1-goalRake", "rake in the lake"},
			{"page1-goalPicnic", "have a picnic"},
				{"goalPicnic-subGoalSandwich", "bring a sandwich"},
				{"goalPicnic-subGoalApple", "bring an apple"},
				{"goalPicnic-subGoalPumpkin", "bring a pumpkin"},
				{"goalPicnic-subGoalCarrot", "bring a carrot"},
				{"goalPicnic-subGoalJam", "bring some jam"},
				{"goalPicnic-subGoalThermos", "bring a thermos"},
				{"goalPicnic-subGoalRadio", "bring a radio"},
				{"goalPicnic-subGoalBasket", "bring a basket"},
			{"page1-goalHammering", "make the groundskeeper hammer his thumb"},

		{"splits-page2", "to do (high street)"},
			{"page2-goalBroom", "break the broom"},
			{"page2-goalPhonebooth", "trap the boy in the phone booth"},
			{"page2-goalWrongGlasses", "make the boy wear the wrong glasses"},
			{"page2-goalBuyBack", "make someone buy back their own stuff"},
			{"page2-goalGetInShop", "get on t.v."},
			{"page2-goalShopping", "go shopping"},
				{"goalShopping-subGoalToothbrush", "buy a toothbrush"},
				{"goalShopping-subGoalToiletPaper", "buy some loo paper"},
				{"goalShopping-subGoalHairbrush", "buy a hairbrush"},
				{"goalShopping-subGoalTinCans", "buy some tinned food"},
				{"goalShopping-subGoalCleaners", "buy some cleaner"},
				{"goalShopping-subGoalFruitNVeg", "buy some fruit & veg"},
			{"page2-goalGarage", "trap the shopkeeper in the garage"},

		{"splits-page3", "to do (back gardens)"},
			{"page3-goalBreakVase", "make someone break the fancy vase"},
			{"page3-goalDressStatue", "help the woman dress up the bust"},
			{"page3-goalBell", "make the man spit out his tea"},
			{"page3-goalRibbon", "get dressed up with a ribbon"},
			{"page3-goalBarefoot", "make the man go barefoot"},
			{"page3-goalWashing", "do the washing"},
				{"goalWashing-subGoalBra", "with a bra"},
				{"goalWashing-subGoalSocks", "with a pair of socks"},
				{"goalWashing-subGoalSlippers", "with a slipper"},
				{"goalWashing-subGoalSoap", "with a bar of soap"},
			{"page3-goalPrune", "make someone prune the prize rose"},

		{"splits-page4", "to do (pub)"},
			{"page4-goalIntoPub", "get into the pub"},
			{"page4-goalOldMan1", "break the dartboard"},
			{"page4-goalBoat", "get the toy boat"},
			{"page4-goalOldMan2", "make the old man fall on his bum"},
			{"page4-goalFlower", "be awarded a flower"},
			{"page4-goalPintGlass", "steal a pint glass and drop it in the canal"},
			{"page4-goalSetTable", "set the table"},
				{"goalSetTable-subGoalKnife", "with a knife"},
				{"goalSetTable-subGoalFork", "with a fork"},
				{"goalSetTable-subGoalPlate", "with a plate"},
				{"goalSetTable-subGoalPepper", "with pepper"},
				{"goalSetTable-subGoalCandle", "with a candle"},
			{"page4-goalBucket", "drop a bucket on the burly man's head"},

		{"splits-page5", "to do (model village)"},
			{"page5-goalModelVillage", "get into the model village"},
			{"page5-goalStealBell", "steal the beautiful miniature golden bell"},
			{"page5-goalFinale", "...and take it all the way back home"},

		{"splits-page6", "to do (as well)"},
			{"page6-goalLockout", "lock the groundskeeper out of the garden"},
			{"page6-goalCabbage", "cabbage picnic"},
			{"page6-goalPuddle", "trip the boy in the puddle"},
			{"page6-goalScales", "make the shop scales go ding"},
			{"page6-goalUmbrella", "open an umbrella inside the tv shop"},
			{"page6-goalBuyBack2", "make someone from outside the high street buy back their own stuff"},
			{"page6-goalFlowers", "collect the five flowers"},
				{"goalFlowers-subGoalTulip", "tulip"},
				{"goalFlowers-subGoalLily", "lily"},
				{"goalFlowers-subGoalRose", "rose"},
				{"goalFlowers-subGoalDaisy", "daisy"},
				{"goalFlowers-subGoalFinaleFlower", "chrysanthemum"},

		{"splits-page7", "to do (as well)"},
			{"page7-goalWimpGarage", "trap the boy in the garage"},
			{"page7-goalCatch", "catch an object as it's thrown over the fence"},
			{"page7-goalThrownGoose", "get thrown over the fence"},
			{"page7-goalBust2", "dress up the bust with things from outside the back gardens"},
			{"page7-goalFootball", "score a goal"},
			{"page7-goalBoatBridge", "sail the toy boat under a bridge"},
			{"page7-goalPerformRibbon", "perform at the pub wearing a ribbon"},
			{"page7-goalOldManHat", "steal the old man's woolen hat"},

		{"splits-page8", "to do (quickly!!)"},
			{"page8-goalSpeedyGarden", "complete the garden to-do list before the church bells ring"},
			{"page8-goalSpeedyShops", "complete the high street to-do list before the church bells ring"},
			{"page8-goalSpeedyBackyards", "complete the back gardens to-do list before the church bells ring"},
			{"page8-goalSpeedyPub", "complete the pub to-do list before the church bells ring"},

		{"splits-page9", "to do (finally)"},
			{"page9-goal100", "cross out everything on the to-do list"},

		{"splits-subGoalCrown1", "put on the royal crown"},
		{"splits-subGoalCrown2", "put on the paper crown"}
	};

	settings.Add("splits", true, "Splitting on Finished Tasks");

	foreach (var setting in settingsCreator) {
		settings.Add(setting.Key.Split('-')[1], false, setting.Value, setting.Key.Split('-')[0]); // Add settings.
		if (setting.Key.Split('-')[1].StartsWith("subGoal"))									// Check if a subGoal has been recognized.
			if (vars.subGoalChecker.ContainsKey(setting.Key.Split('-')[0]))							// Check if a dictionary key with the goal's name exists.
				vars.subGoalChecker[setting.Key.Split('-')[0]].Add(setting.Key.Split('-')[1]);				// If true, add the subGoal to that goal's list.
			else														//
				vars.subGoalChecker.Add(setting.Key.Split('-')[0], new List<string>{setting.Key.Split('-')[1]});	// If false, create new dictionary key and add the subGoal.
	}
	
	foreach (var item in vars.subGoalChecker)
		vars.subGoalCheckerClone.Add(item.Key, item.Value); // Populate dictionary clone.

	settings.Add("reset", true, "Resetting the Timer");
		settings.Add("newfile", true, "when creating a new Save", "reset");
		settings.Add("restart", false, "after confirming Restart or Quit", "reset");
		settings.Add("mainmenu", false, "only after confirming Quit", "reset");

	settings.Add("pause", false, "Pausing the Timer (not allowed for speedruns)");
		settings.Add("loading", false, "while Loading", "pause");
		settings.Add("menu", false, "when opening the Menu", "pause");
		settings.Add("all", false, "while not playing", "pause");

	vars.timerReset = (LiveSplit.Model.Input.EventHandlerT<TimerPhase>)((s, e) => {
		vars.subGoalChecker.Clear();				// Completely clear dictionary.
		foreach (var item in vars.subGoalCheckerClone)		//
			vars.subGoalChecker.Add(item.Key, item.Value);	// Re-populate dictionary to start anew.
	});
	timer.OnReset += vars.timerReset;
}

init {
	string logPath = Environment.GetEnvironmentVariable("appdata") + "\\..\\LocalLow\\House House\\Untitled Goose Game\\output_log.txt";
	try {
		FileStream fs = new FileStream(logPath, FileMode.Open, FileAccess.Write, FileShare.ReadWrite);
		fs.SetLength(0);
		fs.Close();
	} catch {
		print(">>>>> Cannot open Goose log!");
	}

	vars.subGoalChecker.Clear();				// Completely clear dictionary.
	foreach (var item in vars.subGoalCheckerClone)		//
		vars.subGoalChecker.Add(item.Key, item.Value);	// Re-populate dictionary.
	vars.isPaused = false;
	vars.line = "";
	vars.reader = new StreamReader(new FileStream(logPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite));
	vars.lastSubGoal = "";

	vars.crownWatcher = new MemoryWatcherList();
	for (var i = 0; i <= 1; i++)
		vars.crownWatcher.Add(new MemoryWatcher<int>(new DeepPointer("UnityPlayer.dll", 0x154AC08, 0x8, 0x0, 0x30, 0x1F10 + i * 0x8, 0x118, 0x18, 0x20, 0x90)) { Name = "subGoalCrown" + (i + 1).ToString() });
}

exit {
	timer.IsGameTimePaused = true;
	vars.reader = null;
}

update {
	if (vars.reader == null) return false;
	vars.line = vars.reader.ReadLine();

	if (vars.line != null && (vars.line.StartsWith("Setting controller maps to UI Mode") || vars.line.StartsWith("unloading. game world active false")))
		vars.isPaused = true;
	else if (vars.line != null && (vars.line.StartsWith("Setting controller maps to Gameplay Mode") || vars.line.StartsWith("loading! game world active true")))
		vars.isPaused = false;

	
}

start {
	return old.honk == 16 && (current.honk == 17 || current.honk == 18);
}

reset {
	return vars.line != null && (settings["newfile"] && vars.line.StartsWith("savefile doesn't exist") || settings["restart"] && vars.line.StartsWith("unloading. game world active false")) ||
		settings["mainmenu"] && current.reset == 1;
}

split {
	if (vars.line != null && vars.line.StartsWith("saved due to goal")) {
		var goal = vars.line.Split(' ')[3];
		//print(">>>>> got " + goal);
		return settings[goal] && !settings[vars.lastSubGoal];
	}

	if (vars.line != null && vars.line.StartsWith("awarding: awardSubGoal-subGoal")) {
		var subGoal = vars.line.Split('-')[1];
		//print(">>>>> got " + subGoal);
		foreach (var goalList in vars.subGoalChecker) {
			if (goalList.Value.Contains(subGoal)) {				// Check if any items in the dictionary contain the subGoal.
				vars.lastSubGoal = subGoal;				// Set lastSubGoal, so a double split can't occur in the above logic.
				goalList.Value.Remove(subGoal);				// Remove that subGoal from the list (to circumvent duplicate splits).
				return settings[subGoal] && goalList.Value.Count != 0;	// Split if the setting has been selected and the list isn't empty (would otherwise split twice because of the normal goal).
			}
		}
	}

	vars.crownWatcher.UpdateAll(game);
	for (var i = 0; i <= 1; i++) {
		var crownID = "subGoalCrown" + (i + 1).ToString();
		if (vars.crownWatcher[crownID].Changed && vars.crownWatcher[crownID].Current != 0 && settings[crownID] && vars.subGoalChecker["splits"].Contains(crownID)) {
			vars.subGoalChecker["splits"].Remove(crownID);
			return true;
		}
	}

	return settings["intro"] && vars.line != null && vars.line.StartsWith("begining intro title sequence");
}

isLoading {
	if (settings["loading"] && !settings["all"]) {
		return
			vars.isPaused ||
			current.honk == 0 ||
			current.honk == 13;
	} else if (settings["menu"] && !settings["all"]) {
		return
			vars.isPaused;
	} else if (settings["all"]) {
		return
			vars.isPaused ||
			current.reset == 0 ||
			current.reset == 1 ||
			current.honk  == 0 ||
			current.honk  == 13 ||
			current.honk  == 16;
	}
}

shutdown {
	timer.OnReset -= vars.timerReset;
}
