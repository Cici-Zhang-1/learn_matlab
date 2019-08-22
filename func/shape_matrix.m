% reshape image matrix
function slice_data = shape_matrix(toshow, slice_num)
    tmp = toshow(:,slice_num,:);
    slice_data = reshape(tmp, [256, 256]);
	return
end