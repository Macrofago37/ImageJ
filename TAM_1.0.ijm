//Lipid droplets analysis - BAT 
//Luiz Felipe Martucci
//Edited: 29/07/22
setTool("Paintbrush Tool");
run("Colors...", "foreground=black background=white selection=pink");
setForegroundColor(0, 0, 0);
setTool("Paintbrush Tool");
waitForUser("Corrigir imagem", "Usar o pincel para destacar o que devera ser desconsiderado");
run("Set Scale...", "distance=346 known=50 pixel=1.037 unit=um");
setBatchMode(true);
original = getTitle();
string1= substring(original, 0,7);
run("Duplicate...", " ");
run("RGB Stack");
close1 = getTitle();
run("Next Slice [>]");
run("Duplicate...", "use");
close2= getTitle();
run("Despeckle");
run("Unsharp Mask...", "radius=3 mask=0.90");
run("Mexican Hat Filter", "radius=17");
setOption("BlackBackground", true);
run("Convert to Mask");
//run("Invert"); changed
run("EDM Binary Operations", "iterations=2 operation=open");
run("EDM Binary Operations", "iterations=6 operation=close");
run("Invert");
run("Dilate");
run("Dilate");
run("Dilate");
run("Adjustable Watershed", "tolerance=2");
close(close1); 
run("Analyze Particles...", "  circularity=0.00-1.00 show=[Bare Outlines] exclude clear add");
outlines= getTitle();
run("Create Selection");
selectWindow(original);
rename(string1 + "_analyzed");
original_renamed= getTitle();
run("Restore Selection");
close(close2);
close(outlines);
roiManager("Show All");
run("ROI Manager...");
setBatchMode(false);
waitForUser("Deletar erros", "Selecionar as marcações erradas no ROimanger e deletá-las");
roiManager("Measure");
selectWindow(original_renamed);
run("Flatten");
roiManager("reset");
close(original_renamed);
selectWindow("Results");
//selectWindow(outlines);
/*
setForegroundColor(255, 255, 255);
setTool("Paintbrush Tool");
*/
