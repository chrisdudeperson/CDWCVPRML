img = imread('/Users/chriswillis10/Documents/CVPR/MSRC_ObjCategImageDatabase_v2/Images/10_10_s.bmp');
normimg = double(img)./255
 
greyimg = 0.3*img(:,:,1) + 0.59*img(:,:,2) + 0.11*img(:,:,3);

Kx = [ 1 0 -1; 2 0 -2; 1 0 -1];
Ky = Kx'

dy = conv2(greyimg, Kx, 'same');
dx = conv2(greyimg, Ky, 'same');

angle = atand(dy./dx)
angle = angle + 90;
angle = angle/180

    Q = 4;
    bin = floor(angle.*Q);
    vals=reshape(bin,1,size(bin,1)*size(bin,2));
    H = hist(vals,Q);
    H = H ./sum(H);
    F=H;
