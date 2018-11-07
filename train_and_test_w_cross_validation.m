function [n_correct_naive, n_correct_TAN, n_test_size] = train_and_test_w_cross_validation(data_mat, meta, indices_set)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
n_folds = length(indices_set);
no_data_points = size(data_mat, 1);
for i = 1:n_folds
    disp(['Working on fold number ', num2str(i), ' ...']);
    test_indices = indices_set{i};
    training_indices{i} = setdiff([1:no_data_points], test_indices);
    train_data = data_mat(training_indices{i}, :);
    test_data  = data_mat(test_indices, :);
    actual_class = test_data(:, end);
    
    [predicted_class_naive, ~] = naive_bayes_classification(train_data, test_data, meta);
    [predicted_class_TAN,   ~]   = TAN_classification(train_data, test_data, meta);
    n_correct_naive(i) = get_num_of_correct_classifications(actual_class, predicted_class_naive);
    n_correct_TAN(i)   = get_num_of_correct_classifications(actual_class, predicted_class_TAN);
    n_test_size(i)     = size(test_data, 1);
end

end

