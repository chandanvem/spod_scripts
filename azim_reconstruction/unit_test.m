

clear all; close all; clc;
%%

original_file= '/work/home/chandan/Chandan_case_files/SPOD_work_space/TEST_DATA/Bres_geomtrip_grids_0.h5';
% reconstructed_file = '/work/home/chandan/Chandan_case_files/SPOD_work_space/TEST_DATA/azi_recons_test_data/Bres_geom_recons_81.h5';


%%
y_dataset_orig_path =  '/chamber/0/ycoord';
z_dataset_orig_path =  '/chamber/0/zcoord';
% dataset_recons_path = '/Bres_geomtrip/chamber/fields/2/density';

y_dataset = h5read(original_file,y_dataset_orig_path);
z_dataset = h5read(original_file,z_dataset_orig_path);
% orig_dataset = permute(orig_dataset,[3 2 1]);
% recons_dataset = h5read(reconstructed_file,dataset_recons_path);
