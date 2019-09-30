clear;
close all;
folder = 'F:\T2-1\ZQ175-3W\';
filename = 'ZQ175-3W';
FH = readtable([folder filename '-FH.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true);
FW = readtable([folder filename '-FW.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true);
MH = readtable([folder filename '-MH.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true);
MW = readtable([folder filename '-MW.xlsx'], 'ReadVariableNames', true, 'ReadRowNames', true);

FH_brain = FH{1, :}';
FW_brain = FW{1, :}';
MH_brain = MH{1, :}';
MW_brain = MW{1, :}';

[F_h,F_p,F_ci,F_stats] = ttest2(FH_brain, FW_brain);

[M_h,M_p,M_ci,M_stats] = ttest2(MH_brain, MW_brain);