//lineWidth = getNumber("Please enter desired line width", 5);
//run("Line Width...", "line=" + lineWidth);
for(pSlice=1; pSlice <= nSlices; pSlice++) {
	
	//Keep prompting for a line, until a line is drawn.
	selectionCheck = -1;
	while(selectionCheck != 5) {
		//Clear selection after drawing reference line
		run("Select None");
			
		//Make a line
		setTool("line");

		//Wait for user to draw reference lines
		waitForUser("Make selection", "Please make reference line past slice " + pSlice - 1 + ".");
		selectionCheck = selectionType(); 
	}

	//Draw the line 
	run("Fill", "slice"); 
	
	getLine(x1, y1, x2, y2, lineWidth);
	currentSlice = getSliceNumber();

	//Clear selection after drawing reference line
	run("Select None");

	//If this is not the first line, then interpoalte from previous line
	if (pSlice!=1){
		//Calculate number to slices between lines
		zDist = currentSlice - pSlice;

		//Calculate x and y distances for line
		dx1 = x1-px1;
		dx2 = x2-px2;
		dy1 = y1-py1;
		dy2 = y2-py2;

		//Interpolate and draw in-between lines
		for (a = pSlice; a <= currentSlice; a++){
			//move to next slice
			setSlice(a);

			//Calculate start and end coordinates for next line
			cx1 = round(px1 + dx1 * (a - pSlice) / zDist);
			cx2 = round(px2 + dx2 * (a - pSlice) / zDist);
			cy1 = round(py1 + dy1 * (a - pSlice) / zDist);
			cy2 = round(py2 + dy2 * (a - pSlice) / zDist);
			
			makeLine(cx1,cy1,cx2,cy2);

			//Draw the line 
			run("Fill", "slice"); 
	
			//Clear selection after drawing reference line
			run("Select None");
			
		}
	}

	//Set the current line coordinates and slice number as the previous line coordinates for the next loop
	px1 = x1;
	px2 = x2;
	py1 = y1;
	py2 = y2;
	pSlice = getSliceNumber();
}

