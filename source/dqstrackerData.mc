using Toybox.Application;
using Toybox.System;
using Toybox.Graphics;
using Toybox.Lang;
using Toybox.Time;
using Toybox.Time.Gregorian;

var dictIncrements = { 
	:vegetables 	=> [ +2, +2, +2, +1, +0, +0 ], 
	:fruits 		=> [ +2, +2, +2, +1, +0, +0 ], 
	:nuts 			=> [ +2, +2, +1, +0, +0, -1 ], 
	:whole_grains 	=> [ +2, +2, +1, +0, +0, -1 ], 
	:dairy		 	=> [ +2, +2, +1, +0, +0, -1 ], 
	:hq_meat 		=> [ +2, +1, +1, +0, -1, -2 ], 
	:hq_drinks 		=> [ +1, +1, +0, +0, -1, -2 ], 
	:hq_processed 	=> [ +1, +0, -1, -2, -2, -2 ], 

	:refined_grains => [ -1, -1, -2, -2, -2, -2 ], 
	:sweets 		=> [ -2, -2, -2, -2, -2, -2 ], 
	:fried			=> [ -2, -2, -2, -2, -2, -2 ], 
	:lq_meat 		=> [ -2, -2, -2, -2, -2, -2 ], 
	:lq_drinks 		=> [ -2, -2, -2, -2, -2, -2 ], 
	:lq_processed 	=> [ -2, -2, -2, -2, -2, -2 ], 
	
	:alcohol 		=> [ +1, +1, +0, -1, -2, -2 ]
};

var arrColors = [
	Graphics.COLOR_DK_RED,
	Graphics.COLOR_RED,
	Graphics.COLOR_YELLOW,
	Graphics.COLOR_GREEN,
	Graphics.COLOR_DK_GREEN
];

var arrLabels = [
	"V",
	"F",
	"N",
	"D",
	"A",
	"G",
	"M",
	"B",
	"P",
	"S",
	"R"
];

var arrDayScores = [ 0, 0, 0, 0, 0, 0, 0 ];

var strLevelsDate="";
var mtLevelsDate=null;
var dictLevels = null;
var nLastIncrement = 0;
var nDay = 0;

var arrCategories = [
	:vegetables, :fruits, :nuts, :whole_grains, :dairy, :hq_meat, :hq_drinks, :hq_processed, 
	:refined_grains, :sweets, :fried, :lq_meat, :lq_drinks, :lq_processed, 
	:alcohol ];

function storeLevelsAndScore() {
	for(var i = 0; i < arrCategories.size(); i++ ) {
		Application.Storage.setValue(strLevelsDate+arrCategories[i], dictLevels[arrCategories[i]]);
	}
	Application.Storage.setValue(strLevelsDate+"-sum", getScore());
}

function loadLevels() {
	dictLevels = {};
	for(var i = 0; i < arrCategories.size(); i++ ) {
		var nLevel = Application.Storage.getValue(strLevelsDate+arrCategories[i]);
		if (nLevel == null) {
			dictLevels[arrCategories[i]] = 0;
		} else {
			dictLevels[arrCategories[i]] = nLevel;
		}
	}	
}

function loadScores() {
	for (var i = 0; i < 7; i++) {
		var mtDay = Time.today().subtract(getDayDurations(i));
		System.println(getDateString(mtDay)+"-sum");
		var nDayScore = Application.Storage.getValue(getDateString(mtDay)+"-sum");
		if (nDayScore != null) {
			arrDayScores[i] = nDayScore;
		}
	}
}

function getScoreColor(value) {
	if (value == 0) {
		return Graphics.COLOR_WHITE;
	} else if (value < 14) {
		return Graphics.COLOR_DK_RED;
	} else if (value < 17) {
		return Graphics.COLOR_RED;
	} else if (value < 20) {
		return Graphics.COLOR_YELLOW;
	} else if (value < 23) {
		return Graphics.COLOR_GREEN;
	}
	return Graphics.COLOR_DK_GREEN;	
}

function addItem(category) {
	if (dictLevels==null) {
		loadLevels();
	}
	if (dictLevels[category]<6) {
		dictLevels[category]+=1;
		storeLevelsAndScore();
		nLastIncrement=dictIncrements[category][dictLevels[category]-1];
	} else {
		System.println("Skipping item, category already full");
	}
}

function getLastIncrement() {
	return nLastIncrement;
}

function getScore() {
	if (dictLevels==null) {
		loadLevels();
	}	
	var nScore=0;
	for(var i = 0; i < arrCategories.size(); i++ ) {
		for(var j = 0; j < dictLevels[arrCategories[i]] && j < 6; j++) {
			nScore+= dictIncrements[arrCategories[i]][j];	
		}
	}
	return nScore;
}

function resetScore() {
	for(var i = 0; i < arrCategories.size(); i++ ) {
		dictLevels[arrCategories[i]] = 0;
	}
	storeLevelsAndScore();
}

function getDayNumber() {
	return Time.today().subtract(mtLevelsDate).value()/(60*60*24);
}

function getDayDuration() {
	return getDayDurations(1);
}

function getDayDurations(days) {
	return new Time.Duration(60 * 60 * 24 * days);
}

function getDateString(moment) {
	var infDate = Gregorian.info(moment, Time.FORMAT_SHORT);
	return Lang.format("$1$-$2$-$3$", [ infDate.day, infDate.month, infDate.year ]);
}

function setDateToday() {
	mtLevelsDate = Time.today();
	strLevelsDate = getDateString(mtLevelsDate);
	System.println(strLevelsDate);    	
}

function setDateNextDay() {
	if (mtLevelsDate.value() < Time.today().value()) {
		mtLevelsDate = mtLevelsDate.add(getDayDuration());
		strLevelsDate = getDateString(mtLevelsDate);
		System.println(strLevelsDate);
		loadLevels();
		
	}
}

function setDatePrevDay() {
	if (mtLevelsDate.value() > (Time.today().value() - 6 * getDayDuration().value())) {
		mtLevelsDate = mtLevelsDate.subtract(getDayDuration());
		strLevelsDate = getDateString(mtLevelsDate);
		System.println(strLevelsDate);
		loadLevels();
	}	
}
