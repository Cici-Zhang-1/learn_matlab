clear;
close all;

% merge 3w 5w and 7w data together to compare

if ispc
    folder = 'F:\T2-1\Analysis\';
    seperator = '\';
elseif ismac
    folder = '/Users/chuangchuangzhang/Downloads/Analysis/';
    seperator = '/';
elseif isunix
else
end

filename = ['ZQ175-3W-';'ZQ175-5W-';'ZQ175-7W-'];
filename_results = 'Structure_MRI_ZQ175_3_time_together_male';
no = '2';
MW_Combine = [];
MH_Combine = [];
Combine = [];
% Brain CaudatePutamen Neocortex Cerebellum Thalamus PeriformCortex Hypothalamus CC/ExternalCapsule
% 'Hippocampus', 'LGP', 'Ventricles', 'AccumbensNu', 'Amygdala'
type = 'Brain';
for i = 1:size(filename, 1)
    MW_Combine = readtable([folder filename(i, :) no '.xlsx'], ...
        'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MW_Combine');
    MH_Combine = readtable([folder filename(i, :) no '.xlsx'], ...
        'ReadVariableNames', true, 'ReadRowNames', true, 'Sheet', 'MH_Combine');
    Combine(1:size(MW_Combine, 2), i) = MW_Combine{type, :};
    Combine(size(MW_Combine, 2) + 1: size(MW_Combine, 2) + size(MH_Combine, 2), i) = MH_Combine{type, :};
end

Model = {'MWT' 'MWT' 'MWT' 'MWT' 'MWT' 'MWT' 'MHD' 'MHD' 'MHD' 'MHD' 'MHD' 'MHD'}';

Time = [21 35 49]';

t = table(Model, Combine(:,1), Combine(:,2), Combine(:,3), ...
'VariableNames',{'Model','P21','P35','P49'});

rm = fitrm(t,'P21-P49 ~ Model','WithinDesign',Time);
ranovatbl = ranova(rm);
anovatbl = anova(rm,'WithinModel','orthogonalcontrasts');

T = ranovatbl('(Intercept):Time', 'pValue');
T.Properties.RowNames = {'Between-Time'};
M = ranovatbl('Model:Time', 'pValue');
M.Properties.RowNames = {'Model-Time'};
B = anovatbl(2, 'pValue');
B.Properties.RowNames = {'Between-Model'};
if strcmp(type, 'CC/ExternalCapsule')
    writetable(t, [folder filename_results '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', 'CC_ExternalCapsule');
    writetable(T, [folder filename_results '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, ...
        'Sheet', 'CC_ExternalCapsule', 'Range', 'F1');
    writetable(B, [folder filename_results '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, ...
        'Sheet', 'CC_ExternalCapsule', 'Range', 'F6');
    writetable(M, [folder filename_results '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, ...
        'Sheet', 'CC_ExternalCapsule', 'Range', 'F11');
else
    writetable(t, [folder filename_results '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, 'Sheet', type);
    writetable(T, [folder filename_results '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, ...
        'Sheet', type, 'Range', 'F1');
    writetable(B, [folder filename_results '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, ...
        'Sheet', type, 'Range', 'F6');
    writetable(M, [folder filename_results '.xlsx'], 'WriteVariableNames', true, 'WriteRowNames', true, ...
        'Sheet', type, 'Range', 'F11');
end

AddImage = true;
if AddImage
    % img = 'figure1.png';
    % plot(1:10);
    % print('-dpng', img);
    % Get handle to Excel COM Server
    Excel = actxserver('Excel.Application');
    % Set it to visible 
    set(Excel,'Visible',1);
    % Add a Workbook
    Workbooks = Excel.Workbooks;
    Workbook = Open(Workbooks, [folder filename_results '.xlsx']);
    % Workbook = invoke(Workbooks, 'Add');
    % Get a handle to Sheets and select Sheet 1
    Sheets = Excel.ActiveWorkBook.Sheets;
    if strcmp(type, 'CC/ExternalCapsule')
        Sheet1 = get(Sheets, 'Item', 'CC_ExternalCapsule');
    else
        Sheet1 = get(Sheets, 'Item', type);
    end

    Sheet1.Activate;
    % Alternative 1 BEGIN.
    % Get a handle to Shapes for Sheet 1
    Shapes = Sheet1.Shapes;
    % Add image
    if strcmp(type, 'CC/ExternalCapsule')
        Shapes.AddPicture([folder 'M_CC_ExternalCapsule.png'] ,0,1,400,18,300,235);
    else
        Shapes.AddPicture([folder 'M_' type '.png'] ,0,1,400,18,300,235);
    end

    % Alternative 1 END.
    % Alternative 2 BEGIN.
    % Add image
    % Sheet1.invoke('Pictures').Insert([folder 'M_' type '.png']);
    % Alternative 2 END.
    % Save the workbook and Close Excel
    Save(Workbook);
    % invoke(Workbook, 'Save', [folder filename_results '.xlsx']);
    invoke(Excel, 'Quit');
end
