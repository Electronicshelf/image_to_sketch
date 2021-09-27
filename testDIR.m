% Folder = '/media/sdb2/train_celebAB/trainA_celeb';
Folder = '/media/sdb2/CelebAMask-HQ/CelebA-HQ-img';
% nF =  '/media/sdb2/train_celebAB/trainB_celeb_s';
nF = '/media/sdb2/CelebAMask-HQ-Sketch';
srcFiles = dir(fullfile(Folder,'*.jpg'));% the folder in which ur images exists

for i = 1 :size(srcFiles)
  filename = fullfile(Folder, srcFiles(i).name);
  Nfname = fullfile(nF, srcFiles(i).name);
  newSketch = img2sketch(filename);
  out = ((7/2.55)*(double(newSketch)));
  imshow(out)
  zz = min(newSketch(:));
  xx = max(newSketch(:));
%   imwrite(mat2gray(newSketch), Nfname);
  imwrite((out), Nfname);
end

% /home/electronicshelf/sketchB