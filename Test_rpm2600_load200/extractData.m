function [BSFC] = extractData(rpm,load,n)
numfiles = n;
mydata = cell(1, numfiles);
all_data = cell(1,numfiles);
BSFC = zeros(numfiles,1);
for k = 1:numfiles
    myfilename = sprintf('20170523-%drpm-load%d_doe_%d.txt', [rpm,load,k]);
    mydata{k} = importdata(myfilename);
    all_data{k} = mydata{k}.data;
    temp_in = all_data{1,k};
    for i = 1:size(temp_in,1)
        bsfc(i) = (2*temp_in(i,14)/1000*60*temp_in(i,1))/(temp_in(i,1)*2*pi/60*temp_in(i,3)/1000);
    end
    BSFC(k) = mean(bsfc);
end
end
