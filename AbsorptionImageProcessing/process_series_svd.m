function [ atom_OD_svd ] = process_series_svd(series_name, basis_svd, back_region)
%Averages the images in the given series and removes the background using
%the singular value decomposition algorithm
%   === Inputs ===
%   series_name should be a string giving a pattern to match all the images
%   of one series of images.  This typically involves using the '*'
%   wildcard.
%
%   basis_svd should be a basis generated by make_basis_svd().
%
%   mean_back should be the mean background image generated by
%   make_basis_eig().
%
%   back_region should the same back_region that was given to
%   make_basis_svd() in order to generate the basis.  It should be a 2D
%   array with 1's in the pixels that should be considered as background
%   and used, and 0's in the pixels that should be ignored (e.g. if there
%   are atoms there).  The easiest way to make this matrix is to use
%   make_back_region().
%
%   === Outputs ===
%   atom_OD_svd is a 2D array of the optical depth of the atoms with the
%   background removed.  It is the result of averaging all the data in the
%   series and removing the background using the vectors with the largest
%   singular values, which are given in basis_svd.
%
%   === Example Usage ===
%   >> %Get an image we'd like to analyze
%   >> %(we'll need to know its dimensions to construct back_region)
%   >> filename = fullfile('20170405','Cool100d100d80PGCZ4.4_1_raw.ascii');
%   >> image_in = load_image(filename);
%   >> 
%   >> %Select a background region
%   >> row_min=40; row_max=60; col_min=50; col_max=80;
%   >> back_region = make_back_region(image_in,row_min,row_max,col_min,col_max);
%   >> 
%   >> %Make a basis
%   >> max_vectors = 20; %20 is typically a good number for this
%   >> ls_pattern = fullfile('20170405','*_back.ascii');
%   >> file_list = get_file_list(ls_pattern);
%   >> basis_svd = make_basis_svd(file_list,back_region,max_vectors);
%   >> 
%   >> %Average and analyze the series of images
%   >> series_name = fullfile('20170405','Cool100d100d80PGCZ4.4_*_raw.ascii');
%   >> OD_svd = process_series_svd(series_name,basis_svd,back_region);
%   >> 
%   >> %Plot the results
%   >> plot_image(OD_svd,'SVD Optical Depth');
%   >> limits = [row_min,row_max,col_min,col_max];
%   >> plot_cross_sections(OD_svd,'SVD Result',limits);

%Get a list of filenames for the series
atom_file_list=get_file_list(series_name);

%Now send this file list to process_list_svd() and return the result
atom_OD_svd=process_list_svd(atom_file_list, basis_svd, back_region);
end

