function F=ComputeRGBHistogram(imgNorm,Q)

    qimg=double(imgNorm)./256;
    qimg=floor(qimg.*Q);

    bin = qimg(:,:,1)*Q^2 + qimg(:,:,2)*Q^1 + qimg(:,:,3);
    vals=reshape(bin,1,size(bin,1)*size(bin,2));
    H = hist(vals,Q^3);
    H = H ./sum(H);
    F=H;
return;