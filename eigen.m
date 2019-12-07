clear all
close all
clc

datapath = uigetdir('\\Client\C$\Users\pavannaik\Downloads\Project','select path of training images');
testpath = uigetdir('\\Client\C$\Users\pavannaik\Downloads\Project','select path of test images');
prompt = {'Enter test image name (a number between 1 to 10):'};
dlg_title = 'Input of PCA-Based Face Recognition System';
num_lines= 1;
def = {' '};
TestImage = inputdlg(prompt,dlg_title,num_lines,def);
TestImage = strcat(testpath,'\',char(TestImage),'.jpg');
recog_img = eigen_face_rec(datapath,TestImage);
selected_img = strcat(datapath,'\',recog_img);
select_img = imread(selected_img);
subplot(1,2,2);imshow(select_img);title('output');
test_img = imread(TestImage);
subplot(1,2,1);imshow(test_img);title('input');
result = strcat('the recognized image is : ',recog_img);
disp(result);