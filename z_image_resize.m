clear all;


klasor='C:\Program Files\MATLAB\R2024a\toolbox\nnet\cnn\zeliharuzgarturbini\dataset\images'; 
klasor_='C:\Program Files\MATLAB\R2024a\toolbox\nnet\cnn\zeliharuzgarturbini\dataset\images'; 
files=dir(fullfile(klasor,'*.jpg'));
for k = 1:numel(files)
    dosya_adi=files(k).name;
    testresmi=imread(fullfile(klasor,strcat(dosya_adi)));
    I2 = imresize(testresmi,[840 840]);
    thisFileName = dosya_adi;
    fullfilename=fullfile(klasor_,strcat(dosya_adi));
    imwrite(I2,fullfilename);
     
     
end