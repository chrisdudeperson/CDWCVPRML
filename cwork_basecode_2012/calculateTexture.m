function H = calculateTexture(normImg, Q)

greyimg = 0.3*normImg(:,:,1) + 0.59*normImg(:,:,2) + 0.11*normImg(:,:,3);

Kx = [ 1 0 -1; 2 0 -2; 1 0 -1];
Ky = Kx';

dy = conv2(greyimg, Kx, 'same');
dx = conv2(greyimg, Ky, 'same');

% 
t = atand(dy./dx);
t = t + 90;
t = t/180;


    bin = floor(t.*Q);
    vals=reshape(bin,1,size(bin,1)*size(bin,2));
    H = hist(vals,Q);
    H = H ./sum(H);

end