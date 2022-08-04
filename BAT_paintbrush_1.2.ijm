//PSR analysis - BAT
//Luiz Felipe Martucci
//Edited: 04/08/22


//Seleciona a marcação de PSR 
run("Select All");
run("Set Measurements...", "area area_fraction display add redirect=None decimal=2");
List.setMeasurements;
area_total= List.getValue("Area");
og=getTitle();
string1= substring(og, 0,7);
run("Duplicate...", "use");
run("RGB Stack");
rgb_stack=getTitle();
run("Duplicate...", " ");
red=getTitle();
setAutoThreshold("MaxEntropy");
//setThreshold(0, 114);
run("Convert to Mask");
run("Median...", "radius=10");
selectWindow(rgb_stack);
run("Next Slice [>]");
run("Duplicate...", "use");
green=getTitle();
setAutoThreshold("Shanbhag");
run("Convert to Mask");
imageCalculator("Subtract create", green, red);
selectWindow("Result of Green");
run("Erode");
run("Create Selection");
List.setMeasurements;
PSR_area= List.getValue("Area");
run("Create Selection");
selectWindow(og);
run("Restore Selection");
setForegroundColor(255, 0, 134);
run("Draw", "slice");
close("\\Others");
rename(string1 + "_analyzed");
percent_PSR= ((PSR_area*100)/area_total)
Table.create("Results");
setResult("% Área PSR", 0, percent_PSR);
//print(percent_PSR)

