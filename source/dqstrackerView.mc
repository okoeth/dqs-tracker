using Toybox.WatchUi;
using Toybox.Lang;

class dqstrackerView extends WatchUi.View {

	hidden var txtScore;
	hidden var arrtxtLabels = [null,null,null,null,null,null,null,null,null,null,null,null,];        
	
    function initialize() {
        View.initialize();
    }

    // Load your resources here
    //function onLayout(dc) {
    //    setLayout(Rez.Layouts.MainLayout(dc));
    //}

    // Called when this View is brought to the foreground. Restore
    // the state of this View and prepare it to be shown. This includes
    // loading resources into memory.
    function onShow() {
    	var nScore = getScore();
        txtScore = new WatchUi.Text({
            :text=>"",
            :color=>Graphics.COLOR_WHITE,
            :font=>Graphics.FONT_SYSTEM_MEDIUM,
            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
            :locX =>0,
            :locY=>0
        });

		for(var i = 0; i < arrLabels.size(); i++ ) {
        	arrtxtLabels[i] = new WatchUi.Text({
	            :text=>arrLabels[i],
	            :color=>Graphics.COLOR_WHITE,
	            :font=>Graphics.FONT_SYSTEM_XTINY,
	            :justification=>Graphics.TEXT_JUSTIFY_CENTER,
	            :locX =>0,
	            :locY=>0
	        });
	    }
    }

    // Update the view
    function onUpdate(dc) {
        // Call the parent onUpdate function to redraw the layout
        View.onUpdate(dc);
        drawAll(dc);
    }

    // Called when this View is removed from the screen. Save the
    // state of this View here. This includes freeing resources from
    // memory.
    function onHide() {
    }
    
    function drawAll(dc) {
    	System.println("drawAll");
    	
    	// Set constants
    	var x_middle = dc.getWidth()/2;
    	var y_header = dc.getHeight()*0.15;
    	var y_footer = dc.getHeight() - dc.getHeight()*0.15;
    	var y_top = dc.getHeight()*0.17;
    	var box_width = 12;
    	var box_gap = 2;
    	var circle_adjust = 10;
    	
    	// Set Color
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	
    	// Draw header / footer line
    	dc.drawLine(0, y_header, dc.getWidth(), y_header);
    	dc.drawLine(0, y_footer, dc.getWidth(), y_footer);
    	
    	// Draw score
        txtScore.setText(getScore().format("%+d"));
        txtScore.setLocation(x_middle, y_top - 3*box_width);
        txtScore.draw(dc);
    	
    	// Draw boxes for labels
		for(var i = 0; i < arrLabels.size(); i++ ) {
	    	arrtxtLabels[i].setLocation(x_middle, y_top + i * (box_width + box_gap));
	    	arrtxtLabels[i].draw(dc);
		}    	
    	
    	// Draw circles for points
		for(var i = 0; i < arrLabels.size(); i++ ) {
			if (i < 9) {
				drawCircles(dc, x_middle + box_width + box_gap, y_top + circle_adjust + i * (box_width + box_gap), +1);
			}
			if (i > 4) {
				drawCircles(dc, x_middle - box_width - box_gap, y_top + circle_adjust + i * (box_width + box_gap), -1);
			}
		}
		
		// Fill circles for points
		for(var i = 0; i < arrLabels.size(); i++ ) {
			if (arrLabels[i].equals("V")) {
				fillCircles(dc, x_middle + box_width + box_gap, y_top + circle_adjust + i * (box_width + box_gap), +1, :vegetables);
			}
			else if (arrLabels[i].equals("F")) {
				fillCircles(dc, x_middle + box_width + box_gap, y_top + circle_adjust + i * (box_width + box_gap), +1, :fruits);
			}
			else if (arrLabels[i].equals("N")) {
				fillCircles(dc, x_middle + box_width + box_gap, y_top + circle_adjust + i * (box_width + box_gap), +1, :nuts);
			}
			else if (arrLabels[i].equals("D")) {
				fillCircles(dc, x_middle + box_width + box_gap, y_top + circle_adjust + i * (box_width + box_gap), +1, :dairy);
			}
			else if (arrLabels[i].equals("A")) {
				fillCircles(dc, x_middle + box_width + box_gap, y_top + circle_adjust + i * (box_width + box_gap), +1, :alcohol);
			}
			else if (arrLabels[i].equals("G")) {
				fillCircles(dc, x_middle + box_width + box_gap, y_top + circle_adjust + i * (box_width + box_gap), +1, :whole_grains);
				fillCircles(dc, x_middle - box_width - box_gap, y_top + circle_adjust + i * (box_width + box_gap), -1, :refined_grains);
			}
			else if (arrLabels[i].equals("M")) {
				fillCircles(dc, x_middle + box_width + box_gap, y_top + circle_adjust + i * (box_width + box_gap), +1, :hq_meat);
				fillCircles(dc, x_middle - box_width - box_gap, y_top + circle_adjust + i * (box_width + box_gap), -1, :lq_meat);
			}
			else if (arrLabels[i].equals("B")) {
				fillCircles(dc, x_middle + box_width + box_gap, y_top + circle_adjust + i * (box_width + box_gap), +1, :hq_drinks);
				fillCircles(dc, x_middle - box_width - box_gap, y_top + circle_adjust + i * (box_width + box_gap), -1, :lq_drinks);
			}
			else if (arrLabels[i].equals("P")) {
				fillCircles(dc, x_middle + box_width + box_gap, y_top + circle_adjust + i * (box_width + box_gap), +1, :hq_processed);
				fillCircles(dc, x_middle - box_width - box_gap, y_top + circle_adjust + i * (box_width + box_gap), -1, :lq_processed);
			}
			else if (arrLabels[i].equals("S")) {
				fillCircles(dc, x_middle - box_width - box_gap, y_top + circle_adjust + i * (box_width + box_gap), -1, :sweets);
			}
			else if (arrLabels[i].equals("R")) {
				fillCircles(dc, x_middle - box_width - box_gap, y_top + circle_adjust + i * (box_width + box_gap), -1, :fried);
			}
		}
		
		// Draw boxes for last 7 days, underline today
		var y_box = y_footer+4*box_gap;
		for (var i = -3; i < 4; i++) {
			dc.drawRectangle(x_middle-box_width/2 + (i*(box_width+box_gap)), y_box, box_width, box_width);
		}
		loadScores();
		for (var i = -3; i < 4; i++) {
			dc.setColor(getScoreColor(arrDayScores[6-(i+3)]), getScoreColor(arrDayScores[6-(i+3)]));
			dc.fillRectangle(x_middle-box_width/2 + (i*(box_width+box_gap)), y_box, box_width, box_width);
		}
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	
		
		// Underline box of current day
		var x_line = x_middle-box_width/2 + ((3-getDayNumber())*(box_width+box_gap));
		var y_line = y_box+box_width+box_gap;
		dc.drawLine(x_line, y_line, x_line + box_width, y_line);		
    }
    
    function drawCircles(dc, x_pos, y_pos, direction) {
    	// Set constants
    	var radius = 4;
    	var gap = 2;
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    	for (var i = 0; i < 6; i++) {
    		dc.drawCircle(x_pos + i * (2 * radius + gap) * direction, y_pos, radius);
    	}    	
    }

    function fillCircles(dc, x_pos, y_pos, direction, category) {
    	// Set constants
    	var radius = 4;
    	var gap = 2;
    	for (var i = 0; i < dictLevels[category] && i < 6; i++) {
    		dc.setColor(arrColors[dictIncrements[category][i]+2], arrColors[dictIncrements[category][i]+2]);    		
    		dc.fillCircle(x_pos + i * (2 * radius + gap) * direction, y_pos, radius);
    	}
    	dc.setColor(Graphics.COLOR_WHITE, Graphics.COLOR_BLACK);
    }
}
