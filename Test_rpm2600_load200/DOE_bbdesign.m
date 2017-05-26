clear all
clc

% %% Load the sample data.
% load OriginalFan
% 
% % The data consists of 10,000 measurements (historical production data) of the existing cooling fan performance.
% % Plot the data to analyze the current fan's performance.
% plot(originalfan)
% xlabel('Observation')
% ylabel('Max Airflow (ft^3/min)')
% title('Historical Production Data')
% 
% % The data is centered around 842 ft3/min and most values fall within the range of about 8 ft3/min. 
% % The plot does not tell much about the underlying distribution of data, however. 
% % Plot the histogram and fit a normal distribution to the data.
% figure()
% histfit(originalfan) % Plot histogram with normal distribution fit
% format shortg
% xlabel('Airflow (ft^3/min)')
% ylabel('Frequency (counts)')
% title('Airflow Histogram')
% 
% % fits a normal distribution to data and estimates the parameters from data. 
% % The estimate for the mean airflow speed is 841.652 ft3/min, 
% % and the 95% confidence interval for the mean airflow speed is (841.616, 841.689). 
% % This estimate makes it clear that the current fan is not close to the required 875 ft3/min. 
% % There is need to improve the fan design to achieve the target airflow.
% pd = fitdist(originalfan,'normal')

%%
% Response surface design to estimate any nonlinear interactions among the factors. 
% Generate the experimental runs for a Box-Behnken design in coded (normalized) variables [-1, 0, +1].
 CodedValue = bbdesign(3);
%The first column is for the distance from radiator, 
%the second column is for the pitch angle, 
%and the third column is for the blade tip clearance.

% Randomize the order of the runs, 
% convert the coded design values to real-world units, 
% and perform the experiment in the order specified.
runorder = randperm(size(CodedValue,1));     % Random permutation of the runs
% runorder = [];
bounds = [0.1 0.9;1100 1400;-4 13];  % Min and max values for each factor

RealValue = zeros(size(CodedValue));
for i = 1:size(CodedValue,2) % Convert coded values to real-world units
    zmax = max(CodedValue(:,i));
    zmin = min(CodedValue(:,i));
    RealValue(:,i) = interp1([zmin zmax],bounds(i,:),CodedValue(:,i));
end

% Experiment values
rpm = 1600; load = 200; n = size(CodedValue,1);
TestResult = extractData(rpm,load,n);

%Display values
disp({'Run Number','Boost Pressure','CRP','SoI','BSFC'})
disp(sortrows([runorder' RealValue TestResult]))
%Saving data to table
Expmt = table(runorder', CodedValue(:,1), CodedValue(:,2), CodedValue(:,3), ...
    TestResult,'VariableNames',{'RunNumber','Pi','CRP','SoI','BSFC'});

%Improving Cooling Fan performance
%Estimate the coefficients of this model using the fitlm function from Statistics and Machine Learning Toolbox
mdl = fitlm(Expmt,'BSFC~Pi*CRP*SoI-Pi:CRP:SoI+Pi^2+CRP^2+SoI^2');
b = mdl.Coefficients
%Display the magnitudes of the coefficients (for normalized values) in a bar chart.
figure()
h = bar(mdl.Coefficients.Estimate(2:10));
set(h,'facecolor',[0.8 0.8 0.9])
legend('Coefficient')
set(gcf,'units','normalized','position',[0.05 0.4 0.35 0.4])
set(gca,'xticklabel',mdl.CoefficientNames(2:10))
ylabel('BSFC (g/(kW.h))')
xlabel('Normalized Coefficient')
title('Quadratic Model Coefficients')

%Use plotSlice to generate response surface plots for the model mdl interactively.
plotSlice(mdl)

%% Find the optimal factor settings using the constrained optimization function fmincon.
% Write the objective function.
f = @(x) -x2fx(x,'quadratic')*mdl.Coefficients.Estimate;

% The objective function is a quadratic response surface fit to the data. 
% Minimizing the negative airflow using fmincon is the same as maximizing the original objective function. 
% The constraints are the upper and lower limits tested (in coded values). 
% Set the initial starting point to be the center of the design of the experimental test matrix.
lb = [-1 -1 -1]; % Lower bound					
ub = [1 1 1];    % Upper bound                       
x0 = [0 0 0];    % Starting point
[optfactors,fval] = fmincon(f,x0,[],[],[],[],lb,ub,[]); % Invoke the solver

%Convert the results to a maximization problem and real-world units.
maxval = -fval;
maxloc = (optfactors + 1)';
bounds = [1 1.5;15 35;1 2];
maxloc=bounds(:,1)+maxloc .* ((bounds(:,2) - bounds(:,1))/2);
disp('Optimal Values:')
disp({'Distance','Pitch','Clearance','Airflow'})
disp([maxloc' maxval])

% Because pitch angle has such a significant effect on airflow, perform additional analysis to verify
load AirflowData
tbl = table(pitch,airflow);
mdl2 = fitlm(tbl,'airflow~pitch^2');
mdl2.Rsquared.Ordinary

%Plot the pitch angle against airflow and impose the fitted model.
figure()
plot(pitch,airflow,'.r') 
hold on
ylim([840 885])
line(pitch,mdl2.Fitted,'color','b') 
title('Fitted Model and Data')
xlabel('Pitch angle (degrees)') 
ylabel('Airflow (ft^3/min)')
legend('Test data','Quadratic model','Location','se')
hold off

%Find the pitch value that corresponds to the maximum airflow.
pitch(find(airflow==max(airflow)))


