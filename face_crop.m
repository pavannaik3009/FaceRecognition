I=imread('Pic.jpg');
facedetect=vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[100,100]);
bbox=facedetect(I);
[multipleface,n]=size(bbox);
for k=1:multipleface
    cropedface=imcrop(I,[bbox(k,1),bbox(k,2),bbox(k,3),bbox(k,4)]);
    resized=imresize(cropedface,[150,150]);
    imwrite(resized,sprintf('face_%d.jpg',k))
end