function display_save_nii_axial(nii, filename)
%     global old_toshow
    global toshow
    
%     if ~exist('nii','var') | isempty(nii) | ~isfield(nii,'hdr') | ...
% 	~isfield(nii,'img') | ~exist('fileprefix','var') | isempty(fileprefix)
% 
%       error('Usage: display_save_nii(nii, filename, [old_RGB])');
%     end
% 
%     if isfield(nii,'untouch') & nii.untouch == 1
%       error('Usage: please use ''save_untouch_nii.m'' for the untouched structure.');
%     end
%     for i = 1 : secondD
%         old_toshow(:, i, :) = reshape(toshow(:, :, i), [firstD, 1, thirdD]);
%     end
    nii.img = toshow;
    save_nii(nii, filename);
    return
end