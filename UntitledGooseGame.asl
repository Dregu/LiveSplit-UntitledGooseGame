state("Untitled") {
	int honk : "UnityPlayer.dll", 0x1497D10, 0x9C0;
	int reset: "UnityPlayer.dll", 0x14B1800, 0x330, 0x480;
}

startup {
	settings.Add("splits", true, "Splitting on Finished Tasks");
		settings.Add("intro", true, "intro logo", "splits");

		settings.Add("page1", false, "to do (garden)", "splits");
			settings.Add("goalGarden", false, "get into the garden", "page1");
			settings.Add("goalWet", false, "get the groundskeeper wet", "page1");
			settings.Add("goalKeys", false, "steal the groundskeeper's keys", "page1");
			settings.Add("goalHat", false, "make the groundskeeper wear his sun hat", "page1");
			settings.Add("goalRake", false, "rake in the lake", "page1");
			settings.Add("goalPicnic", false, "have a picnic", "page1");
			settings.Add("goalHammering", false, "make the groundskeeper hammer his thumb", "page1");

		settings.Add("page2", false, "to do (high street)", "splits");
			settings.Add("goalBroom", false, "break the broom", "page2");
			settings.Add("goalPhonebooth", false, "trap the boy in the phone booth", "page2");
			settings.Add("goalWrongGlasses", false, "make the boy wear the wrong glasses", "page2");
			settings.Add("goalBuyBack", false, "make someone buy back their own stuff", "page2");
			settings.Add("goalGetInShop", false, "get on t.v.", "page2");
			settings.Add("goalShopping", false, "go shopping", "page2");
			settings.Add("goalGarage", false, "trap the shopkeeper in the garage", "page2");

		settings.Add("page3", false, "to do (back gardens)", "splits");
			settings.Add("goalBreakVase", false, "make someone break the fancy vase", "page3");
			settings.Add("goalDressStatue", false, "help the woman dress up the bust", "page3");
			settings.Add("goalBell", false, "make the man spit out his tea", "page3");
			settings.Add("goalRibbon", false, "get dressed up with a ribbon", "page3");
			settings.Add("goalBarefoot", false, "make the man go barefoot", "page3");
			settings.Add("goalWashing", false, "do the washing", "page3");
			settings.Add("goalPrune", false, "make someone prune the prize rose", "page3");

		settings.Add("page4", true, "to do (pub)", "splits");
			settings.Add("goalIntoPub", true, "get into the pub", "page4");
			settings.Add("goalOldMan1", false, "break the dartboard", "page4");
			settings.Add("goalBoat", false, "get the toy boat", "page4");
			settings.Add("goalOldMan2", false, "make the old man fall on his bum", "page4");
			settings.Add("goalFlower", false, "be awarded a flower", "page4");
			settings.Add("goalPintGlass", false, "steal a pint glass and drop it in the canal", "page4");
			settings.Add("goalSetTable", false, "set the table", "page4");
			settings.Add("goalBucket", false, "drop a bucket on the burly man's head", "page4");

		settings.Add("page5", true, "to do (model village)", "splits");
			settings.Add("goalModelVillage", true, "get into the model village", "page5");
			settings.Add("goalStealBell", true, "steal the beautiful miniature golden bell", "page5");
			settings.Add("goalFinale", true, "...and take it all the way back home", "page5");

		settings.Add("page6", false, "to do (as well)", "splits");
			settings.Add("goalLockout", false, "lock the groundskeeper out of the garden", "page6");
			settings.Add("goalCabbage", false, "cabbage picnic", "page6");
			settings.Add("goalPuddle", false, "trip the boy in the puddle", "page6");
			settings.Add("goalScales", false, "make the shop scales go ding", "page6");
			settings.Add("goalUmbrella", false, "open an umbrella inside the tv shop", "page6");
			settings.Add("goalBuyBack2", false, "make someone from outside the high street buy back their own stuff", "page6");
			settings.Add("goalFlowers", false, "collect the five flowers", "page6");

		settings.Add("page7", false, "to do (as well)", "splits");
			settings.Add("goalWimpGarage", false, "trap the boy in the garage", "page7");
			settings.Add("goalCatch", false, "catch an object as it's thrown over the fence", "page7");
			settings.Add("goalThrownGoose", false, "get thrown over the fence", "page7");
			settings.Add("goalBust2", false, "dress up the bust with things from outside the back gardens", "page7");
			settings.Add("goalFootball", false, "score a goal", "page7");
			settings.Add("goalBoatBridge", false, "sail the toy boat under a bridge", "page7");
			settings.Add("goalPerformRibbon", false, "perform at the pub wearing a ribbon", "page7");
			settings.Add("goalOldManHat", false, "steal the old man's woolen hat", "page7");

		settings.Add("page8", false, "to do (quickly!!)", "splits");
			settings.Add("goalSpeedyGarden", false, "complete the garden to-do list before the church bells ring", "page8");
			settings.Add("goalSpeedyShops", false, "complete the high street to-do list before the church bells ring", "page8");
			settings.Add("goalSpeedyBackyards", false, "complete the back gardens to-do list before the church bells ring", "page8");
			settings.Add("goalSpeedyPub", false, "complete the pub to-do list before the church bells ring", "page8");
	
		settings.Add("page9", false, "to do (finally)", "splits");
			settings.Add("goal100", false, "cross out everything on the to-do list", "page9");

	settings.Add("reset", true, "Resetting the Timer");
		settings.Add("newfile", true, "when creating a new Save", "reset");
		settings.Add("restart", false, "after confirming Restart or Quit", "reset");
		settings.Add("mainmenu", false, "only after confirming Quit", "reset");

	settings.Add("pause", false, "Pausing the Timer (not allowed for speedruns)");
		settings.Add("loading", false, "while Loading", "pause");
		settings.Add("menu", false, "when opening the Menu", "pause");
		settings.Add("all", false, "while not playing (only works when all 3 options are enabled)", "pause");
}

init {
	string logPath = Environment.GetEnvironmentVariable("appdata")+"\\..\\LocalLow\\House House\\Untitled Goose Game\\output_log.txt";
	try {
		FileStream fs = new FileStream(logPath, FileMode.Open, FileAccess.Write, FileShare.ReadWrite);
		fs.SetLength(0);
		fs.Close();
	} catch {
		print("Cant open goose log");
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
	if (settings["menu"] && vars.line != null && vars.line.StartsWith("Setting controller maps to UI Mode")) {
		vars.isPaused = true;
	} else if (settings["menu"] && vars.line != null && vars.line.StartsWith("Setting controller maps to Gameplay Mode")) {
		vars.isPaused = false;
	} else if (settings["loading"] && vars.line != null && vars.line.StartsWith("unloading. game world active false")) {
		vars.isPaused = true;
	} else if (settings["loading"] && vars.line != null && vars.line.StartsWith("loading! game world active true")) {
		vars.isPaused = false;
	}
}


start {
	return (old.honk == 16 && current.honk == 17);
}

reset {
	return 
		(settings["newfile"] && vars.line != null && vars.line.StartsWith("savefile doesn't exist")) ||
	    (settings["restart"] && vars.line != null && vars.line.StartsWith("unloading. game world active false")) ||
		(settings["mainmenu"] && current.reset == 1);
}

split {
	if (vars.line != null && vars.line.StartsWith("saved due to goal")) {
		var goal = vars.line.Split(' ')[3];
		print("got " + goal);
		return (settings[goal]);
	} else {
		return (settings["intro"] && vars.line != null && vars.line.StartsWith("begining intro title sequence"));
	}
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
	} else if (settings["all"] && settings["loading"] && settings["menu"]) {
		return
			vars.isPaused ||
			current.reset == 0 ||
			current.reset == 1 ||
			current.honk  == 16 ||
			current.honk  == 0 ||
			current.honk  == 13;
	}
}
