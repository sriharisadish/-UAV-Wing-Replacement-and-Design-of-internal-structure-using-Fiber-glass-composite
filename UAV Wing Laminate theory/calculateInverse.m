function A_inv = calculateInverse(A)
    % Check if the matrix is square
    [m, n] = size(A);
    if m ~= n
        error('Input matrix must be square for inversion.');
    end

    % Check if the matrix is non-singular (has a nonzero determinant)
    if det(A) == 0
        error('Matrix is singular and does not have an inverse.');
    end

    % Calculate the inverse of the matrix
    A_inv = inv(A);

    % Display the original matrix and its inverse
    disp('Original Matrix A:');
    disp(A);

    disp('Inverse of Matrix A:');
    disp(A_inv);
end
