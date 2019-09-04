clear;
close all;

height = 0.1;
width = 0.0625;
thickness = 0.0625;

folder = 'F:\T2-1\ZQ175-3W\';
filename = 'ZQ175-3W';
xls = readtable([folder filename '.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true);

xls{:, :} = xls{:, :} * height * width * thickness;
header = xls.Properties.VariableNames(:, 1:end);
writetable(xls, [folder filename '-Volumn.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true);

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
        fw(:, size(fw, 2) + 1) = table2array(xls(:, i));
        fw_header = [fw_header header(1, i)];
        %fw = table(fw, xls{:, i});
    elseif ~isempty(strfind(header{1, i}, 'FH'))
        fh(:, size(fh, 2) + 1) = table2array(xls(:, i));
        fh_header = [fh_header header(1, i)];
    elseif ~isempty(strfind(header{1, i}, 'MW'))
        mw(:, size(mw, 2) + 1) = table2array(xls(:, i));
        mw_header = [mw_header header(1, i)];
    elseif ~isempty(strfind(header{1, i}, 'MH'))
        mh(:, size(mh, 2) + 1) = table2array(xls(:, i));
        mh_header = [mh_header header(1, i)];
    end
end
fw = array2table(fw);
fw.Properties.VariableNames = fw_header;
fw.Properties.RowNames = xls.Properties.RowNames;
writetable(fw, [folder filename '-FW.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true);

fh = array2table(fh);
fh.Properties.VariableNames = fh_header;
fh.Properties.RowNames = xls.Properties.RowNames;
writetable(fh, [folder filename '-FH.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true);

mw = array2table(mw);
mw.Properties.VariableNames = mw_header;
mw.Properties.RowNames = xls.Properties.RowNames;
writetable(mw, [folder filename '-MW.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true);

mh = array2table(mh);
mh.Properties.VariableNames = mh_header;
mh.Properties.RowNames = xls.Properties.RowNames;
writetable(mh, [folder filename '-MH.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true);

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