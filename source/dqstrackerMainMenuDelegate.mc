using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.System;

function timerCallback2() {
	WatchUi.popView(WatchUi.SLIDE_DOWN);
	WatchUi.popView(WatchUi.SLIDE_DOWN);
}

function timerCallback3() {
	WatchUi.popView(WatchUi.SLIDE_DOWN);
	WatchUi.popView(WatchUi.SLIDE_DOWN);
	WatchUi.popView(WatchUi.SLIDE_DOWN);
}

class dqstrackerMainMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

	function increment(category) {
		addItem(category);
		WatchUi.pushView(new dqstrackerAddView(), new dqstrackerAddDelegate(), WatchUi.SLIDE_UP);
		var timer = new Timer.Timer();
		timer.start(method(:timerCallback2), 1000, false);
	}
	
    function onMenuItem(item) {
        if (item == :main_menu_item_hq) {
        	WatchUi.pushView(new Rez.Menus.HighQualityMenu(), new dqstrackerHqMenuDelegate(), WatchUi.SLIDE_UP);
        } else if (item == :main_menu_item_lq) {
        	WatchUi.pushView(new Rez.Menus.LowQualityMenu(), new dqstrackerLqMenuDelegate(), WatchUi.SLIDE_UP);
        } else if (item == :main_menu_item_alc) {
        	increment(:alcohol);
        } else if (item == :main_menu_item_reset) {
        	resetScore();
        }
    }

}