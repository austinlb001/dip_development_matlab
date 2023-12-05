

%% OR
% Read in data 
or_baseline = readmatrix('cure-tsr.xlsx','Sheet','Baseline','Range','A3:L5002');
or_median = readmatrix('cure-tsr.xlsx','Sheet','Median','Range','A3:L5002');
or_wavelet = readmatrix('cure-tsr.xlsx','Sheet','Wavelet','Range','A3:L5002');



figure 
for ii = 1:max(or_wavelet(:,3))
subplot(3,4,ii)
current_challenge = or_wavelet(:,3)==ii;

current_challenge = or_wavelet(current_challenge,:);


no_challenge = or_baseline(:,3) ==ii;

no_challenge = or_baseline(no_challenge,:);

for jj =1:5
scatter(jj,mean(current_challenge(current_challenge(:,4)==jj,7)),[],mean(current_challenge(current_challenge(:,4)==jj,7))-mean(no_challenge(no_challenge(:,4)==jj,7)),'filled')
hold on
scatter(jj,mean(no_challenge(no_challenge(:,4)==jj,7)),"red",'filled')
hold on
colorbar
end
%mean(no_challenge(no_challenge(:,4)==jj,7))
end 


%% TSD
% Read in data 
tsd_baseline = readmatrix('cure-tsr.xlsx','Sheet','Baseline','Range','A3:L5002');
tsd_median = readmatrix('cure-tsr.xlsx','Sheet','Median','Range','A3:L5002');
tsd_wavelet = readmatrix('cure-tsr.xlsx','Sheet','Wavelet','Range','A3:L5002');




figure 
for ii = 1:max(tsr_wavelet(:,3))
subplot(3,4,ii)
current_challenge = tsr_wavelet(:,3)==ii;

current_challenge = tsr_wavelet(current_challenge,:);


no_challenge = tsr_baseline(:,3) ==ii;

no_challenge = tsr_baseline(no_challenge,:);

scatter(current_challenge(:,4),(current_challenge(:,7)),[],(current_challenge(:,7)-no_challenge(:,7)),'filled')
hold on
%scatter(no_challenge(:,4),no_challenge(:,7),"red",'filled')
hold on
colorbar
end
%mean(no_challenge(no_challenge(:,4)==jj,7))


%% CURE OR 

% Read in data 
or_baseline = readmatrix('cure-or.xlsx','Sheet','Baseline','Range','A3:M5002');
or_median = readmatrix('cure-or.xlsx','Sheet','Median','Range','A3:M5002');
or_wavelet = readmatrix('cure-or.xlsx','Sheet','Wavelet','Range','A3:M5002');

%% Heatmap - 0 to 1 Metrics - Wavelet

fig=figure 
for ii = 2:max(or_wavelet(:,5))
subplot(2,4,ii-1)
current_challenge = or_wavelet(:,5)==ii;

current_challenge = or_wavelet(current_challenge,:);


no_challenge = or_baseline(:,5) ==ii;

no_challenge = or_baseline(no_challenge,:);

iterations = unique(current_challenge(:,6));
idx=0;
clear metrics_mean
for jj = iterations(~isnan(iterations))'
idx=idx+1;
    challenge_level=current_challenge(current_challenge(:,6)==jj,:);
    metrics_mean(idx,:) = mean(challenge_level(:,7:13));

    
end 

imagesc(metrics_mean(:,2:end-1)')
xlabel(titles{ii})

colorbar
% set(gca, 'XTick', [1:5], 'XTickLabel', [1:5])  
% set(gca, 'YTick', [1:5], 'YTickLabel', [1:5])  
end

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Metric');
xlabel(han,'Challenge Level');
lgd.Layout.Tile = 'south';
title(han,{'Wavelet Filter - CURE OR', 'Average Metric Per Challenge Type and Challenge Levels'})

%% Heatmap - 0 to 1 Metrics - Wavelet

fig=figure 
for ii = 2:max(or_median(:,5))
subplot(2,4,ii-1)
current_challenge = or_median(:,5)==ii;

current_challenge = or_median(current_challenge,:);


no_challenge = or_baseline(:,5) ==ii;

no_challenge = or_baseline(no_challenge,:);

iterations = unique(current_challenge(:,6));
idx=0;
clear metrics_mean
for jj = iterations(~isnan(iterations))'
idx=idx+1;
    challenge_level=current_challenge(current_challenge(:,6)==jj,:);
    metrics_mean(idx,:) = mean(challenge_level(:,7:13));

    
end 

imagesc(metrics_mean(:,2:end-1)')
xlabel(titles{ii})

colorbar
% set(gca, 'XTick', [1:5], 'XTickLabel', [1:5])  
% set(gca, 'YTick', [1:5], 'YTickLabel', [1:5])  
end

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Metric');
xlabel(han,'Challenge Level');
lgd.Layout.Tile = 'south';
title(han,{'Median Filter - CURE OR', 'Average Metric Per Challenge Type and Challenge Levels'})



%% Heatmap - 0 to 1 Metrics - Wavelet

fig=figure 
for ii = 2:max(or_median(:,5))
subplot(2,4,ii-1)
current_challenge = or_median(:,5)==ii;

current_challenge = or_median(current_challenge,:);


no_challenge = or_baseline(:,5) ==ii;

no_challenge = or_baseline(no_challenge,:);

for jj = 1: max(current_challenge(:,6))

    challenge_level=current_challenge(current_challenge(:,6)==jj,:);
    metrics_mean(jj,:) = mean(challenge_level(:,7:13));

    
end 

imagesc(metrics_mean(:,2:end-1)')
xlabel(titles{ii})

colorbar
% set(gca, 'XTick', [1:5], 'XTickLabel', [1:5])  
% set(gca, 'YTick', [1:5], 'YTickLabel', [1:5])  
end

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Metric');
xlabel(han,'Challenge Level');
lgd.Layout.Tile = 'south';
title(han,{'Wavelet Filter - CURE OR', 'Average Metric Per Challenge Type and Challenge Levels'})

%% CURE OR 

% Read in data 
tsd_baseline = readmatrix('cure-tsd.xlsx','Sheet','Baseline','Range','A3:L5002');
tsd_median = readmatrix('cure-tsd.xlsx','Sheet','Median','Range','A3:L5002');
tsd_wavelet = readmatrix('cure-tsd.xlsx','Sheet','Wavelet','Range','A3:L5002');

%% Heatmap - 0 to 1 Metrics - Wavelet

fig=figure 
iterations = unique(tsd_wavelet(:,4));
idx=0
for ii = iterations(~isnan(iterations))'
idx=idx+1;
subplot(2,3,idx)
current_challenge = tsd_wavelet(:,4)==ii;

current_challenge = tsd_wavelet(current_challenge,:);


no_challenge = tsd_baseline(:,4) ==ii;

no_challenge = tsd_baseline(no_challenge,:);

for jj = 1: max(current_challenge(:,5))

    challenge_level=current_challenge(current_challenge(:,5)==jj,:);
    metrics_mean(jj,:) = mean(challenge_level(:,6:12));
    
end 

imagesc(metrics_mean(:,2:end-1)')
xlabel(titles{ii})

colorbar
% set(gca, 'XTick', [1:5], 'XTickLabel', [1:5])  
% set(gca, 'YTick', [1:5], 'YTickLabel', [1:5])  
end

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Metric');
xlabel(han,'Challenge Level');
lgd.Layout.Tile = 'south';
title(han,{'Wavelet Filter - CURE TSD', 'Average Metric Per Challenge Type and Challenge Levels'})

%% Heatmap - 0 to 1 Metrics - Median

fig=figure 
iterations = unique(tsd_median(:,4));
idx=0
for ii = iterations(~isnan(iterations))'
idx=idx+1;
subplot(2,3,idx)
current_challenge = tsd_median(:,4)==ii;

current_challenge = tsd_median(current_challenge,:);


no_challenge = tsd_baseline(:,4) ==ii;

no_challenge = tsd_baseline(no_challenge,:);

for jj = 1: max(current_challenge(:,5))

    challenge_level=current_challenge(current_challenge(:,5)==jj,:);
    metrics_mean(jj,:) = mean(challenge_level(:,6:12));
    
end 

imagesc(metrics_mean(:,2:end-1)')
xlabel(titles{ii})

colorbar
% set(gca, 'XTick', [1:5], 'XTickLabel', [1:5])  
% set(gca, 'YTick', [1:5], 'YTickLabel', [1:5])  
end

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Metric');
xlabel(han,'Challenge Level');
lgd.Layout.Tile = 'south';
title(han,{'median Filter - CURE TSD', 'Average Metric Per Challenge Type and Challenge Levels'})


%% Heatmap - 0 to 1 Metrics - Wavelet

fig=figure 
for ii = 2:max(or_median(:,5))
subplot(2,4,ii-1)
current_challenge = or_median(:,5)==ii;

current_challenge = or_median(current_challenge,:);


no_challenge = or_baseline(:,5) ==ii;

no_challenge = or_baseline(no_challenge,:);

for jj = 1: max(current_challenge(:,6))

    challenge_level=current_challenge(current_challenge(:,6)==jj,:);
    metrics_mean(jj,:) = mean(challenge_level(:,7:13));

    
end 

imagesc(metrics_mean(:,2:end-1)')
xlabel(titles{ii})

colorbar
% set(gca, 'XTick', [1:5], 'XTickLabel', [1:5])  
% set(gca, 'YTick', [1:5], 'YTickLabel', [1:5])  
end

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Metric');
xlabel(han,'Challenge Level');
lgd.Layout.Tile = 'south';
title(han,{'Wavelet Filter - CURE OR', 'Average Metric Per Challenge Type and Challenge Levels'})




%% TSR
% Read in data 
tsr_baseline = readmatrix('cure-tsr.xlsx','Sheet','Baseline','Range','A3:L5002');
tsr_median = readmatrix('cure-tsr.xlsx','Sheet','Median','Range','A3:L5002');
tsr_wavelet = readmatrix('cure-tsr.xlsx','Sheet','Wavelet','Range','A3:L5002');



fig=figure 
for ii = 1:max(or_wavelet(:,3))
subplot(2,4,ii)
current_challenge = or_wavelet(:,3)==ii;

current_challenge = or_wavelet(current_challenge,:);


no_challenge = or_baseline(:,3) ==ii;

no_challenge = or_baseline(no_challenge,:);

for jj = 1: 5

    challenge_level=current_challenge(current_challenge(:,4)==jj,:);
    metrics_mean(jj,:) = mean(challenge_level(:,6:12));

    
end 

plot(metrics_mean(:,2:end-1),'-*')
%scatter(no_challenge(:,4),no_challenge(:,7),"red",'filled')
hold on
end
%mean(no_challenge(no_challenge(:,4)==jj,7))

legend('PSNR','SSIM','CW-SSIM','UNIQUE','MS UNIQUE','CSV','SUMMER')

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Image Quality');
xlabel(han,'Challenge Level');
lgd.Layout.Tile = 'south';
title(han,{'Wavelet Filter - CURE OR', 'Average Metric Per Challenge Type and Challenge Levels'})

% Difference between baseline and each emthod 





%% Heatmap - 0 to 1 Metrics - Wavelet

fig=figure 
for ii = 1:max(tsr_wavelet(:,3))
subplot(3,4,ii)
current_challenge = tsr_wavelet(:,3)==ii;

current_challenge = tsr_wavelet(current_challenge,:);


no_challenge = tsr_baseline(:,3) ==ii;

no_challenge = tsr_baseline(no_challenge,:);

for jj = 1: 5

    challenge_level=current_challenge(current_challenge(:,4)==jj,:);
    metrics_mean(jj,:) = mean(challenge_level(:,6:12));

    
end 

imagesc(metrics_mean(:,2:end-1)')
xlabel(titles{ii})

colorbar
set(gca, 'XTick', [1:5], 'XTickLabel', [1:5])  
set(gca, 'YTick', [1:5], 'YTickLabel', [1:5])  
end

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Metric');
xlabel(han,'Challenge Level');
lgd.Layout.Tile = 'south';
title(han,{'Wavelet Filter - CURE TSR', 'Average Metric Per Challenge Type and Challenge Levels'})



%% Heatmap  - 0 to 1 Metrics - Median

fig=figure 

%plot titles 

titles=num2cell('a':'l');
for ii = 1:max(tsr_median(:,3))
subplot(3,4,ii)

current_challenge = tsr_median(:,3)==ii;

current_challenge = tsr_median(current_challenge,:);


no_challenge = tsr_median(:,3) ==ii;

no_challenge = tsr_median(no_challenge,:);

for jj = 1: 5

    challenge_level=current_challenge(current_challenge(:,4)==jj,:);
    metrics_mean(jj,:) = mean(challenge_level(:,6:12));

    
end 

imagesc(metrics_mean(:,2:end-1)')
xlabel(titles{ii})

colorbar
set(gca, 'XTick', [1:5], 'XTickLabel', [1:5])  
set(gca, 'YTick', [1:5], 'YTickLabel', [1:5])  
end

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Metric');
xlabel(han,'Challenge Level');
lgd.Layout.Tile = 'south';
title(han,{'Median Filter - CURE TSR', 'Average Metric Per Challenge Type and Challenge Levels'})

%% PSNR and SUMMER  - Median 
fig=figure 
for ii = 1:max(tsr_median(:,3))
subplot(3,4,ii)
current_challenge = tsr_median(:,3)==ii;

current_challenge = tsr_median(current_challenge,:);


no_challenge = tsr_median(:,3) ==ii;

no_challenge = tsr_median(no_challenge,:);

for jj = 1: 5

    challenge_level=current_challenge(current_challenge(:,4)==jj,:);
    metrics_mean(jj,:) = mean(challenge_level(:,6:12));
    metrics_mean_nc(jj,:) = mean(no_challenge(:,6:12));

    
end 

imagesc([(metrics_mean(:,1)'-metrics_mean_nc(:,1)')./metrics_mean_nc(:,1)';(metrics_mean(:,end)'-metrics_mean_nc(:,end)')./metrics_mean_nc(:,end)'])
colorbar
xlabel(titles{ii})

set(gca, 'XTick', [1:5], 'XTickLabel', [1:5])  
set(gca, 'YTick', [1:5], 'YTickLabel', [1:5])  

end

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Metric');
xlabel(han,'Challenge Level');
lgd.Layout.Tile = 'south';
title(han,{'Median Filter - CURE TSR', 'Average Metric Per Challenge Type and Challenge Levels'})


%% PSNR and SUMMER 
fig=figure 
for ii = 1:max(tsr_wavelet(:,3))
subplot(3,4,ii)
current_challenge = tsr_wavelet(:,3)==ii;

current_challenge = tsr_wavelet(current_challenge,:);


no_challenge = tsr_wavelet(:,3) ==ii;

no_challenge = tsr_wavelet(no_challenge,:);

for jj = 1: 5

    challenge_level=current_challenge(current_challenge(:,4)==jj,:);
    metrics_mean(jj,:) = mean(challenge_level(:,6:12));
    metrics_mean_nc(jj,:) = mean(no_challenge(:,6:12));

    
end 

imagesc([(metrics_mean(:,1)'-metrics_mean_nc(:,1)')./metrics_mean_nc(:,1)';(metrics_mean(:,end)'-metrics_mean_nc(:,end)')./metrics_mean_nc(:,end)'])
colorbar
xlabel(titles{ii})

set(gca, 'XTick', [1:5], 'XTickLabel', [1:5])  
set(gca, 'YTick', [1:5], 'YTickLabel', [1:5])  

end

han=axes(fig,'visible','off'); 
han.Title.Visible='on';
han.XLabel.Visible='on';
han.YLabel.Visible='on';
ylabel(han,'Metric');
xlabel(han,'Challenge Level');
lgd.Layout.Tile = 'south';
title(han,{'Wavelet Filter - CURE TSR', 'Average Metric Per Challenge Type and Challenge Levels'})