function [ mean_image ] = get_mean_image( file_list )
%Averages the data in the images from file_list and returns it as a 2D array
%   === Inputs ===
%   file_list should be a linear cell array with a filename in each cell.
%   It is best to get file_list from get_file_list()
%
%   === Outputs ===
%   mean_image is the average of all of the images in file_list.  It is
%   returned as a 2D array with the same dimensions as the input images.
%
%   === Example Usage ===
%   >> ls_pattern = fullfile('20170405','Savefile_4*_back.ascii');
%   >> file_list = get_file_list(ls_pattern);
%   >> mean_image = get_mean_image(file_list);
%   >> plot_image(mean_image,'Test of get_mean_image()');

%get the images as series of column vectors and get their initial dimensions
[images_array,image_size]=get_images_array(file_list);
mean_image=mean(images_array,2); %average the different images
mean_image=reshape(mean_image,image_size); %return the image to its 2D form
end