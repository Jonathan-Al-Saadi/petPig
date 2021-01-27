function [proportion, sumMask] = pet_calcMask(petObj)    
    %User chooses mask
    num = input('Which mask would you like to use?. (Enter for 1)\n');
    
    %Using logical indexing to find values of mask
    maskedObj = petObj.vol(petObj.mask == num);
    
    % Sum of mask
    sumMask = sum(maskedObj, 'all');
    
    % Sum of total volume
    sumVol = sum(petObj.vol, 'all');
    
    % Comparing mask to volume
    proportion = sumMask/sumVol;
end