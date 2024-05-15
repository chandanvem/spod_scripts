% clear all; close all; clc;

%%
addpath '/work/home/chandan/Chandan_case_files/SPOD_work_space/scripts/azim_decomp';
addpath '/work/home/chandan/Chandan_case_files/SPOD_work_space/scripts/validation_tests'
%%
input_dir = '/work/home/chandan/Chandan_case_files/SPOD_work_space/SPOD_DATA/brescase/azi_decomp_time_series';
input_file_name_prefix = 'Bres_geomtrip_azi_decomp';
input_file_idx = 81;
input_file_name_path = sprintf('%s/%s_%d.h5',input_dir,input_file_name_prefix,input_file_idx);
%%
LES_data_dir = '/work/home/chandan/chandan_backup_asenag/BRES_SPOD_TIME_SERIES';
LES_data_name_prefix = 'Bres_geom_prims';
phase_name = 'Bres_geomtrip';
grids_file_name = '/work/home/chandan/Chandan_case_files/SPOD_work_space/TEST_DATA/concatenation_test/Bres_geomtrip_grids_0.h5';
%%
output_dir = '/work/home/chandan/Chandan_case_files/SPOD_work_space/TEST_DATA/azi_recons_test_data';
output_file_name_prefix  = 'Bres_geomtrip';
%%
theta = get_theta(grids_file_name,'chamber',0);
first_azi_mode = -10;
last_azi_mode  =  10;
src_blk_start = 0;
src_blk_end = 5;
input_file_path = sprintf('%s/%s_%d.h5',input_dir,input_file_name_prefix,input_file_idx);
field_names = {'density','u_velocity','v_velocity','w_velocity','pressure'};

output_file_name = sprintf('%s/%s_%d.h5',output_dir,output_file_name_prefix,input_file_idx) ;

if exist(output_file_name,'file')==2
   delete(output_file_name);
end

for field_name_idx = 1 : length(field_names)

    field= field_names{field_name_idx};

    for src_blk = src_blk_start : src_blk_end
                
        if src_blk == 0 || src_blk == 1
            grid_name = 'inner_cylinder';
            write_src_blk_id = src_blk;
            theta = get_theta(grids_file_name,'inner_cylinder',0);
        else
            grid_name = 'chamber';
            write_src_blk_id = src_blk-2;
            theta = get_theta(grids_file_name,'chamber',0);
        end
        reconstructed_dataset = ...
           azimuthal_reconstruction(input_file_name_path,src_blk,first_azi_mode,last_azi_mode,field,theta);

        output_dataset_path = sprintf('/%s/%s/fields/%d/%s',phase_name,grid_name,write_src_blk_id,field);
        reconstructed_dataset = permute(reconstructed_dataset,[3 2 1]);
        h5create(output_file_name,output_dataset_path,size(reconstructed_dataset));
        h5write(output_file_name,output_dataset_path,reconstructed_dataset);
        fprintf('Data written for field %s of source block %d\n',field,src_blk);

    end



end

