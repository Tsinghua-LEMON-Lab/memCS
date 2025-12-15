function H = sparity_enhance_mat_gen(N, m)
    % Syntax:
    %   H = sparity_enhance_mat_gen(N, m)
    %
    % Inputs:
    %   N - Signal length, must be a power of 2
    %   m - Number of wavelet decomposition levels, integer, with 2^m <= N
    %
    % Output:
    %   H - N×N m-level Haar wavelet transform matrix
    %
    % Examples:
    %   H = sparity_enhance_mat_gen(8, 2); % Generate 8×8 2-level Haar transform matrix
    %   H = sparity_enhance_mat_gen(16, 3); % Generate 16×16 3-level Haar transform matrix

    % Validate number of input arguments
    if nargin < 2
        error('Two input arguments are required: N and m');
    end

    % Check that N is a power of 2
    log2N = log2(N);
    if floor(log2N) ~= log2N || N <= 0
        error('N must be a positive power of 2');
    end

    % Check that m is a positive integer and 2^m <= N
    if floor(m) ~= m || m < 1
        error('m must be a positive integer');
    end

    if 2^m > N
        error('m must satisfy 2^m <= N');
    end

    % Initialize matrix
    % H = zeros(N, N);

    % Generate 1-level Haar transform matrix as the base
    H_level1 = haarMatrix_1(N);

    % If only 1-level transform is requested, return it directly
    if m == 1
        H = H_level1;
        return;
    else
        % H(N/2+1:N,:) = H_level1(N/2+1:N,:);
        H = H_level1;
        remain_rows = 1:N/2;
        norm_factor = 1 / sqrt(2);
        for i = 1:m-1
            L = length(remain_rows);
            norm_factor = norm_factor / sqrt(2);
            H(1:L,:) = 0;
            h = [norm_factor * ones(1,2^i) norm_factor * ones(1,2^i)];
            g = [norm_factor * ones(1,2^i) -norm_factor * ones(1,2^i)];
            L_h = 2^(i+1);
            for j = 1:1:L/2
                H(j, L_h*(j-1)+1: L_h*j) = h;
                H(L/2 + j, L_h*(j-1)+1: L_h*j) = g;
            end
            remain_rows = remain_rows(1:L/2);
        end
    end

end
