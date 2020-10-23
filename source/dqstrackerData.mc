using Toybox.Application;
using Toybox.System;

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

var strLevelsDate="01-01-1980";
var dictLevels = null;
var nLastIncrement = 0;

var arrCategories = [
	:vegetables, :fruits, :nuts, :whole_grains, :dairy, :hq_meat, :hq_drinks, :hq_processed, 
	:refined_grains, :sweets, :fried, :lq_meat, :lq_drinks, :lq_processed, 
	:alcohol ];

function storeLevels() {
	for(var i = 0; i < arrCategories.size(); i++ ) {
		Application.Storage.setValue(strLevelsDate+arrCategories[i], dictLevels[arrCategories[i]]);
	}
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

function addItem(category) {
	if (dictLevels==null) {
		loadLevels();
	}	
	dictLevels[category]+=1;
	storeLevels();
	nLastIncrement=dictIncrements[category][dictLevels[category]-1];
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
		for(var j = 0; j < dictLevels[arrCategories[i]]; j++) {
			nScore+= dictIncrements[arrCategories[i]][j];	
		}
	}
	return nScore;
}

function resetScore() {
	for(var i = 0; i < arrCategories.size(); i++ ) {
		dictLevels[arrCategories[i]] = 0;
	}
	storeLevels();
}
