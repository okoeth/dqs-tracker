using Toybox.WatchUi;

class dqstrackerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onSelect() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new dqstrackerMainMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

	function onPreviousPage() {
		setDatePrevDay();
		WatchUi.requestUpdate();
        return true;
	}

	function onNextPage() {
		setDateNextDay();
		WatchUi.requestUpdate();
        return true;
	}
}