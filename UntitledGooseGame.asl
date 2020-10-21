state("Untitled") {
	int honk  : "UnityPlayer.dll", 0x1497D10, 0x9C0;
	int reset : "UnityPlayer.dll", 0x14B1800, 0x330, 0x480;
}

startup {
	var tB = (Func<string, string, string, Tuple<string, string, string>>) ((elmt1, elmt2, elmt3) => { return Tuple.Create(elmt1, elmt2, elmt3); });
	var sB = new List<Tuple<string, string, string>> {
		tB("splits", "intro", "intro logo"),
		tB("splits", "page1", "to do (garden)"),
			tB("page1", "goalGarden", "get into the garden"),
			tB("page1", "goalWet", "get the groundskeeper wet"),
			tB("page1", "goalKeys", "steal the groundskeeper's keys"),
			tB("page1", "goalHat", "make the groundskeeper wear his sun hat"),
			tB("page1", "goalRake", "rake in the lake"),
			tB("page1", "goalPicnic", "have a picnic"),
			tB("page1", "goalHammering", "make the groundskeeper hammer his thumb"),

		tB("splits", "page2", "to do (high street)"),
			tB("page2", "goalBroom", "break the broom"),
			tB("page2", "goalPhonebooth", "trap the boy in the phone booth"),
			tB("page2", "goalWrongGlasses", "make the boy wear the wrong glasses"),
			tB("page2", "goalBuyBack", "make someone buy back their own stuff"),
			tB("page2", "goalGetInShop", "get on t.v."),
			tB("page2", "goalShopping", "go shopping"),
			tB("page2", "goalGarage", "trap the shopkeeper in the garage"),

		tB("splits", "page3", "to do (back gardens)"),
			tB("page3", "goalBreakVase", "make someone break the fancy vase"),
			tB("page3", "goalDressStatue", "help the woman dress up the bust"),
			tB("page3", "goalBell", "make the man spit out his tea"),
			tB("page3", "goalRibbon", "get dressed up with a ribbon"),
			tB("page3", "goalBarefoot", "make the man go barefoot"),
			tB("page3", "goalWashing", "do the washing"),
			tB("page3", "goalPrune", "make someone prune the prize rose"),

		tB("splits", "page4", "to do (pub)"),
			tB("page4", "goalIntoPub", "get into the pub"),
			tB("page4", "goalOldMan1", "break the dartboard"),
			tB("page4", "goalBoat", "get the toy boat"),
			tB("page4", "goalOldMan2", "make the old man fall on his bum"),
			tB("page4", "goalFlower", "be awarded a flower"),
			tB("page4", "goalPintGlass", "steal a pint glass and drop it in the canal"),
			tB("page4", "goalSetTable", "set the table"),
			tB("page4", "goalBucket", "drop a bucket on the burly man's head"),

		tB("splits", "page5", "to do (model village)"),
			tB("page5", "goalModelVillage", "get into the model village"),
			tB("page5", "goalStealBell", "steal the beautiful miniature golden bell"),
			tB("page5", "goalFinale", "...and take it all the way back home"),

		tB("splits", "page6", "to do (as well)"),
			tB("page6", "goalLockout", "lock the groundskeeper out of the garden"),
			tB("page6", "goalCabbage", "cabbage picnic"),
			tB("page6", "goalPuddle", "trip the boy in the puddle"),
			tB("page6", "goalScales", "make the shop scales go ding"),
			tB("page6", "goalUmbrella", "open an umbrella inside the tv shop"),
			tB("page6", "goalBuyBack2", "make someone from outside the high street buy back their own stuff"),
			tB("page6", "goalFlowers", "collect the five flowers"),

		tB("splits", "page7", "to do (as well)"),
			tB("page7", "goalWimpGarage", "trap the boy in the garage"),
			tB("page7", "goalCatch", "catch an object as it's thrown over the fence"),
			tB("page7", "goalThrownGoose", "get thrown over the fence"),
			tB("page7", "goalBust2", "dress up the bust with things from outside the back gardens"),
			tB("page7", "goalFootball", "score a goal"),
			tB("page7", "goalBoatBridge", "sail the toy boat under a bridge"),
			tB("page7", "goalPerformRibbon", "perform at the pub wearing a ribbon"),
			tB("page7", "goalOldManHat", "steal the old man's woolen hat"),

		tB("splits", "page8", "to do (quickly!!)"),
			tB("page8", "goalSpeedyGarden", "complete the garden to-do list before the church bells ring"),
			tB("page8", "goalSpeedyShops", "complete the high street to-do list before the church bells ring"),
			tB("page8", "goalSpeedyBackyards", "complete the back gardens to-do list before the church bells ring"),
			tB("page8", "goalSpeedyPub", "complete the pub to-do list before the church bells ring"),

		tB("splits", "page9", "to do (finally)"),
			tB("page9", "goal100", "cross out everything on the to-do list"),

		tB("splits", "c0", "put on the royal crown"),
		tB("splits", "c1", "put on the paper crown")
	};

	settings.Add("splits", true, "Splitting on Finished Tasks");

	foreach (var s in sB) settings.Add(s.Item2, false, s.Item3, s.Item1 );

	settings.Add("reset", true, "Resetting the Timer");
		settings.Add("newfile", true, "when creating a new Save", "reset");
		settings.Add("restart", false, "after confirming Restart or Quit", "reset");
		settings.Add("mainmenu", false, "only after confirming Quit", "reset");

	settings.Add("pause", false, "Pausing the Timer (not allowed for speedruns)");
		settings.Add("loading", false, "while Loading", "pause");
		settings.Add("menu", false, "when opening the Menu", "pause");
		settings.Add("all", false, "while not playing", "pause");
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

	vars.isPaused = false;
	vars.line = "";
	vars.reader = new StreamReader(new FileStream(logPath, FileMode.Open, FileAccess.Read, FileShare.ReadWrite));
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
	return
		vars.line != null && (settings["newfile"] && vars.line.StartsWith("savefile doesn't exist") || settings["restart"] && vars.line.StartsWith("unloading. game world active false")) ||
		settings["mainmenu"] && current.reset == 1;
}

split {
	if (vars.line != null)
		if (vars.line.StartsWith("begining intro title sequence"))
			return settings["intro"];
		else if (vars.line.StartsWith("saved due to goal")) {
			var goal = vars.line.Split(' ')[3];
			//print(">>>>> got " + goal);
			return settings[goal] && !settings[vars.lastSubGoal];
		}
}

isLoading {
	if (settings["loading"] && !settings["all"]) return vars.isPaused || current.honk == 0 || current.honk == 13;
	else if (settings["menu"] && !settings["all"]) return vars.isPaused;
	else if (settings["all"]) return vars.isPaused || current.reset == 0 || current.reset == 1 || current.honk  == 0 || current.honk  == 13 || current.honk  == 16;
}
