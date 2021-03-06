function [ file_list ] = get_file_list( ls_pattern )
%Takes a file name pattern with wildcards and returns a list of file names
%   === Inputs ===
%   ls_pattern should be a pattern that could be passed to the ls function.
%   It can (and usually should) include the "*" wildcard to match multiple
%   files.
%
%   === Outputs ===
%   file_list is a linear cell array (a column vector) with a filename in
%   each cell.
%
%   === Notes ===
%   The output of Matlab's dir() function changed slightly in version
%   2016b, so there is a separate section of code that runs when this
%   function is used in versions of Matlab that are older than that.
%
%   === Example Usage ===
%   >> ls_pattern = fullfile('20170405','Savefile_4*_back.ascii');
%   >> file_list = get_file_list(ls_pattern);

if verLessThan('matlab','9.1')
    %dir() worked differently before Matlab 9.1 (2016b).  Unfortunately,
    %Mathworks stopped making 32 bit versions of Matlab before then, and
    %our camera code doesn't work on 64 bit Matlab.  Therefore, for the
    %camera computer we need different code. This work-around is ok enough,
    %but has issues.  It doesn't handle wildcards for directories well for
    %example.
    [~,file_structs,~]=fileattrib(ls_pattern);
    file_list={file_structs.Name}';
elseif isunix()  || ispc()
    %More robust code that only works on Matlab 2016b and later
    temp=dir(ls_pattern); %cells of objects, one object for each file
    k_max=size(temp,1); %k_max= number of files
    file_list=cell(k_max,1);
    for k=1:k_max
        file_list{k}=fullfile(temp(k).folder,temp(k).name);
    end
end
end