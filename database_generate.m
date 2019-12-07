clear; clc;
tic;
database=imageSet('data/Durga');
imagesize=150;
facedetect=vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[100,100],'MergeThreshold',4);
s=zeros(imagesize,imagesize,3,1000);
number_of_images=0;
a=zeros(1,4);
for i=1:database.Count
    to_crop=read(database,i);
    for j=1:4
        to_crop=imrotate(to_crop,(j-1)*90);
        bbox=facedetect(to_crop);
        [multipleface,corners]=size(bbox);
        for k=1:multipleface
            if multipleface>0
                a(1)=bbox(k,1)-0.1*bbox(k,3);
                a(2)=bbox(k,2)-0.1*bbox(k,4);
                a(3)=1.2*bbox(k,3);
                a(4)=1.2*bbox(k,4);
                cropedface=imcrop(to_crop,a);
                resized=imresize(cropedface,[imagesize,imagesize]);
                imwrite(resized,sprintf('%d_%d_%d.jpg',i,j,k))
                number_of_images=number_of_images+1;
                s(:,:,:,number_of_images)=resized;
            end
        end
    end
end
s(:,:,:,~any(s,[1,2,3]))=[];
toc