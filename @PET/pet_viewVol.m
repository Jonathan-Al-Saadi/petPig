function imtool3Dhandle = pet_viewVol(petObj)
    f = figure;
    petObj.handles.imtoolfig = f;
    imtool3Dhandle = imtool3D(petObj.vol, [], f);
    petObj.handles.imtool = imtool3Dhandle;
end