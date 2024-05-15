clear all; close all; clc;


%%
reconstructed_file = '/work/home/chandan/Chandan_case_files/SPOD_work_space/TEST_DATA/azi_recons_test_data/Bres_geomtrip_81.h5';
original_dataset_file = '/work/home/chandan/Chandan_case_files/SPOD_work_space/TEST_DATA/concatenation_test/Bres_geomtrip_81.h5';
phasename = 'Bres_geomtrip';
reconstructed_file_err = '/work/home/chandan/Chandan_case_files/SPOD_work_space/TEST_DATA/azi_recons_test_data/Bres_geomtrip_82.h5';
if exist(reconstructed_file_err,'file')==2
    delete(reconstructed_file_err);
end
%%
src_blk_start  = 0;
src_blk_end = 5;
field_names_list = {'density','pressure'};

for src_blk_idx = src_blk_start : src_blk_end 

     for field_name_idx = 1 : length(field_names_list)   

          if ismember(src_blk_idx,0:1)
              grid_name = 'inner_cylinder';
              read_src_blk_id = src_blk_idx;
          
          elseif ismember(src_blk_idx,2:5)
              grid_name = 'chamber';
              read_src_blk_id = src_blk_idx-2;
          end
               
          dataset_path = sprintf('/%s/%s/fields/%d/%s',phasename,grid_name,read_src_blk_id,field_names_list{field_name_idx});
          
          dataset_recons = h5read(reconstructed_file,dataset_path); dataset_recons = permute(dataset_recons,[3 2 1]);
          dataset_original = h5read(original_dataset_file,dataset_path); dataset_original = permute(dataset_original,[3 2 1]);

          max_err = (100*abs(dataset_recons - dataset_original)./dataset_original);
          min_err = min(min(min(100*abs(dataset_recons - dataset_original)./dataset_original)));
%           fprintf('Maximum percentage error in %s in src blk %d = %f \n',field_names_list{field_name_idx},src_blk_idx,max_err);
          fprintf('Min percentage error in %s in src blk %d = %f \n',field_names_list{field_name_idx},src_blk_idx,min_err);
          
          dataset_path = sprintf('/%s/%s/fields/%d/%s',phasename,grid_name,read_src_blk_id,field_names_list{field_name_idx});
          max_err = permute(max_err,[3 2 1]);
          h5create(reconstructed_file_err,dataset_path,size(max_err));
          h5write(reconstructed_file_err,dataset_path,max_err);

     end
     


end