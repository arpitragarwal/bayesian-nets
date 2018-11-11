function bayes(train_filename , test_filename, which_algo)

if ~exist('train_filename','var')
      train_filename = 'data/vote_train.arff.txt';
end
if ~exist('test_filename','var')
      test_filename = 'data/vote_test.arff.txt';
end
if ~exist('which_algo','var')
      which_algo = 'n';
end

[train_data, meta] = read_arff_file(train_filename);
[test_data, ~] = read_arff_file(test_filename);

if strcmp(which_algo, 'n')
    [predicted_class, probability] = naive_bayes_classification(train_data, test_data, meta);
elseif strcmp(which_algo, 't')
    [predicted_class, probability] = TAN_classification(train_data, test_data, meta);
end

% evaluating accuracy
actual_class = test_data(:, end);
n_correctly_classified = get_num_of_correct_classifications(actual_class, predicted_class);

% printing outputs
print_classifier_info(meta);
print_labels_and_probabilities(predicted_class, actual_class, probability, n_correctly_classified);
end

