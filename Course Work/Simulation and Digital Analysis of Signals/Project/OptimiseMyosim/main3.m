clearvars;
close all
clc

for i=1:22
    Records_Dir = 'matchedSigs';
    file = dir(sprintf('%s%s%d_GA_*.mat', Records_Dir, filesep, i));
    
    if (~isempty(file))
        fitscore = 0;
        for j=1:length(file)
            Record_File = load(sprintf('%s%s%s', Records_Dir, filesep, file(j).name));
            
            if (Record_File.spectralMAD > fitscore)
                fitscore = Record_File.spectralMAD;
                bestscore = j;
            end
        end
        
        Best_Results = 'BestSigs';
        bestfile = sprintf('%s%s%s', Records_Dir, filesep, file(bestscore).name);
        copyfile (bestfile, Best_Results);
    end
end

