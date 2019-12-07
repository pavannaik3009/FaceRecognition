clear all; clc
database=imageSet('database', 'recursive'); %database folder name data_new
hog_features=zeros(1000,46656);
no_of_people=size(database,2);
features_of_image=0;
for i=1:no_of_people
    images_of_person=database(i).Count;
    for j = 1:images_of_person
        features_of_image=features_of_image+1;
        hog_features(features_of_image,:) = extractHOGFeatures(read(database(i),j),'CellSize',[4 4]);
        name{features_of_image} = database(i).Description;    
    end
    %personIndex{i} = faceGallery(i).Description;     % keep this commented
end
hog_features(~any(hog_features,2),:)=[];
training_model = fitcecoc(hog_features,name);