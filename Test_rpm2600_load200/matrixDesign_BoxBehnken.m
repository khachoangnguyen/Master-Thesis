function [matrix,c1,c2,c3] =  matrixDesign_BoxBehnken(range_x1,range_x2,range_x3)

x1_min = min(range_x1); 
x1_max = max(range_x1); 

x2_max = max(range_x2);
x2_min = min(range_x2);

x3_min = min(range_x3); 
x3_max = max(range_x3); 
% Center points
c1 = x1_max - abs(x1_max - x1_min)/2;
c2 = x2_max - abs(x2_max - x2_min)/2;
c3 = x3_max - abs(x3_max - x3_min)/2;

matrix = [x1_max c2     x3_max;
          c1     c2       c3;
          c1     x2_max x3_max;
          x1_max x2_min   c3;
          x1_max x2_max   c3;
          x1_min x2_min   c3;
          c1     x2_max x3_min;
          x1_min c2     x3_max;
          c1     c2       c3;
          c1     c2       c3;
          c1     x2_min x3_min;
          c1     x2_min x3_max;
          x1_min x2_max   c3;
          x1_min c2     x3_min;
          x1_max c2     x3_min];
      
%  matrix = [x1_max c2     x3_max;
%           c1     c2       c3;
%           c1     x2_max x3_max;
%           x1_max x2_min   c3;
%           x1_max x2_max   c3;
%           x1_min x2_min   c3;
%           c1     x2_max x3_min;
%           x1_min c2     x3_max;
%           c1     c2       c3;
%           c1     c2       c3;
%           c1     x2_min x3_min;
%           c1     x2_min x3_max;
%           x1_min x2_max   c3;
%           x1_min c2     x3_min;
%           x1_max c2     x3_min];     

end