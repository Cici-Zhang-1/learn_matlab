clear;
close all;

height = 0.1;
width = 0.0625;
thickness = 0.0625;

folder = 'F:\T2-1\Analysis\';
filename = 'ZQ175-3W-2';
xls = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true);


C = cell(1, size(xls, 2));
C(:) = {'double'};

names = {'CaudatePutamen', 'Neocortex', ...
    'Cerebellum', 'Thalamus', 'PeriformCortex', 'Hypothalamus', 'CC/ExternalCapsule'};
names_L = {'CaudatePutamen_L', 'Neocortex_L', ...
    'Cerebellum_L', 'Thalamus_L', 'PeriformCortex_L', 'Hypothalamus_L', 'CC/ExternalCapsule_L'};
names_R = {'CaudatePutamen_R', 'Neocortex_R', ...
    'Cerebellum_R', 'Thalamus_R', 'PeriformCortex_R', 'Hypothalamus_R', 'CC/ExternalCapsule_R'};

xls{:, :} = xls{:, :} * height * width * thickness;
header = xls.Properties.VariableNames(:, 1:end);
volumns = table('Size', [size(names_L, 2) * 2 size(header, 2)], 'VariableTypes', C,...
    'VariableNames', xls.Properties.VariableNames);
volumns_row_names = [];
j = 1;
for i = 1:size(xls, 1)
    if strcmp(xls.Properties.RowNames(i, 1),'Brain') > 0 || ...
            ~isempty(find(strcmp(names_L, xls.Properties.RowNames(i, 1)), 1)) ...
            || ~isempty(find(strcmp(names_R, xls.Properties.RowNames(i, 1)), 1))
        volumns(j, :) = xls(i, :);
        j = j + 1;
        volumns_row_names = [volumns_row_names; xls.Properties.RowNames(i, 1)];
    end
end
volumns.Properties.RowNames = volumns_row_names;
%volumn
writetable(volumns, [folder filename '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'Volumn');

xls_combine = table('Size', [fix(size(volumns, 1) / 2) size(volumns, 2)], 'VariableTypes', ...
    C,  'VariableNames', xls.Properties.VariableNames);
xls_combine_row_names = [];
xls_combine_tmp = volumns(2:end, :);
for i = 1:2:size(xls_combine_tmp, 1)-1
    tmp = xls_combine_tmp(i:i+1, :);
    xls_combine{fix(i/2) + 1, :} = sum(table2array(tmp));
    row_names = split(xls_combine_tmp.Properties.RowNames(i, 1), '_');
    xls_combine_row_names = [xls_combine_row_names; row_names(1, 1)];
end
xls_combine.Properties.RowNames = xls_combine_row_names;
%combine
writetable(xls_combine, [folder filename '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'Combine');

fw = [];
fw_header = [];
fh = [];
fh_header = [];
mw = [];
mw_header = [];
mh = [];
mh_header = [];
for i = 1:size(header, 2)
    if ~isempty(strfind(header{1, i}, 'FW'))
        fw(:, size(fw, 2) + 1) = table2array(volumns(:, i));
        fw_header = [fw_header header(1, i)];
        %fw = table(fw, xls{:, i});
    elseif ~isempty(strfind(header{1, i}, 'FH'))
        fh(:, size(fh, 2) + 1) = table2array(volumns(:, i));
        fh_header = [fh_header header(1, i)];
    elseif ~isempty(strfind(header{1, i}, 'MW'))
        mw(:, size(mw, 2) + 1) = table2array(volumns(:, i));
        mw_header = [mw_header header(1, i)];
    elseif ~isempty(strfind(header{1, i}, 'MH'))
        mh(:, size(mh, 2) + 1) = table2array(volumns(:, i));
        mh_header = [mh_header header(1, i)];
    end
end
fw = array2table(fw);
fw.Properties.VariableNames = fw_header;
fw.Properties.RowNames = volumns.Properties.RowNames;
%FW
writetable(fw, [folder filename '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'FW');

fh = array2table(fh);
fh.Properties.VariableNames = fh_header;
fh.Properties.RowNames = volumns.Properties.RowNames;
%FH
writetable(fh, [folder filename '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'FH');

mw = array2table(mw);
mw.Properties.VariableNames = mw_header;
mw.Properties.RowNames = volumns.Properties.RowNames;
%MW
writetable(mw, [folder filename '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'MW');

mh = array2table(mh);
mh.Properties.VariableNames = mh_header;
mh.Properties.RowNames = volumns.Properties.RowNames;
%MH
writetable(mh, [folder filename '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'MH');

fw_combine_tmp = fw(2:end, :);
C = cell(1, size(fw_combine_tmp, 2));
C(:) = {'double'};
fw_combine = table('Size', [size(fw_combine_tmp, 1) / 2 size(fw_combine_tmp, 2)], 'VariableTypes', ...
    C,  'VariableNames', fw.Properties.VariableNames, 'RowNames', xls_combine_row_names);
fw_combine_header = [];
for i = 1:2:size(fw_combine_tmp, 1)-1
    tmp = fw_combine_tmp(i:i+1, :);
    fw_combine{fix(i/2) + 1, :} = sum(table2array(tmp));
end
fw_combine.Properties.RowNames = xls_combine_row_names;
%FW_Combine
writetable(fw_combine, [folder filename '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'FW_Combine');

fh_combine_tmp = fh(2:end, :);
C = cell(1, size(fh_combine_tmp, 2));
C(:) = {'double'};
fh_combine = table('Size', [size(fh_combine_tmp, 1) / 2 size(fh_combine_tmp, 2)], 'VariableTypes', ...
    C,  'VariableNames', fh.Properties.VariableNames);
fh_combine_header = [];
for i = 1:2:size(fh_combine_tmp, 1)-1
    tmp = fh_combine_tmp(i:i+1, :);
    fh_combine{fix(i/2) + 1, :} = sum(table2array(tmp));
end
fh_combine.Properties.RowNames = xls_combine_row_names;
%FH_Combine
writetable(fh_combine, [folder filename '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'FH_Combine');

mw_combine_tmp = mw(2:end, :);
C = cell(1, size(mw_combine_tmp, 2));
C(:) = {'double'};
mw_combine = table('Size', [size(mw_combine_tmp, 1) / 2 size(mw_combine_tmp, 2)], 'VariableTypes', ...
    C,  'VariableNames', mw.Properties.VariableNames);
mw_combine_header = [];
for i = 1:2:size(mw_combine_tmp, 1)-1
    tmp = mw_combine_tmp(i:i+1, :);
    mw_combine{fix(i/2) + 1, :} = sum(table2array(tmp));
end
mw_combine.Properties.RowNames = xls_combine_row_names;
%MW_Combine
writetable(mw_combine, [folder filename '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'MW_Combine');

mh_combine_tmp = mh(2:end, :);
C = cell(1, size(mh_combine_tmp, 2));
C(:) = {'double'};
mh_combine = table('Size', [size(mh_combine_tmp, 1) / 2 size(mh_combine_tmp, 2)], 'VariableTypes', ...
    C,  'VariableNames', mh.Properties.VariableNames);
mh_combine_header = [];
for i = 1:2:size(mh_combine_tmp, 1)-1
    tmp = mh_combine_tmp(i:i+1, :);
    mh_combine{fix(i/2) + 1, :} = sum(table2array(tmp));
end
mh_combine.Properties.RowNames = xls_combine_row_names;
%MH_Combine
writetable(mh_combine, [folder filename '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'MH_Combine');

% pixel = table2array(xls(1:end, 6:end));
% header = xls.Properties.VariableNames(1, 6:end);
% header2 = {};
% for i=1:size(header, 2)
%     header2(1, 2* i - 1) = header(1, i);
%     header2(1, 2*i) = strcat(header(1, i), '_V');
% end
% 
% pixel2 = pixel * height * width * thickness;
% cal = [];
% for i=1:size(pixel, 2)
%     cal(:, 2*i-1) = pixel(:, i);
%     cal(:, 2*i) = pixel2(:, i);
% end
% 
% t = array2table(cal);
% t.Properties.VariableNames = header2;
% writetable(t, 'a.xls', 'WriteVariableNames', true);


% [num, txt, raw] = xlsread('/Users/chuangchuangzhang/Downloads/ZQ175-3W.xlsx', 'Sheet1');
% 
% pixel = num(:, 6:end);
% 
% height = 0.1;
% width = 0.0625;
% thickness = 0.0625;
% pixel2 = pixel * height * width * thickness;
% cal = [];
% for i = 1:size(pixel, 2)
%     cal(:, i*2 - 1) = pixel(:, i);
%     cal(:, i*2) = pixel2(:, i);
% end
% 
% xlswrite('/Users/chuangchuangzhang/Downloads/ZQ175-3W.xlsx', cal, 'Sheet1', 'F2');