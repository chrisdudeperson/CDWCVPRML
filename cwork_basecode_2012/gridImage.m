function g=gridImage(gridImageNorm, gridSize)
       
     imageSize = size(gridImageNorm);
     imageWidth=imageSize(1,2);
     imageHeight=imageSize(1,1);
     
     cellWidthSize = floor(imageWidth/gridSize);
     cellHeightSize = floor(imageHeight/gridSize);
     
%      disp(sprintf('Image Width: %d   Grid Size: %d', imageWidth, gridSize));
     
     remainingWidth = imageWidth - (cellWidthSize * gridSize);
     remainingHeight = imageHeight - (cellHeightSize * gridSize);
     
     cellWidthStart= 1;
     cellHeightStart = 1;
     cellWidthEnd = cellWidthSize;
     cellHeightEnd = cellHeightSize;
     g = [];
     for i=1:gridSize
         for j=1:gridSize
%               disp(sprintf('Itteration i: %d   j: %d', i,j));
%              disp(sprintf('Width Start: %d  Width End: %d', cellWidthStart, cellWidthEnd));
%              disp(sprintf('Height Start: %d  Height End: %d', cellHeightStart, cellHeightEnd));
             imageCell = gridImageNorm(cellHeightStart:cellHeightEnd,cellWidthStart:cellWidthEnd,:);
%              g = [g, ComputeRGBHistogram(imageCell,4)];
             g = [g, calculateTexture(imageCell,4)];
%                g = [g, calculateDescriptor(imageCell)];
              cellWidthStart = cellWidthStart + cellWidthSize;
             if((remainingWidth ~= 0) && (j == gridSize))
                 cellWidthEnd = cellWidthEnd + cellWidthSize + remainingWidth;
%                    disp(sprintf('-------FIRST IF------'));
             else
                cellWidthEnd = cellWidthEnd + cellWidthSize;
             end
           
         end
         
         if(remainingHeight ~= 0) && (i == gridSize-1)
               cellHeightEnd = cellHeightEnd + cellHeightSize + remainingHeight;
%                disp(sprintf('-------SECOND IF------ cell: %d', cellHeightEnd));
           else
               cellHeightEnd = cellHeightEnd + cellHeightSize;
           end
           cellHeightStart = cellHeightStart + cellHeightSize;
           cellWidthStart= 1;
           cellWidthEnd = cellWidthSize;
     end