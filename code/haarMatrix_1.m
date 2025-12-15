% 1st-order wavelet transform matrix
function H = haarMatrix_1(N)

    if (mod(N, 2) ~= 0)
        error('Haar matrix size must be even.');
    end
    
    % Define Haar wavelet filters
    h = [1 1]/sqrt(2); % low-pass filter
    g = [1 -1]/sqrt(2); % high-pass filter
    H = zeros(N, N);
    
    for i = 1 : N/2
        H(i, 2*i - 1: 2*i) = h;
        H(N/2 + i, 2*i - 1: 2*i) = g;
    end
    
    %     H = 1;
    %     while size(H, 1) < N
    %         H = kron([1 1; 1 -1], H) / sqrt(2);
    %     end
end