function A_quantized = meas_matrix_mod(A, B, std_value)

    if B <= 0 || floor(B) ~= B
        error('B must be a positive integer');
    end
    
    if std_value <= 0
        error('std_value must be positive');
    end
    
    % Flatten the matrix into a vector for processing
    A_flat = A(:);
    
    % Find the minimum and maximum of the matrix
    min_val = min(A_flat);
    max_val = max(A_flat);
    
    % If all elements are identical, return immediately
    if min_val == max_val
        A_quantized = zeros(size(A));
        warning('All elements in the input matrix are identical; returning zero matrix');
        return;
    end
    
    % Compute the number of quantization levels
    num_levels = 2^B;
    
    % Normalize data to the range [0, 1]
    A_normalized = (A_flat - min_val) / (max_val - min_val);
    
    % Quantize to num_levels levels
    quantized_indices = round(A_normalized * (num_levels - 1));
    
    % Map quantized indices back to [0, 1]
    A_quantized_normalized = quantized_indices / (num_levels - 1);
    
    % Map normalized values back to the original range
    A_quantized_flat = A_quantized_normalized * (max_val - min_val) + min_val;
    
    % Reshape back to the original matrix shape
    A_quantized_temp = reshape(A_quantized_flat, size(A));
    
    % Standardize: subtract mean and divide by standard deviation
    current_mean = mean(A_quantized_temp(:));
    current_std = std(A_quantized_temp(:));
    
    if current_std == 0
        A_quantized = zeros(size(A));
        warning('Standard deviation of quantized matrix is 0; standardization impossible');
        return;
    end
    
    % Standardize to zero mean and unit variance
    A_standardized = (A_quantized_temp - current_mean) / current_std;
    
    % Scale to the target standard deviation
    A_quantized = A_standardized * std_value;
    
    % Verification
    final_mean = mean(A_quantized(:));
    final_std = std(A_quantized(:));
    unique_values = length(unique(A_quantized(:)));
    
    fprintf('Quantization, scaling, and centering completed:\n');
    fprintf('  Target quantization levels: %d\n', num_levels);
    fprintf('  Actual number of distinct values: %d\n', unique_values);
    fprintf('  Target standard deviation: %.6f\n', std_value);
    fprintf('  Actual standard deviation: %.6f\n', final_std);
    fprintf('  Final mean: %.6f (should be close to 0)\n', final_mean);
end