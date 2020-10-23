using Toybox.WatchUi;
using Toybox.System;
using Toybox.Timer;

class dqstrackerLqMenuDelegate extends WatchUi.MenuInputDelegate {

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
        if (item == :lq_menu_item_1) {
        	increment(:refined_grains);
        } else if (item == :lq_menu_item_2) {
        	increment(:sweets);
        } else if (item == :lq_menu_item_3) {
        	increment(:fried);
        } else if (item == :lq_menu_item_4) {
        	increment(:lq_meat);
        } else if (item == :lq_menu_item_5) {
        	increment(:lq_drinks);
        } else if (item == :lq_menu_item_6) {
        	increment(:lq_processed);
        }
    }

}