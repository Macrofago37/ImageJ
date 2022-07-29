//PSR analysis - BAT
//Luiz Felipe Martucci
//Edited: 29/07/22


setTool("Paintbrush Tool");
run("Colors...", "foreground=black background=white selection=pink");
setForegroundColor(0, 0, 0);
setTool("Paintbrush Tool");
waitForUser("Corrigir imagem", "Usar o pincel para destacar o que devera ser desconsiderado");
setBatchMode(true);
original=getTitle();
run("Select All");
run("Set Measurements...", "area area_fraction display add redirect=None decimal=2");
List.setMeasurements;
area_total= List.getValue("Area");

selectImage(original);
run("Duplicate...", " ");
run("Lab Stack");
close1=getTitle();
run("Next Slice [>]");
run("Duplicate...", " ");
setAutoThreshold("Triangle");
//run("Threshold...");
setOption("BlackBackground", true);
run("Convert to Mask");
run("Invert");
psr=getTitle();
//selectWindow(psr); //add
run("Create Selection");
roiManager("Add");
List.setMeasurements;
psr_area= List.getValue("Area");

selectImage(original);
run("Duplicate...", " ");
run("8-bit");
setAutoThreshold("Default dark");

setAutoThreshold("Minimum");
run("Create Selection");
roiManager("Add");
//roiManager("Select", 0);
//roiManager("Measure");
List.setMeasurements;
area_nao_tecidual= List.getValue("Area");


Table.create("Results");
setResult("Área total", 0, area_total);
setResult("Área não-tecidual", 0, area_nao_tecidual);
setResult("PSR área", 0, psr_area);
psr_percent= ((psr_area*100)/(area_total - area_nao_tecidual) );
setResult("% Área PSR", 0, psr_percent);
setForegroundColor(0, 99, 57);
selectWindow(original);
close("\\Others");
roiManager("Show All");
roiManager("Select", 1);


run("Fill", "slice");
//run("Flatten");
roiManager("reset");

setBatchMode(false);
//close(original)
//close(close1);
selectWindow("Results");






