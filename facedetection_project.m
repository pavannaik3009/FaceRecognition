facedetect=vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[100,100],'MergeThreshold',5);
I=imread('Divya_0.jpg');
%I=imrotate(I,90);
subplot(1,2,1),imshow(I);
bbox=facedetect(I);
I = insertShape(I,'rectangle',bbox,'LineWidth',10);
%I=imrotate(I,-90);
subplot(1,2,2),imshow(I);
 %hold on
 %I = insertObjectAnnotation(I,'rectangle',new_face_location,found_name,'LineWidth',10);
 %for i=1:size(BB,1)
     %rectangle('Position',BB(i,:),'linewidth',3,'linestyle','-','edgecolor','r');
 %end
title('Face Detected');
hold off