root1     = "/mnt/358251B7513FAF65/Dataset/BioCop2013/Face";
% fname_x   = "/10022014/"
root_dest = "Canon EOS 5D Mark III/SAP50/2";
clc
% resize
% move to a folder
srcFiles = '/mnt/358251B7513FAF65/Dataset/BioCop2013/Face';
fList = dir(srcFiles); 
fList = fList(905:end);
disp(fList)
out = '/mnt/usb-ST6000DM_004-2EH11C_152D00539000-0:1-part1/face_256_biocop';
for i = 1 : size(fList)
    fname = fList(i).name;
    disp(fname)
%     Nfname = fullfile(fname,root_dest);
    xfname = fullfile(root1,fname);
    xfList = dir(xfname);
    xfList = xfList(3:end);
%     disp(xfname)
    for j = 1 : size(xfList)
        fname = xfList(j).name;
%         disp(fname)
        yfname = fullfile(xfname,fname);
        zfname = fullfile(yfname,root_dest);
%         disp(zfname)
        zlist = dir(fullfile(zfname, '*.jpg'));
        
        for k = 1:size(zlist)
           filename =  fullfile(zlist(k).folder, zlist(k).name);
           disp(zlist(k).name)
           img = imread(filename);
           img = imresize(img,[256 256]); 
           imshow(img);
           z_out = fullfile(out,zlist(k).name);
%            disp()
           imwrite(img, z_out)       
        end
            
    end     
end

