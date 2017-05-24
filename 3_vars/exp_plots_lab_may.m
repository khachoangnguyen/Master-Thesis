%% 
close all
% clear all

font_size_ticks = 16;
set(0,'DefaultFigureWindowStyle','docked')


font_size = 20;
font_size_2 = 20;
line_width = 2;
%% Read excel file
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Model validation data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% num = importdata('test_data.xlsx');
% num = importdata('test_data_25102016.xlsx'); %speed, load and VGT open-loop
% num = num.x1400Rpm;
% num = num.x1600Rpm;
% num = importdata('test_data_29102016.xlsx'); % VGT data
% num = num.VGTtest;
num = importdata('test_data.xlsx');
num = num.textdata.Sheet1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controllers testing
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% num = importdata('test_data_18112016.xlsx'); % VGT data
% num = num.PID;
% num = num.PID_act;
% num = num.MRAC;
% num = num.MRAC_act;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Controllers testing
% num = importdata('test_data_24112016.xlsx'); % VGT data
% num = num.PID;
% num = num.PID_act;
% num = num.MRAC;
% num = num.MRAC_act;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Save data into variables
if 1
    read_start = 11; % might vary depending which row data starts apear in excel file
speed_ref = cellfun(@str2num,num(read_start:end,2));
speed_exp = cellfun(@str2num,num(read_start:end,3));
torque_ref = cellfun(@str2num,num(read_start:end,4));
torque_exp =cellfun(@str2num,num(read_start:end,5));
boost_ref = cellfun(@str2num,num(read_start:end,6))+1.013;
boost_exp = cellfun(@str2num,num(read_start:end,7))+1.013;
vgt_ref =cellfun(@str2num,num(read_start:end,16))./4.2;
vgt_exp =cellfun(@str2num,num(read_start:end,17))./4.2;

% vgt_ref =cellfun(@str2num,num(read_start:end,12))./3.5; %older version
% vgt_exp =cellfun(@str2num,num(read_start:end,13))./3.5;

cr_pressure_ref =cellfun(@str2num,num(read_start:end,11));
cr_pressure_exp =cellfun(@str2num,num(read_start:end,13));
cr_pressure_control_exp =cellfun(@str2num,num(read_start:end,12));

p_x_exp =cellfun(@str2num,num(read_start:end,9))+1.013;

% bsfc_exp =cellfun(@str2num,num(8:end,14))./3600; %[g/h] %older version
% afr_exp =cellfun(@str2num,num(8:end,read_start));
fuel_flow_exp =cellfun(@str2num,num(read_start:end,15))./3600; %[g/h]
afr_exp =cellfun(@str2num,num(read_start:end,19));
end
% Filtering
% close all
scaling=30;
coeff24hMA = ones(1, scaling)/scaling;
speed_filt = filter(coeff24hMA, 1, speed_exp);
boost_filt = filter(coeff24hMA, 1, boost_exp);
boost_ref_filt = filter(coeff24hMA, 1, boost_ref);
torque_exp_filt =filter(coeff24hMA, 1, torque_exp);
cr_pressure_filt = filter(coeff24hMA, 1, cr_pressure_exp);
cr_pressure_ref_filt = filter(coeff24hMA, 1, cr_pressure_ref);
% cr_pressure_control_exp_filt = filter(coeff24hMA, 1, cr_pressure_control_exp);

p_x_filt = filter(coeff24hMA, 1, p_x_exp);

afr_filt = filter(coeff24hMA, 1, afr_exp);

scaling = 20;
coeff24hMA = ones(1, scaling)/scaling;
vgt_ref_filt = filter(coeff24hMA, 1, vgt_ref);
vgt_exp_filt = filter(coeff24hMA, 1, vgt_exp);
% plot(speed_filt)
% cellfun(@str2num,d)


% Tests, Combustion Engine Lab (CEL) Oct 2016
% close all
time_exp = 1:length(speed_ref);
time_exp = time_exp/10;

t_start = 20;
% t_end = 250000;
speed_filt_t = ones(1,length(speed_filt));
speed_filt_t(t_start:end) = speed_filt(1:length(speed_filt)-t_start+1);

%% Plot data
close all

figure
set(gcf, 'color', 'w')
subplot(311)
plot(time_exp,speed_ref,time_exp,speed_exp,time_exp,speed_filt,'k')
% hold on
plot(time_exp,speed_ref,time_exp,speed_filt,'k')
legend('reference','measured','Filtered')
title('Engine speed')
ylabel('Speed (rpm)','Fontsize',font_size)
xlabel('Time (sec)','Fontsize',font_size)
% ylim([800 2000])
% ylim([1400 1600])
grid on

subplot(312)
plot(time_exp,torque_ref,time_exp,torque_exp)
% hold on
plot(time_exp,torque_ref,time_exp,torque_exp_filt)
title('Torque')
ylabel('Torque (Nm)','Fontsize',font_size)
xlabel('Time (sec)','Fontsize',font_size)
% ylim([800 1600])
grid on

subplot(313)
plot(time_exp,fuel_flow_exp)
title('Fuel consumption')
ylabel('Fuel flow (g/s)','Fontsize',font_size)
xlabel('Time (sec)','Fontsize',font_size)
% ylim([800 1600])
grid on

figure
subplot(211)
% plot(time_exp,boost_ref,time_exp,boost_exp)
% hold on
plot(time_exp,boost_ref_filt,'k',time_exp,boost_filt)
legend('reference','Boost filtered')
title('Boost pressure')
ylabel('Boost (bar)','Fontsize',font_size)
xlabel('Time (sec)','Fontsize',font_size)
ylim([1.01 1.6])
grid on

subplot(212)
plot(time_exp,vgt_exp_filt,time_exp,vgt_ref_filt,'k')
legend('measured position','controller signal')
title('VGT control')
ylabel('VGT position (V)','Fontsize',font_size)
xlabel('Time (sec)','Fontsize',font_size)
% ylim([1.01 1.6])
grid on

figure
subplot(211)
plot(time_exp,cr_pressure_ref,time_exp,cr_pressure_exp)
% hold on
plot(time_exp,cr_pressure_ref_filt,time_exp,cr_pressure_filt)
legend('reference','measured')
title('CR pressure')
ylabel('CR pressure (bar)','Fontsize',font_size)
xlabel('Time (sec)','Fontsize',font_size)
% ylim([1.01 1.6])
grid on

subplot(212)
plot(time_exp,cr_pressure_control_exp)
% hold on
% legend('reference','measured')
title('CR control signal')
% ylabel('CR pressure (bar)','Fontsize',font_size)
xlabel('Time (sec)','Fontsize',font_size)
% ylim([1.01 1.6])
grid on

figure
plot(time_exp,afr_exp./14.6, time_exp,afr_filt./14.6,'k')
% legend('reference','measured')
title('Lambda')
ylabel('Lambda','Fontsize',font_size)
xlabel('Time (sec)','Fontsize',font_size)
% ylim([1.01 1.6])
grid on
%% Lambda
close all
figure
set(gcf, 'color', 'w')
plot(time_exp+150,afr_exp./14.6,'k')
% legend('reference','measured')
title('Lambda')
ylabel('Lambda','Fontsize',font_size)
xlabel('Time (sec)','Fontsize',font_size)
% ylim([1.01 1.6])
% xlim([440 540])
grid on
