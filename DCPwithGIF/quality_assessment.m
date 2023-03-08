function h = quality_assessment(image1,image2,image3)
Entropy1 = entropy(image1);
Entropy2 = entropy(image2);
Entropy3 = entropy(image3);

NIQE1 = niqe(image1);
NIQE2 = niqe(image2);
NIQE3 = niqe(image3);

PIQE1 = piqe(image1);
PIQE2 = piqe(image2);
PIQE3 = piqe(image3);

row1 = [Entropy1,Entropy2,Entropy3];
row2 = [NIQE1,NIQE2,NIQE3];
row3 = [PIQE1,PIQE2,PIQE3];
% row4 = [MSE1,MSE2,MSE3];


data=[row1;row2;row3];

images = {'Original Image','DCP ','DCPwith GIF'};
methods = {'Entropy','NIQE','PIQE'};
column_name=strcat(images);
row_name=strcat(methods);

set(figure(2),'position',[200 200 650 200]);
uitable(gcf,'Data',data,'Position',[20 20 600 150],'Columnname',column_name,'Rowname',row_name);

h = 1;

end