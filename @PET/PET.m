classdef PET < handle
    % Superclass for PET
    
    properties
        vol
        mask
    end
    
    properties (SetAccess = public, GetAccess = public)
        subjectInfo
        stats
        handles
        maskInfo
    end
    
    
    methods (Access = public)
        
        %% Create the object
            function petObj = PET(vol, mask, subjectInfo)
              
               switch nargin

                %No input arguments, should read a saved file
                case 0
                  [file, path] = uigetfile();
                  load([path file]);

                %Input volume but no mask
                case 1
                  petObj.vol = vol;
                  petObj.mask = 'No mask provided';

                %Inputs volume and mask
                case 2
                  petObj.vol = vol;
                  petObj.mask = mask;
                
                %Inputs volume, mask and subjectinfo  
                case 3
                  petObj.vol = vol;
                  petObj.mask = mask;
                  petObj.subjectInfo = subjectInfo;
               end
                        
               if ~exist('subjectInfo', 'Var')
                  subjectInfo = struct();

                  %Get patientID
                  patientId = input('Specify patient id (Enter for no patient ID)\n', 's');
                  %Check if patientID was provided
                  if isempty(patientId)
                    patientId = 'NoPatIDProvided';
                  end

                  subjectInfo.patientId = patientId;
                  
                  %Get rater ID
                  raterId = input('Specify rater id. (Enter for no rater ID)\n', 's');
                  %Check if rater ID was provided
                  if isempty(raterId)
                    raterId = 'NoRaterIdProvided';
                  end

                  subjectInfo.raterID = raterId;

                  %Get treatment status
                  groupID = input('Specify group status (Enter for no group ID)\n');
                  if isempty(groupID)
                      groupID = 'NoGroupIDProvided';
                  end

                  subjectInfo.groupID = groupID;
                  
                  %Save subjectinfo  
                  petObj.subjectInfo = subjectInfo;
               end
            end
          
          
            %% View the volume
            function imtool3Dhandle = viewVol(petObj)
                imtool3Dhandle = pet_viewVol(petObj);
            end
            
            %% Save mask
            function saveMask(petObj)
                petObj.mask = petObj.handles.imtool.mask;
            end
            
            %% Load mask
            function loadMask(petObj)
                petObj.handles.imtool.mask = petObj.mask;
            end
            
            %% define mask
            function defineMask(petObj)
                maskInfo = struct();
                maskInfo.one = input('Specify what mask 1 is: \n', 's')
                maskInfo.two = input('Specify what mask 2 is: \n', 's')
                maskInfo.three = input('Specify what mask 3 is: \n', 's')
                maskInfo.four = input('Specify what mask 4 is: \n', 's')
                maskInfo.five = input('Specify what mask 5 is: \n', 's')
                maskInfo.six = input('Specify what mask 6 is: \n', 's')
                petObj.maskInfo = maskInfo;
            end
            
            function [proportion, sum] = calcMask(petObj)
                [proportion, sum] = pet_calcMask(petObj)
            end
            
            
    end
end

