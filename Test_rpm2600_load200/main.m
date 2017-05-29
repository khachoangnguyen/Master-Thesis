clear all
clc
tic
mm = 5;
dd = 23;
speed = [1600];
load = [200];
ranges = [0.1, 0.9; 1100, 1400; -4, 13];
DOE_3var(mm,dd,speed,load,ranges)
toc