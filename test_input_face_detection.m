% clear ; 
clc
input=imread('2.jpg'); %test image here
imshow(input);title('test');figure;
input=imgaussfilt(input);
[n,m]=size(input(:,:,1));
facedetect=vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[100,100],'MergeThreshold',5);
face_detected=0;
face_location=zeros(100,5);
faces_1=zeros(150,150,3,100);
for i=1:4
    degree=(i-1)*90;
    to_crop=imrotate(input,degree);
    bbox=facedetect(to_crop);
    [multipleface,dummy]=size(bbox);
    for k=1:multipleface
            if multipleface>0
                face_detected=face_detected+1;
                face_location(face_detected,1:4)=bbox(k,:);
                face_location(face_detected,5)=degree;
                a(1)=bbox(k,1)-0.1*bbox(k,3);
                a(2)=bbox(k,2)-0.1*bbox(k,4);
                a(3)=1.2*bbox(k,3);
                a(4)=1.2*bbox(k,4);
                cropedface=imcrop(to_crop,a);
                resized=imresize(cropedface,[150,150]);
                faces_1(:,:,:,face_detected)=resized;
            end
    end
end
faces_1(:,:,:,~any(faces_1,[1,2,3]))=[];
faces_1=uint8(faces_1);
face_location(~any(face_location,2),:)=[];
clear bbox
facedetect=vision.CascadeObjectDetector('FrontalFaceCART','MinSize',[100,100],'MergeThreshold',9);
faces_2=zeros(150,150,3,size(faces_1,4));

pnames = ["Deep" "Dhruvi" "Harshul" "Kishan" "Nikhil" "Suprit";
         "Absent" "Absent" "Absent" "Absent" "Absent" "Absent"];

new_face_location=[0 0 0 0];
for i=1:size(faces_1,4)
    bbox=facedetect(faces_1(:,:,:,i));
    if size(bbox,1)~=0
        faces_2(:,:,:,i)=faces_1(:,:,:,i);
        test_image_hog = extractHOGFeatures(uint8(faces_2(:,:,:,i)),'CellSize',[4 4]);
        found_name = predict(training_model,test_image_hog);
        
        ind = find(any(pnames == found_name{1}));
        pnames(2,ind) = "Present";
        
        
        theta = face_location(i,5);
        x=face_location(i,1);
        y=face_location(i,2);
        w=face_location(i,3);
        h=face_location(i,4);
               
        if theta==0
            new_face_location=[x y w h];
        elseif theta==90
            new_face_location=[m-(y+h) x h w];
        elseif theta==180
            new_face_location=[m-(x+w) n-(y+h) w h];
        elseif theta==270
            new_face_location=[y n-(x+w) h w];
        end
        
         input = insertObjectAnnotation(input,'rectangle',new_face_location,found_name,'LineWidth',10,'Color','yellow','FontSize',50); 
         imshow(uint8(input));title('Faces Detected')
    end
end
 pnames
