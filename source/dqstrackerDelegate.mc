using Toybox.WatchUi;

class dqstrackerDelegate extends WatchUi.BehaviorDelegate {

    function initialize() {
        BehaviorDelegate.initialize();
    }

    function onMenu() {
        WatchUi.pushView(new Rez.Menus.MainMenu(), new dqstrackerMainMenuDelegate(), WatchUi.SLIDE_UP);
        return true;
    }

}