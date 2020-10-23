using Toybox.WatchUi;
using Toybox.System;
using Toybox.Timer;

class dqstrackerHqMenuDelegate extends WatchUi.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

	function increment(category) {
		addItem(category);
		WatchUi.pushView(new dqstrackerAddView(), new dqstrackerAddDelegate(), WatchUi.SLIDE_UP);
		var timer = new Timer.Timer();
		timer.start(method(:timerCallback3), 1000, false);
	}
	
    function onMenuItem(item) {
        if (item == :hq_menu_item_1) {
        	increment(:vegetables);
        } else if (item == :hq_menu_item_2) {
        	increment(:fruits);
        } else if (item == :hq_menu_item_3) {
        	increment(:nuts);
        } else if (item == :hq_menu_item_4) {
        	increment(:whole_grains);
        } else if (item == :hq_menu_item_5) {
        	increment(:hq_meat);
        } else if (item == :hq_menu_item_6) {
        	increment(:hq_drinks);
        } else if (item == :hq_menu_item_7) {
        	increment(:hq_processed);
        }
    }

}