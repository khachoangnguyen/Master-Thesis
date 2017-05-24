function matrix = matrixDesign_3var(x1_max,x1_min,x2_max,x2_min,x3_max,x3_min,a)

c1 = x1_max - abs(x1_max - x1_min)/2;
c2 = x2_max - abs(x2_max - x2_min)/2;
c3 = x3_max - abs(x3_max - x3_min)/2;
matrix = [x1_min x2_min x3_min;
          x1_min x2_min x3_max;
          x1_min x2_max x3_min;
          x1_min x2_max x3_max;
          x1_max x2_min x3_min;
          x1_max x2_min x3_max;
          x1_max x2_max x3_min;
          x1_max x2_max x3_max;
          c1      c2      c3;
          c1      c2      c3;
          c1      c2      c3;
          c1      c2      c3;
          c1      c2      c3;
          c1      c2      c3;
          c1-a    0       0;
          c1+a    0       0;
          0       c2-a    0;
          0       c2+a    0;
          0       0       c3-a;
          0       0       c3+a];

end